<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品列表</title>
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
		<li class="active"><a href="#">产品列表</a></li>
		<%-- <shiro:hasPermission name="bussiness:program:edit"><li><a href="<c:url value='${fns:getAdminPath()}/bussiness/program/toEditPage?id=${article.id}&category.id=${article.category.id}'><c:param name='category.name' value='${article.category.name}'/></c:url>">项目添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="product" action="${ctx}/bussiness/program/toProductList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>名称：</label><form:input path="proName" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>厂家：</label><form:input path="proSupplier" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>描述：</label><form:input path="memo" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<%-- <label>状态：</label><form:radiobuttons onclick="$('#searchForm').submit();" path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名称</th><th>厂家</th><th>描述</th><th>状态</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="product">
			<tr>
				<td>${product.proName }</td>
				<td>${product.proSupplier }</td>
				<td>${product.memo }</td>
				<td>${product.delFlag eq 0 ? "启用" : "禁用" }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>