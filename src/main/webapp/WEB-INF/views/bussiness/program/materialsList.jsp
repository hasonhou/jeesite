<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>材料列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="#">材料列表</a></li>
		<%-- <shiro:hasPermission name="bussiness:program:edit"><li><a href="<c:url value='${fns:getAdminPath()}/bussiness/program/toEditPage?id=${article.id}&category.id=${article.category.id}'><c:param name='category.name' value='${article.category.name}'/></c:url>">项目添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="materials" action="${ctx}/bussiness/program/toMaterialsList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>细胞：</label><form:input path="cellName" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>病人标本：</label><form:input path="patientSample" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>生物样本：</label><form:input path="biologySample" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<%-- <label>状态：</label><form:radiobuttons onclick="$('#searchForm').submit();" path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>细胞</th><th>病人标本</th><th>生物样本</th><th>状态</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="materials">
			<tr>
				<td>${materials.cellName }</td>
				<td>${materials.patientSample }</td>
				<td>${materials.biologySample }</td>
				<td>${materials.delFlag eq 0 ? "启用" : "禁用" }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>