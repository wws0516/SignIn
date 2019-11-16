<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="${ctx}/css/bootstrap.min.css" type="text/css"></link>
    <link rel="stylesheet" href="${ctx}/css/loginStyle.css" type="text/css"></link>
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript"></script>

</head>
<body>
<form class="form-horizontal" action="${ctx}/user/login.action" method="post">
    <div class="login">
        <div class="login-main">
            <div class="login-top">
                <img class="img" src="images/top.png" alt=""/>
                <h1>WEB签到管理系统</h1>
                <input type="text" name="login" placeholder="用户名" required="true" >
                <input type="password" name="password"  placeholder="密码" required="true">
                <div class="login-bottom">
                    <div id="errMsg" style="color: red;">${errMsg}</div>
                    <div class="clear"> </div>
                </div>
                <input type="submit" value="登录" style="width: 100px"/>
                <input type="button" value="注册" style="width: 100px; border: none" onclick="javascript:window.location.href='register.jsp'" />
            </div>
        </div>
    </div>
</form>
</body>
</html>
