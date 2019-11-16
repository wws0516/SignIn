<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="${ctx}/js/bootstrap.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctx}/js/jquery.jedate.min.js"></script>
    <script type="text/javascript" src="${ctx}/easyui/jquery.easyui.min.js"></script>



    <script type="text/javascript">

    $(function(){
        var win = parent.$("iframe[title='用户考勤记录']").get(0).contentWindow;
        var row = win.$('#dg').datagrid("getSelected");
        $('#ff').form('load',{
            name:row.user.name,
            signtime:row.signtime,
            reason:row.leave.reason,
        }
    )})


</script>
</head>
<body>
<h1>
    <div style="clear:both"></div>
</h1>
<div class="main-div">

        <form id="ff" method="post">

<input type="hidden" name="id">
    	<!-- 隐藏域，保存id的值（编辑时候用） -->

        <table width="100%" id="general-table">
            <tr>
                <td class="label">请假人:</td>
                <td>
                    <input name="name" value="${sessionScope.user.name}"></input>
                </td>
            </tr>
            <tr>
                <td class="label">请假时间:</td>
                <td>
                    <input type="date" name="signtime" ></input>
                </td>
            </tr>
            <tr>
                <td class="label">请假原因:</td>
                <td>
                    <input type="text" name="reason" cols="50" rows="8" required="required"></input>
                </td>
            </tr>

        </table>
    </form>
</div>

</body>
</html>
