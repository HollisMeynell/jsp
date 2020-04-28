<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//获取用户信息
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	boolean t=false;
	UserDao  userDao=new UserDao();
	t=userDao.login(username,password);
	if(t){
	/*
	String url="jdbc:mysql://localhost:3306/db_shop?serverTimezone=UTC&characterEncoding=utf-8";
	String user="root";
	String PassWord="root";
		//1.加载驱动
		Class.forName("com.mysql.jdbc.Driver");
		//2.创建数据库的连接
		Connection conn=DriverManager.getConnection(url,user,PassWord);
		//String sql="select * from admin_info";
		//String sql="select * from admin_info where name='"+username+"' and pwd='"+password+"'";
		String sql="select * from admin_info where name=? and pwd=?";
		//3.创建语句容器
		//Statement st=conn.createStatement();
		//3.预处理的语句容器，执行效率高，可接受带SQL语句
		PreparedStatement pt=conn.prepareStatement(sql);
		pt.setString(1, username);
		pt.setString(2, password);
		//4.执行sql语句
		//ResultSet rs=st.executeQuery(sql);
		ResultSet rs=pt.executeQuery();
		//5.处理查询结果
		if(rs.next()){
			*/
		//第一步创建Cookie对象
		Cookie cookie1=new Cookie("username",username);
		Cookie cookie2=new Cookie("password",password);
		//第二步设置Cookie的有效期，以秒为单位
		cookie1.setMaxAge(24*60*60);
		cookie2.setMaxAge(24*60*60);
		//向客户端写Cookie
		response.addCookie(cookie1);
		response.addCookie(cookie2);
		session.setMaxInactiveInterval(60*5);
		session.setAttribute("username",username);
		/*
		//6.关闭连接
		rs.close();
		//st.close();
		pt.close();
		conn.close();
		*/
		%>
		<jsp:forward page="index.jsp"/>
	<%
		}else{
	%>
		<%--<jsp:forward page="jia.jsp"/>--%>
	<%
	response.sendRedirect("jia.jsp");
	}
%>
</body>
</html>