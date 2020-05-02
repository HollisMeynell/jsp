<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.huang.factory.DaoFactory" %>
<%@ page import="com.huang.Dao.UserDao" %>
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
	UserDao userDao= DaoFactory.getUserDao();
	t=userDao.login(username,password);
	if(t){
		Cookie cookie1=new Cookie("username",username);
		Cookie cookie2=new Cookie("password",password);
		cookie1.setMaxAge(24*60*60);
		cookie2.setMaxAge(24*60*60);
		response.addCookie(cookie1);
		response.addCookie(cookie2);
		session.setMaxInactiveInterval(60*5);
		session.setAttribute("username",username);
		%>
		<jsp:forward page="../admin/index.jsp"/>
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