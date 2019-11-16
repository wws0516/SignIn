<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../common/common.jspf" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


	<title>main page</title>
	<script type="text/javascript">
        $(function() {
            $("a[title]").click(function() {
                var title = this.title;
                var text = this.href;
                //如果对应的面板已经存在，就选择，否则就添加新的面板
                if($('#tt').tabs("exists",title)){
                    $('#tt').tabs("select",title);
                }else{
                    $('#tt').tabs('add',{
                        title:title,
                        selected: true,
                        closable:true,
                        //href:xxx.jsp,
                        //可以加载内容填充到选项卡，页面有Js时，也可加载
                        content:"<iframe src='"+text+"' title='"+this.title+"' height='100%' width='100%' frameborder='0px' ></iframe>"

                    });
                }

                return false;

            });
        });

	</script>

</head>
<body class="easyui-layout">
<!-- ---------------------------------头部信息---------------------------------------------- -->
<div data-options="region:'north',title:'用户签到系统',split:true" style="height:150px;">
	欢迎您：${sessionScope.user.login}
</div>

<!-- -------------------------------------导航菜单------------------------------------- -->
<div data-options="region:'west',title:'导航菜单',split:true" style="width:180px;">

	<div id="aa" class="easyui-accordion" style="width:300px;height:200px;">

		<div title="我的考勤">
			<!-- list-style: none去左边的点；text-decoration: none：去超链接下划线,title用来区分后继定位这里的超链接 -->
			<ul style="list-style: none;padding: 0px;margin:0px;">
				<li style="padding: 6px;"><a href="${proPath}/attendance/insertAttendance.action" title="我要签到"
											 style="text-decoration: none;display: block;font-weight:bold;" >我要签到</a>
				</li>
				<li style="padding: 6px;"><a href="${proPath}/base/jsp/user/myAskForLeave.action" title="我要请假"
											 style="text-decoration: none;display: block;font-weight:bold;" >我要请假</a>
				</li>
				<li style="padding: 6px;"><a href="${proPath}/user/selectMyAttendance.action"  title="我的考勤记录"
											 style="text-decoration: none;display: block;font-weight:bold;">我的考勤记录</a>
				</li>
				<li style="padding: 6px;"><a href="${proPath}/base/jsp/user/myleave.action" title="我的请假记录"
											 style="text-decoration: none;display: block;font-weight:bold;" >我的请假记录</a>
				</li>
				<li style="padding: 6px;"><a href="${proPath}/base/jsp/admin/attendanceList.action" title="用户考勤记录"
											 style="text-decoration: none;display: block;font-weight:bold;" >用户考勤记录</a>
				</li>
			</ul>
		</div>

	</div>

</div>

<!-- -----------------------------------主要内容-------------------------------------------------- -->
<div data-options="region:'center',title:'主要内容'" style="padding:5px;background:#eee;">

	<div id="tt" class="easyui-tabs" data-options="fit:true" style="width:500px;height:250px;">
		<div title="系统简介" style="padding:20px;">

		</div>
	</div>


</div>
<div id="win"></div>
</body>
</html>
