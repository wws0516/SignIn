<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../common/common.jspf" %>

        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


    <title>supplier list page</title>
    <script type="text/javascript">

        var url = "${proPath}/base/jsp/admin/attendanceList.action";

            /**获取月份有多少天**/
        function getDaysInOneMonth(year, month) {
            month = parseInt(month, 10);
            var d = new Date(year, month, 0);
            return d.getDate();
        }

        function search() {
            var nianfen = $("#cboNianFen").val();
            var yuefen = $("#cboYueFen").val();
            if (yuefen<10) yuefen='0'+yuefen;
            var Ri = $("#cboRi").val();
            var signtime = nianfen+"-"+yuefen+"-"+Ri;
            var urll =url+"?signtime="+signtime;
            location=urll;
        }

        function searchLogin() {
            var login = document.getElementById("login").value;
            var url="${proPath}/attendance/selectOneUser.action";
            url=url+"?login="+login;
            location=url;
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
        function bangDingNianFen() {
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
        }

        $(function(){
            var url = "${proPath}/attendance/selectPage.action";
            var urls = document.location.toString();
            var arrUrl = urls.split("?");
            var para = arrUrl[1];
            if (para==null) {
                bangDingNianFen();
            }else {
                url= url+"?"+para;
                var nianfen = para.substr(9,4);
                var yuefen = para.substr(14,2);
                var Ri = para.substr(17,2);
                RiQiChange();
                $("#cboNianFen").val(parseInt(nianfen));
                $("#cboYueFen").val(parseInt(yuefen));
                $("#cboRi").val(Ri);
            }
            $('#dg').datagrid({

                url:url,
                striped:true,
                fitColumns:true,
                idField:'id',
                rownumbers:true,
                loadMsg:"加载中，请稍等...",
                pagination:true,
                pageSize:5,
                pageList:[2,5,10,15],
                toolbar: [{
                    iconCls: 'icon-add',
                    text:'查看',
                    handler: function(){
                        var rows = $('#dg').datagrid('getSelections');
                        if(rows.length!=1){
                            alert("请选择并且只能选择一条请假记录进行查看！");
                            return false;
                        }
                        if ($('#dg').datagrid("getSelected").attend==0){
                            alert("请勿选择出勤记录进行查看！");
                            return false;
                        }
                        parent.$('#win').window({
                            title:'查看请假信息',
                            width:600,
                            height:400,
                            modal:true,
                            content:"<iframe src='${proPath}/base/jsp/admin/LeaveSee.signin.signin.action' height='100%' width='100%' frameborder='0px' ></iframe>"
                        })
                    }
                    }],

                columns:[[
                    {checkbox:true},
                    {field:'id',title:'编号',width:100},
                    {field:'user',formatter:function (user) {
                                return user.name;
                            },title:'用户名称',width:100},
                    {field:'attend',formatter:function (attend) {
                            if (attend == 0)
                                return '出勤';
                            else return '<font color="red">请假</font>';
                        },title:'出勤情况',width:100}
                        ]]
            })

        });
    </script>

</head>
<body>
<div style="text-align: center;padding-top: 10px;">
    <div>
        <input type="text" id="login" name="login"/>
        <button style="height:20px;width:60px" onclick="searchLogin()">搜索</button>
    </div>
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
    <div  style="display: inline-block;" >
        <button style="height:20px;width:60px" onclick="search()"/>确定</button>
    </div>
</div>
<table id="dg"></table>


</body>
</html>