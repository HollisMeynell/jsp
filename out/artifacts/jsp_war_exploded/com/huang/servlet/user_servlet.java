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

@WebServlet(name = "user_servlet",urlPatterns = "/userservlet")
public class user_servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        String operate = "";
        operate = request.getParameter("operate");
        PrintWriter out = response.getWriter();

        if ("index".equals(operate)) {
            String username=request.getParameter("username");
            String password=request.getParameter("password");
            if(username !=null && password != null){
                UserDao userDao= DaoFactory.getUserDao();
                Boolean flag = false;
                try {
                    flag = userDao.login(username,password);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (flag){
                    Cookie Cunm = new Cookie("username",username);
                    Cookie Cupd = new Cookie("password",password);
                    Cunm.setMaxAge(24*60*60);Cupd.setMaxAge(24*60*60);
                    response.addCookie(Cunm);response.addCookie(Cupd);
                    session.setMaxInactiveInterval(60*5);
                    session.setAttribute("username",username);

                    request.getRequestDispatcher("admin/index.jsp").forward(request,response);
                }else {
                    response.sendRedirect("admin/jia.jsp");
                }
            }
        }
    }
}
