<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>选择文章</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/jquery-autocomplete/jquery.autocomplete.min.js"></script>
	<link href="${ctxStatic}/jquery-autocomplete/jquery.autocomplete.css" type="text/css" rel="stylesheet">
	<script type="text/javascript">
		var jsonArr = [
		   {
			title:"红色蜻蜓",
			count:"50"
		   },
		   {
			title:"何以笙箫默",
			count:"80"
		   },
		   {
			title:"轩辕剑",
			count:"600"
		   },
		   {
			title:"楚乔传",
			count:"700"
		   },
		   ];
		$(function() {
			//设置输入框自动补全
			$("#searchInput").autocomplete(jsonArr, {
				minChars: 0,
				width: 310,
				mustMatch: true,
				matchContains: true,
				autoFill: false,
				formatItem: function(row, i, max) {
					return i + "/" + max + " " + row.title + " - "+ row.count ;
				},
				formatMatch: function(row, i, max) {
					return row.title + " " + row.count;
				},
				formatResult: function(row) {
					return row.title;
				}
			});
		});
		
		
	</script>
</head>
<body>
	<div style="margin:10px;">
	<form:form id="searchForm" modelAttribute="article" action="${ctx}/bussiness/search/getResult" method="post" class="breadcrumb form-search">
		<label>标题：</label><form:input id="searchInput" path="title" htmlEscape="false" maxlength="50" class="input-middle"/>&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
	</form:form>
	</div>
</body>
</html>