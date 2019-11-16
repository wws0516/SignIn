<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../common/common.jspf" %>

        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


    <title>supplier list page</title>
    <script type="text/javascript">
        var url = "${proPath}/base/jsp/user/myleave.action";
        function search() {

            var nianfen = $("#cboNianFen").val();
            var yuefen = $("#cboYueFen").val();
            if (yuefen<10) yuefen='0'+yuefen;
            var signtime = nianfen+"-"+yuefen+"-01";
            url = url+"?signtime="+signtime;
            location=url;
        }


        /** 绑定年份下拉框 **/
        function bangDingNianFen() {
            var date = new Date();
            var nianfen = date.getFullYear();
            var yue = date.getMonth();
            var shu = parseInt(nianfen) - 4;
            $("#cboNianFen").empty();
            for ( var i = 0; i < 9; i++) {
                var html = "<option value='" + (shu + i) + "'>" + (shu + i)
                    + "年</option>";
                $("#cboNianFen").append(html);
            }

            /*选上当前年月 */
            $("#cboNianFen").val(nianfen);
            $("#cboYueFen").val(yue + 1);
        }

        $(function(){
            var url = "${proPath}/attendance/selectMyLeave.action";
            var urls = document.location.toString();
            var arrUrl = urls.split("?");
            var para = arrUrl[1];
            if (para!=null) url= url+"?"+para;
            <%--var signtime  = "${map['signtime']}";--%>
            if (para==null) {
                bangDingNianFen();
            }else {
                var nianfen = para.substr(9,4);
                var yuefen = para.substr(14,2);
                $("#cboNianFen").val(parseInt(nianfen));
                $("#cboYueFen").val(parseInt(yuefen));
            }
            $('#dg').datagrid({
                url:url, //支持单个关键字的分页查询
                striped:true,
                fitColumns:true,
                idField:'id',
                rownumbers:true,
                loadMsg:"加载中，请稍等...",
                pagination:true,
                pageSize:5,
                pageList:[2,5,10,15],
                toolbar: [{
                    iconCls: 'icon-edit',
                    text:'修改',
                    handler: function(){
                        var rows = $('#dg').datagrid('getSelections');
                        if(rows.length!=1){
                            alert("请选择并且只能选择一条修改的记录！");
                            return false;
                        }
                        parent.$('#win').window({
                            title:'修改请假信息',
                            width:600,
                            height:400,
                            modal:true,
                            content:"<iframe src='${proPath}/base/jsp/user/LeaveEdit.signin.signin.action' title='修改请假信息' height='100%' width='100%' frameborder='0px' ></iframe>"
                        })
                    }
                },'-',{
                        iconCls: 'icon-remove',
                        text:'删除',
                        handler: function(){
                            var rows = $('#dg').datagrid("getSelections");
                            if(rows.length==0){
                                alert("请选择需要删除的记录！");
                                return false;
                            }
                            //2.获取行中记录ID数组
                            var ids = new Array();
                            var leave_ids = new Array();
                            for(var i=0;i<rows.length;i++){
                                ids[i]=rows[i].id;
                                leave_ids[i]=rows[i].leave.leave_id;
                            }


                            parent.$.messager.confirm('删除对话框', '您确认要删除吗？', function(r) {
                                if (r) {
                                    $.ajax({
                                        url: "${proPath}/leave/deleteLeave.action",
                                        type:"POST",
                                        //设置为传统方式传送参数
                                        traditional:true,
                                        data:{pks:ids,pks1:leave_ids},
                                        success: function(html){
                                            if(html>0){
                                                alert("恭喜您，删除成功，共删除了"+html+"条记录！");
                                            }else{
                                                alert("对不起，删除失败，请联系管理员！");
                                            }
                                            //重新刷新页面
                                            $("#dg").datagrid("reload");
                                            //请除所有勾选的行
                                            $("#dg").datagrid("clearSelections");
                                        },
                                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                                            $.messager.alert('删除错误','请联系管理员！','error');
                                        },
                                        dataType:'json'
                                    });
                                }
                            });


                        }

                    }],

                columns:[[
                    {checkbox:true},
                    {field:'id',title:'编号',width:100},
                    {field:'signtime',title:'请假日期',width:100},
                    {field:'leave',formatter:function (leave) {
                        return leave.reason;},title:'请假原因',width:100,align:'right'}
                ]]
            });

        });
    </script>

</head>
<body>
<!--   <form signin.signin.action="">
  <input type='text' id='supName' name='supName'/>
  <input type='text' id='supName' name='supName'/><br>
    <input type='text' id='supName' name='supName'/>
  <input type='text' id='supName' name='supName'/><br>
  </form> -->
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

    <div  style="display: inline-block;" >
        <button style="height:20px;width:60px" onclick="search()" >确定</button>
    </div>
</div>
<table id="dg"></table>


</body>
</html>