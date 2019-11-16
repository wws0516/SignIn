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

        function search() {
            var nianfen = $("#cboNianFen").val();
            var yuefen = $("#cboYueFen").val();
            if (yuefen<10) yuefen='0'+yuefen;
            var Ri = $("#cboRi").val();
            var signtime = nianfen+"-"+yuefen+"-"+Ri;
            var f = document.forms[0];
            f.action = f.action+signtime;
            f.submit();
        }
        /**获取月份有多少天**/
        function getDaysInOneMonth(year, month) {
            month = parseInt(month, 10);
            var d = new Date(year, month, 0);
            return d.getDate();
        }

    function RiQiChange() {
        var nianfen = $("#cboNianFen").val();
        var yuefen = $("#cboYueFen").val();
        var yuezuihouyitian = getDaysInOneMonth(nianfen, yuefen);
        var tds = $("#tbodyGeRenPaiBanXinXi tr td");
        $("#cboRi").empty();
        for ( var i = 1; i < yuezuihouyitian + 1; i++) {
            if (i<10) i='0'+i;
            var html = "<option value='" + i + "'>" + i
                + "日</option>";
            $("#cboRi").append(html);

        }
    }

    /** 绑定年份下拉框 **/
    $(function(){
        var date = new Date();
        var nianfen = date.getFullYear();
        var yue = date.getMonth();
        var Ri = date.getDate();
        if (Ri<10) Ri="0"+Ri;
        /*选上当前年月 */
        $("#cboNianFen").val(nianfen);
        $("#cboYueFen").val(yue + 1);
        RiQiChange();
        $("#cboRi").val(Ri);
    })


</script>
</head>
<body>
<div class="main-div">

        <form id="ff" method="post" action="${ctx}/leave/insertLeave.action?signtime=">


    	<!-- 隐藏域，保存id的值（编辑时候用） -->

        <table width="100%" id="general-table">
            <tr>
                <td class="label">请假人:</td>
                <td>
                    <input type="text" name="" value="${sessionScope.user.name}"></input>
                </td>
            </tr>
            <tr>
                <td class="label">请假时间:</td>
                <td>
                    <div  style="display: inline-block;">
                        <select id="cboNianFen" onchange=""
                                style="width: 100px;font-size: 18px; position: relative;top:4px;">
                            <option value="2015">2015年</option>
                            <option value="2016">2016年</option>
                            <option value="2017">2017年</option>
                            <option value="2018">2018年</option>
                            <option value="2019">2019年</option>
                            <option value="2020">2020年</option>
                            <option value="2021">2021年</option>
                            <option value="2022">2022年</option>
                            <option value="2023">2023年</option>
                        </select>
                    </div>
                    <div style="display: inline-block;">
                        <select id="cboYueFen" onchange="RiQiChange()"
                                style=" width: 100px;font-size: 18px; position: relative;top:4px;">
                            <option value="1">01月</option>
                            <option value="2">02月</option>
                            <option value="3">03月</option>
                            <option value="4">04月</option>
                            <option value="5">05月</option>
                            <option value="6">06月</option>
                            <option value="7">07月</option>
                            <option value="8">08月</option>
                            <option value="9">09月</option>
                            <option value="10">10月</option>
                            <option value="11">11月</option>
                            <option value="12">12月</option>
                        </select>
                    </div>
                    <div  style="display: inline-block;">
                        <select id="cboRi" style="width: 100px;font-size: 18px; position: relative;top:4px;">
                        </select>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="label">请假原因:</td>
                <td>
                    <input type="text" name="reason" cols="50" rows="8"></input>
                </td>
            </tr>

        </table>
        <div class="button-div">
            <input type="button" value=" 确定    " onclick="search()" />
            <input type="reset" value="  重置 " />
        </div>
    </form>
</div>

</body>
</html>
