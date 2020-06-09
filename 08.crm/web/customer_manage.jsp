<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>客户管理</title>   
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- 导入easyui的资源文件 -->
	<script type="text/javascript" src="easyui/jquery.min.js"></script>
	<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<link id="themeLink" rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
  </head>
  
  <body>
  	<table id ="list">  </table>

	<%--工具条--%>
	<div id="tb">
		<a id="addBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加</a>
		<a id="editBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<a id="deleteBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a>

	</div>

	<%--编辑窗口--%>
	<div id="win" class="easyui-window" title="客户数据编辑" data-options="iconCls:'icon-save',modal:true,closed:true" style="width:350px;height:200px;padding:10px;">
		<form id="editForm" method="post" >
			<%--添加一个id隐藏域--%>
			<input type="hidden" name="id">
			客户姓名：<input type="text" name="name" class="easyui-validatebox" data-options="required:true"/><br/>
			客户性别：
			<input type="radio" name="gender" value="男" checked/>男
			<input type="radio" name="gender" value="女"/>女
			<br/>
			客户手机：<input type="text" name="telephone"class="easyui-validatebox" data-options="required:true"/><br/>
			客户住址：<input type="text" name="address"class="easyui-validatebox" data-options="required:true"/><br/>
			<a id="saveBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">保存</a>

		</form>
	</div>


	<script type="text/javascript">
		$(function(){
			$("#list").datagrid({
				// 后台数据查询地址
				url:"customer/listByPage.action",

				columns:[[
					{
						field:"id",
						title:"客户编号",
						width:100,
						checkbox:true
					},
					{
						field:"name",
						title:"客户姓名",
                        align:"center",
						width:200
					},
					{
						field:"gender",
						title:"客户性别",
                        align:"center",
						width:200,
					},
					{
						field:"telephone",
						title:"客户电话",
                        align:"center",
						width:200
					},
					{
						field:"address",
						title:"客户住址",
                        align:"center",
						width:400
					}
				]],
				       // 显示分页
                       pagination:true,
				       // 工具条
				       toolbar:"#tb"
			});
			// 添加数据
            $("#addBtn").click(function () {
            	// 表单清空
				$("#editForm").form("clear");
				// 打开窗口
				$("#win").window("open");
			});
            // 保存数据
            $("#saveBtn").click(function(){
            	$("#editForm").form("submit",{
					// url:提交到后台的地址
            		url:"customer/save.action",
					// onSubmit: 表单提交前的回调函数，true：提交表单 false：不提交表单
					onSubmit:function () {
            			// 验证表单是否通过
						return $("editForm").form("validate");
					 },
					// success:服务器执行完毕回调函数
					success:function (data) {  // data:服务器返回的数据，字符串类型
                       // 要求Controller返回的数据格式
						//  成功：{success:true}  失败：{success:false,msg:错误信息}
						var data = eval("("+data+")");
						if(data.success){
							// 关闭窗口
							$("#win").window("close");
							// 刷新表单
							$("#list").datagrid("reload");
							$.messager.alert("提示","保存成功","info");
						}else{
							$.messager.alert("提示","保存失败："+data.msg,"error");
						}
					}
				});
            });
            // 编辑窗口
			$("#editBtn").click(function () {
				// 判断只能选择一行
				var rows = $("#list").datagrid("getSelections");
				if(rows.length!=1){
					$.messager.alert("提示","修改操作只能选择一行","warning");
					return;
				}
				// 表单的回显
				$("#editForm").form("load","customer/findById.action?id="+rows[0].id);
				$("#win").window("open");

			});

            // 删除数据
            $("#deleteBtn").click(function () {

            	var rows = $("#list").datagrid("getSelections");
            	if(rows.length == 0){
            		$.messager.alert("提示","至少选择一行数据","warning");
            		return
				}
            	$.messager.confirm("提示","确认删除数据吗？",function (value) {
					 if(value){
					 	var idStr = "";
					 	// 遍历数据
					 	$(rows).each(function (i) {
					 		idStr+=("id="+rows[i].id+"&");
						});
					 	idStr = idStr.substring(0,idStr.length-1);

					 	//传递到后台
						 $.post("customer/delete.action",idStr,function(data){
                                if(data.success){
                                	$("#list").datagrid("reload");
                                	$.messager.alert("提示","成功","info");
								}else {
                                	$.messager.alert("提示","保存失败："+data.msg,"error");
								}
						 },"json");
					 }
				});

			});

		});

	</script>

  </body>
</html>
