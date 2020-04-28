<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,Dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//1.获取用户表单输入信息
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	boolean t=false;
	UserDao  userDao=new UserDao();
	t=userDao.adduser(username,password);
	if(t){
	//2.访问数据库，向admin_info表添加一条记录
	/*
	if(username!=null && !username.isEmpty() && password!=null && !password.isEmpty()){
		String url="jdbc:mysql://localhost:3306/db_shop";
		String user="root";
		String PassWord="root";
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn=DriverManager.getConnection(url,user,PassWord);
		String sql="insert into admin_info (name,pwd) values(?,?)";
		PreparedStatement pt=conn.prepareStatement(sql);
		pt.setString(1,username);
		pt.setString(2,password);
		int n=pt.executeUpdate();
		if(n>0){
			*/
			//System.out.print("添加成功!!!");
			out.print("添加成功!!!");
			/*
			pt.close();
			conn.close();
				*/
		   }else{
		%>
	<%
	response.sendRedirect("jia.jsp");
	}
	
%>
		
</body>
</html>