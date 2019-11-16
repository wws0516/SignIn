<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<link rel="stylesheet" href="${ctx}/css/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="${ctx}/css/jedate.css" type="text/css"></link>
<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx}/js/bootstrap.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.jedate.min.js"></script>
<style type="text/css">
#header tr th {
	text-align: center;
	width: 90px;
	font-size: 15px;
	font-weight: 600;
	background: #fafafa;
}
#KaoQinheader tr th{
    background: rgb(67, 142, 185);
    color: white;
    max-width: 100px;
    min-width: 50px;
    text-align: center;
}
#tbodyGeRenPaiBanXinXi tr td {
	height: 80px;
	text-align: center;
}
.tbody tr td{
text-align: center;
    font-weight: 800;
    font-size: 17px;
    color: #736e6e;
}
.showdiv {
	display: none;
}

.divBanZu {
	font-size: 15px;
	font-weight: 600;
}

.BanDuanTiShi {
	z-index: 100;
	background: rgb(52, 154, 184);
	text-align: center;
	max-width: 350px;
	min-width: 200px;
	position: absolute;
	color: white;
	position: absolute;
	position: absolute;
}

.tubiao {
	position: relative;
	width: 0;
	height: 0;
	border-color: rgba(199, 28, 28, 0);
	border-style: solid;
	bottom: 0;
	left: 47%;
	top: 29px;
	margin-left: -5px;
	border-width: 30px 26px 0px 0px;
	border-top-color: rgb(52, 154, 184);
}

.banci {
	padding-top: 10px;
	font-size: 20px;
}
.thismydiv{
    margin-top: 5px;
    font-size: 10px;
    font-weight: 100;
    color: red;
    }
    .myhiden{
    display: none;}
    .btn_buqian{
   background: #438eb9;
   color: white;}
</style>
<script type="text/javascript" >
    $(function() {
        var signtime  = '${signtimee}';
            var nianfen = signtime.substr(0,4);
            var yuefen = signtime.substr(5,2);
            $("#cboNianFen").val(parseInt(nianfen));
            $("#cboYueFen").val(parseInt(yuefen));

        RiQiChange();
	});

    function search() {
        var nianfen = $("#cboNianFen").val();
        var yuefen = $("#cboYueFen").val();
        if (yuefen<10) yuefen='0'+yuefen;
        var riqi = nianfen+'-'+yuefen+'-01';
        location='${ctx}/attendance/selectOneUser.signin.signin.action?signtime='+riqi+'';
    }

    /**日期加天数计算日期**/
    function addDate(date,days){
        var d=new Date(date);
        d.setDate(d.getDate()+days);
        var month=d.getMonth()+1;
        var day = d.getDate();
        if(month<10){
            month = "0"+month;
        }
        if(day<10){
            day = "0"+day;
        }
        var val = d.getFullYear()+"-"+month+"-"+day;
        return val;
    }

    /**获取月份有多少天**/
    function getDaysInOneMonth(year, month) {
        month = parseInt(month, 10);
        var d = new Date(year, month, 0);
        return d.getDate();
    }

    function RiQiChange() {
        <%--var attendanceList = <%=request.getAttribute("attendanceList")%>;--%>
        var nianfen = $("#cboNianFen").val();
        var yuefen = $("#cboYueFen").val();
        var yuediyitian = nianfen + "/" + yuefen + "/01";
        var yuezuihouyitian = nianfen + "-" + yuefen + "-" +getDaysInOneMonth(nianfen, yuefen);
        var chuyi = new Date(yuediyitian);
        var yuewei = new Date(yuezuihouyitian);
        var diyitianxinqi = (chuyi.getDay() == 0 ? 7 : chuyi.getDay());
        var zuihouyitianxinqi = yuewei.getDay();
        var one = addDate(yuediyitian, ( 0 - diyitianxinqi));
        var tianshu = getDaysInOneMonth(nianfen, yuefen);//获取月份天数
        var tds = $("#tbodyGeRenPaiBanXinXi tr td");
        var j;
        var data = '${data}';
        var obj = eval("("+data+")");
        for (j=0;j<obj.length;j++) {
            if ((obj[j].signtime.month + 1) < 10) obj[j].signtime.month = "0" + (obj[j].signtime.month + 1);
            if (obj[j].signtime.day < 10) obj[j].signtime.day = "0" + obj[j].signtime.day;
        }
        for (i=0 ; i < 42 ;i++) {
            $(tds[i]).empty();
            if (i>=diyitianxinqi && i < diyitianxinqi+getDaysInOneMonth(nianfen,yuefen)) {
                var riqi = addDate(one, i);
                $(tds[i]).attr("id", riqi);
                $(tds[i]).append(
                    "<span style='font-weight: 900;color: #999!important;'>"
                    + riqi + "</span>");
                for (j=0;j<obj.length;j++){
                    var a = obj[j].signtime.year+"-"+(obj[j].signtime.month)+"-"+obj[j].signtime.day;
                    if (riqi== a) {
						if (obj[j].attend == 0) {
                            $(tds[i]).append(
                                '<img src="./images/u=2469884206,3642220943&fm=26&gp=0.jpg" width="30px" height="30px"/>');
                        } else {
                            var href="${ctx}/base/jsp/admin/LeaveSee1.signin.signin.action?user="+obj[j].user.name+"&signtime="+a+"&reason="+obj[j].leave.reason;
                            $(tds[i]).append(
                                '<a href='+href+' ><img src="./images/timg.jpeg" width="20px" height="20px"/></a>');
                        }
						}
                    }
        }
    }
	}
</script>

<body style="text-align: center" >
	<div >
		该用户考勤记录为：
	</div>

	<div style="overflow-y: scroll;max-height: 550px;">
		<div style="text-align: center;padding-top: 10px;">
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
				<select id="cboYueFen" onchange=""
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
			<div>
				<button style="height:20px;width:60px" onclick="search()" >确定</button>
			</div>
		</div>


		<div style="max-width: 1130px;padding-left: 10px;overflow: auto;">
		<table border="1" class="table"style="max-width: 2000px;min-width: 1120px;" id="tbGudinglunban">
				<thead id="KaoQinheader">
					 
				</thead>
				<tbody id="tbodyKaoQin" class="tbody">
				</tbody>
			</table>
		</div>
		<div style="padding-left: 10px;">
			<table border="1" class="table"
				style=" max-width: 99%;min-width: 99%;" id="tbGudinglunban1">
				<thead id="header">
					<tr>
						<th>星期日</th>
						<th>星期一</th>
						<th>星期二</th>
						<th>星期三</th>
						<th>星期四</th>
						<th>星期五</th>
						<th>星期六</th>
					</tr>
				</thead>
				<tbody id="tbodyGeRenPaiBanXinXi" class="tbody">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>

				</tbody>
			</table>
		</div>
	</div>
</body>
</html>

