<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>用户注册</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.frTitle{
			text-align: center;
			margin:30px 0;
			width:100%;
			padding:20px 0;
			text-shadow:-1px -1px 1px #B0B0B0;
			border-bottom: 5px groove #317eac;
		}
		.form-horizontal{
			margin:0 30%;
			min-width:600px;
			border-radius:10px;
			box-shadow:1px 1px 3px #B0B0B0;
			background:#FFFFFF !important;
		}
		.control-label{
			font-family: Helvetica,Georgia,Arial,sans-serif,宋体 !important;
            font-size: 14px !important;
            width:30% !important;
		}
		.form-horizontal .controls {
		    margin-left: 35% !important;
		}
		.form-horizontal .controls input{
			padding: 4px 6px !important;
			line-height: 30px !important;
			height: 30px !important;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${pageContext.request.contextPath}/register/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					loginName: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					$("#no").val("${currentTime}"+PrefixInteger((Math.round(Math.random()*10000)),5));
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		
		//左补0
		function PrefixInteger(num, n) {
            return (Array(n).join(0) + num).slice(-n);
        }
	</script>
</head>
<body style="margin-top:80px;background:#f5f5f5">
	<form:form id="inputForm" modelAttribute="user" action="${pageContext.request.contextPath}/register/saveRegister" method="post" class="form-horizontal">
		<div class="frTitle"><h1>用户注册</h1></div>
		<sys:message content="${message}"/>
		<input type="hidden" id="company" name="company.id" value="25c930d05a474144b4133fdabc38c9cb" />
		<input type="hidden" id="office" name="office.id" value="1444eaea2c1640deb3d4a1e8169dbf55" />
		<input type="hidden" id="no" name="no" value="" />
		<input type="hidden" id="loginFlag" name="loginFlag" value="1" />
		<div class="control-group">
			<label class="control-label">姓名:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名:</label>
			<div class="controls">
				<input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
				<form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">密码:</label>
			<div class="controls">
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认密码:</label>
			<div class="controls">
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword"/>
				<c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱:</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="100" class="required email"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话:</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机:</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="100"/>
			</div>
		</div>
		<input type="hidden" id="roleIdList" name="roleIdList" value="d0dc3546e723495db2fe9c57c237922f" />
		<input type="hidden" id="remarks" name="remarks" value="用户自行注册" />
		<div class="form-actions" style="text-align:center;padding:20px 0;background:#FFFFFF;border-radius:10px;border: 0;">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="确 定"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>