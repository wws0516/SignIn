<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../common/common.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


    <script type="text/javascript">


    $(function(){
        var win = parent.$("iframe[title='我的请假记录']").get(0).contentWindow;
        var row = win.$('#dg').datagrid("getSelected");
        $('#ff').form('load',{
            id:row.id,
            leave_id:row.leave.leave_id,
            signtime:row.signtime,
            reason:row.leave.reason,
        });
        $("#btn").click(function() {
                $('#ff').form('submit',{
                    url : '${proPath}/attendance/update.action',
                    onSubmit : function() {
                        return true;
                    },
                    success : function(count) {
                        //可以定义为对应消息框
                        if(count>0){
                            alert("修改成功");
                        }else{
                            alert("修改失败");
                        }
                        parent.$("#win").window("close");
                        win.$("#dg").datagrid("reload");
                        win.$("#dg").datagrid("clearSelections");

                    },
                });

            });
    });

</script>
</head>
<body>
<h1>
    <div style="clear:both"></div>
</h1>
<div class="main-div">

        <form id="ff" method="post">

        <input type="hidden" id="id" name="id">

        <input type="hidden" id="leave_id" name="leave_id">

            <!-- 隐藏域，保存id的值（编辑时候用） -->

        <table width="100%" id="general-table">
            <tr>
                <td class="label">请假人:</td>
                <td>
                    <input name="name" type="text" value="${sessionScope.user.name}"></input>
                </td>
            </tr>
            <tr>
                <td class="label">请假时间:</td>
                <td>
                    <input type="text" id="signtime" name="signtime" ></input>
                </td>
            </tr>
            <tr>
                <td class="label">请假原因:</td>
                <td>
                    <input type="text" id="reason" name="reason" cols="50" rows="8" required="required"></input>
                </td>
            </tr>

        </table>
        <div class="button-div">
            <input id="btn" type="button" value=" 修改    " />
            <input type="reset" value="  重置 " />
        </div>
    </form>
</div>

</body>
</html>
