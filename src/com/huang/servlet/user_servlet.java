package com.huang.servlet;

import com.huang.Dao.UserDao;
import com.huang.entity.User;
import com.huang.factory.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;


@WebServlet(name = "user_servlet", urlPatterns = "/userservlet")
public class user_servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        String operate = "";
        operate = request.getParameter("operate");
        PrintWriter out = response.getWriter();
        ArrayList<User> users = null;
        String thisname = "";

        if ("login".equals(operate)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            if (username != null && password != null) {
                UserDao userDao = DaoFactory.getUserDao();
                Boolean flag = false;
                try {
                    flag = userDao.login(username, password);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (flag) {
                    Cookie Cunm = new Cookie("username", username);
                    Cookie Cupd = new Cookie("password", password);
                    Cunm.setMaxAge(24 * 60 * 60);
                    Cupd.setMaxAge(24 * 60 * 60);
                    response.addCookie(Cunm);
                    response.addCookie(Cupd);
                    session.setMaxInactiveInterval(60 * 5);
                    session.setAttribute("username", username);

                    response.sendRedirect("admin/index.jsp");
//                    getServletContext().getRequestDispatcher("/admin/index.jsp").forward(request,response);
                } else {
                    response.sendRedirect("admin/jia.jsp");
                }
            }
        } else if ("adduser".equals(operate)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            boolean flag = false;
            UserDao userDao = DaoFactory.getUserDao();
            User user = new User(username, password);
            try {
//                if (userDao.getId(username) == 0)
                    flag = userDao.adduser(user);
//                else out.print("用户名重复\n");
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (flag) {
                out.print("添加成功");
            } else {
                out.print("添加失败");
            }
        }else if("isuser".equals(operate)){
            String name = request.getParameter("name");
            UserDao dao = DaoFactory.getUserDao();
            int id = 0;
            try {
                id = dao.getId(name);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if(id == 0){
                out.write("true");
            }else{
                out.write("false");
            }
        } else if ("setuser".equals(operate)) {
            String username = request.getParameter("name");
            String yuanpwd = request.getParameter("ypwd");
            String password = request.getParameter("pwd");
            int id = Integer.valueOf(request.getParameter("id"));
            User user = new User(id, username, password);
            boolean flag = false;
            UserDao dao = DaoFactory.getUserDao();
            try {
                flag = dao.setuser(user, yuanpwd);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (flag) {
                out.print("修改成功");
            } else {
                out.print("修改失败,请检查原密码是否正确");
            }
        } else if ("queryall".equals(operate)) {
            String name = request.getParameter("name");
            int page = Integer.valueOf(request.getParameter("page"))-1;
            int size;
            if (request.getParameter("size") != null){
                size = Integer.valueOf(request.getParameter("size"));
            }else {
                size = 5;
            }
            if(users == null || !thisname.equals(name)){
                try {
                    users = DaoFactory.getUserDao().findUser(name);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                thisname = name;
            }
            if (users != null) {
                StringBuilder date = new StringBuilder("{\"user\":{");
//                int i = 1;
//                for (User u : users) {
//                    if (i != 1) {
//                        date.append(',');
//                    }
//                    date.append("\"" + (i++) + "\":{");
//                    date.append("\"id\":" + u.getId());
//                    date.append(",\"name\":\"" + u.getName() + '"');
//                    date.append("}");
//                }

                for (int i = 0;i+page*size < users.size() && i < size;i++){
                    if(i != 0){
                        date.append(',');
                    }
                    date.append("\"" + (i) + "\":{");
                    date.append("\"id\":" + users.get(i+page*size).getId());
                    date.append(",\"name\":\"" + users.get(i+page*size).getName() + '"');
                    date.append("}");
                }
                date.append("},\"page\":\""+(int)Math.ceil((double)users.size()/size*1.0)+"\",\"this\":\""+(page+1)+"\"}");
                out.write(new String(date));
            }
        } else if ("deleuser".equals(operate)) {
            int id = Integer.valueOf(request.getParameter("id"));
            UserDao dao = DaoFactory.getUserDao();
            boolean flag = false;
            try {
                flag = dao.delUser(id);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (flag)
                out.write("成功删除");
            else
                out.write("删除失败");
        } else if ("cc".equals(operate)) {
            out.write("cnmd");
        } else {
            out.print("请求异常");
        }
    }
}
