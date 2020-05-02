<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.huang.Dao.UserDao" %>
<%@ page import="com.huang.factory.DaoFactory" %>
<%@ page import="com.huang.entity.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	boolean t=false;
	UserDao userDao= DaoFactory.getUserDao();
	User user = new User(username,password);
	t=userDao.adduser(user);
	if(t){
			out.print("添加成功!!!");
	}else{
%>
<%
	response.sendRedirect("jia.jsp");
	}
	
%>
		
</body>
</html>