<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建/编辑项目</title>
	<meta name="decorator" content="default"/>
	<style>
		.pannelDiv{
			width:350px;padding:5px;box-shadow: 5px 5px 10px #888888;border:1px solid gray;
			border-radius:5px;
		}
		#optionDiv{
			border-radius:3px;
		}
		#optionDiv a{
			text-decoration: none;
		}
		#optionDiv .control-group{
			padding:5px;
		}
		#optionDiv .control-group:hover,.ophover{
			background:#5CACEE;
			border-radius:2px;
		}
		#optionDiv .control-group:hover a,#optionDiv .opa{
			color:#FFFFFF;
		}
	</style>
	<script type="text/javascript">
		var currentLine = 0;
		var myEditor;var contentWindow;
		$(function() {
            if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
			$("#title").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
                    if ($("#categoryId").val()==""){
                        $("#categoryName").focus();
                        top.$.jBox.tip('请选择归属栏目','warning');
                    }else if (CKEDITOR.instances.content.getData()=="" && $("#link").val().trim()==""){
                        top.$.jBox.tip('请填写正文','warning');
                    }else{
                        loading('正在提交，请稍等...');
                        form.submit();
                    }
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
			
			//绑定富文本key事件
			myEditor = CKEDITOR.instances.content;
			myEditor.on("instanceReady",function(){
				    contentWindow = $(".cke_wysiwyg_frame").get(0).contentWindow;
					$("body",myEditor.document.$).on("keyup", function(e){
						showOpt(this,e);
					}); 
			 });
			
			//按上下键，选择选项
			$(document).on("keydown",function(e){
				if($("#optionDiv").css("display")=="block"){
					switch(e.keyCode)  
					  { 
					    case 38: 
					      currentLine=0; 
					      changeItem(); 
					      break; 
					    case 40: 
					      currentLine=1; 
					      changeItem(); 
					      break; 
					    default: 
					      break; 
					  } 
				}
				  
			});
		});
		
		function showOpt(t,e){
			if (e.keyCode == "219") {		    
		         //var offset =  $(t,myEditor.document.$).caret("offset");
		         var range = contentWindow.getSelection().getRangeAt(0);
				 var offset = range.getBoundingClientRect();
		         var conOffset = $("#cke_content").offset();
		         $("#optionDiv").show().offset({
			        	left: offset.left + conOffset.left  + 10,
			            top: offset.top + conOffset.top +$("#cke_1_top").height()+30
		         });
		        //初始化选中样式
		        var op = $("#optionDiv .control-group").removeClass("ophover");
				var opa = $("#optionDiv .control-group a").removeClass("opa");
		        $("#proOption").addClass("opa").focus();
		        $("#optionDiv .control-group:first").addClass("ophover");
			}
		}
		
		//显示具体参数面板
		function insertOp(op,id){
			var obj = myEditor;
			//var reg=/\[$/gi;
			var reg = /\[(?!.*\[)/; //匹配最后一个出现的中括弧
			var extraNum = Math.round(Math.random()*100000);
			myEditor.setData(myEditor.getData().replace(reg,"<a class=\"opLink opLink"+extraNum+"\" href=\"javascript:void(0);\" onclick=\"parent.showOpPanel('"+id+"','.opLink"+extraNum+"')\">【"+op+"】</a>"));
			$(".opLink",myEditor.document.$).each(function(i){
				$(this).attr("onclick",$(this).attr("data-cke-pa-onclick")).css("cursor","pointer");
			});
			$(id+"Btn").attr("dataclass",".opLink"+extraNum); //绑定带替换文本的class,用于更改值
			//重新绑定keyup事件
			$("body",myEditor.document.$).on("keyup", function(e){
				showOpt(this,e);
			}); 
			var offset = $("#optionDiv").offset();
			$("#optionDiv").hide();
			resetPanel();//重置显示信息
			$(id).show().offset({
				left: offset.left+20,
				top: offset.top
			});
			
		}
		
		function showOpPanel(id,cl){
			resetPanel();//重置显示信息
			$("#productList,#materialsList").hide();//隐藏所有选项面板
			$(id+"Btn").attr("dataclass",cl); //绑定带替换文本的class,用于更改值
			//var offset = $(cl,myEditor.document.$).offset();
			var range = contentWindow.getSelection().getRangeAt(0);
			var offset = range.getBoundingClientRect();
			var conOffset = $("#cke_content").offset();
			console.log(offset.left+"===aaa==="+offset.top);
			$(id).show().offset({
				left: offset.left + conOffset.left +20,
				top: offset.top+ conOffset.top +$("#cke_1_top").height() +  30
			});
		}
		
		//重置
		function resetPanel(){
			$("#productName").val('');
			$("#materialsName").val('');
			$(".select2-chosen").text("请选择");
			showOp(['','#productSupplier','#productMemo']);
			showOp(['','#patientSample','#biologySample'])
		}
		
		function changeItem(){
			var op = $("#optionDiv .control-group");
			var opa = $("#optionDiv .control-group a");
			op.removeClass("ophover");
			$(op[currentLine]).addClass("ophover");
			opa.removeClass("opa");
			$(opa[currentLine]).focus().addClass("opa");
			
		}
		
		//显示材料、产品选项
		function pressShow(e){
			var selection = getSelection();
			 var sel = $("#content");
			 if (e.keyCode == "219") {		    
			 	var offset = sel.caret('offset');
			 	console.log(offset.top+"====="+offset.left);
			 	 console.log($("#optionDiv").offset().top+"===opOld=="+$("#optionDiv").offset().left);
	        	$("#optionDiv").show().offset({
		        	left: offset.left - 10,
		            top: offset.top + 20
	        	});
	        console.log($("#optionDiv").offset().top+"===opNew=="+$("#optionDiv").offset().left);
	        //初始化选中样式
	        var op = $("#optionDiv .control-group").removeClass("ophover");
			var opa = $("#optionDiv .control-group a").removeClass("opa");
	        $("#proOption").addClass("opa").focus();
	        $("#optionDiv .control-group:first").addClass("ophover");
			}
		}
		
		
		//取得最终参数
		function getOpValue(op){
			if($(op[0]).val()==""){
				return;
			}
			var txt = $(op[0]).val().split("_")[0];
			/* var obj = myEditor;
			var reg = eval("/\\[" + op[2] + "\\]$/gi");
			console.log("我们的产品是[产品]".replace(reg,txt));
			obj.setData(obj.getData().replace(reg,txt)); */
			$($(op[1]+"Btn").attr("dataclass"),myEditor.document.$).after(txt).remove();
			$(op[1]).hide();
		}
		
		function showOp(op){
			if(op[0]==""){
				$(op[1]).text("");
				$(op[2]).text("");
				return;
			}
			var arr = op[0].split("_");
			$(op[1]).text(arr[1]);
			$(op[2]).text(arr[2]);
		}
		

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bussiness/program/toProgramList?category.id=45b559276fc8434f9a074b7db45f0636">项目列表</a></li>
		<li class="active"><a href="<c:url value='${fns:getAdminPath()}/bussiness/program/toEditPage?id=${article.id}&category.id=45b559276fc8434f9a074b7db45f0636'><c:param name='category.name' value='${article.category.name}'/></c:url>">项目${not empty article.id?'修改':'添加'}</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="article" action="${ctx}/bussiness/program/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<%-- <div class="control-group">
			<label class="control-label">归属栏目:</label>
			<div class="controls">
                <sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
					title="栏目" url="/cms/category/treeData" module="article" selectScopeModule="true" notAllowSelectRoot="false" notAllowSelectParent="true" cssClass="required"/>&nbsp;
                <span>
                    <input id="url" type="checkbox" onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()"><label for="url">外部链接</label>
                </span>
			</div>
		</div> --%>
		<input type="hidden" name="category.id" value="${article.category.id}" />
		<div class="control-group">
			<label class="control-label">项目名称:</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xxlarge measure-input required"/>
				&nbsp;<%-- <label>颜色:</label>
				<form:select path="color" class="input-mini">
					<form:option value="" label="默认"/>
					<form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select> --%>
			</div>
		</div>
        <%-- <div id="linkBody" class="control-group" style="display:none">
            <label class="control-label">外部链接:</label>
            <div class="controls">
                <form:input path="link" htmlEscape="false" maxlength="200" class="input-xlarge"/>
                <span class="help-inline">绝对或相对地址。</span>
            </div>
        </div>
		<div class="control-group">
			<label class="control-label">关键字:</label>
			<div class="controls">
				<form:input path="keywords" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<span class="help-inline">多个关键字，用空格分隔。</span>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">权重:</label>
			<div class="controls">
				<form:input path="weight" htmlEscape="false" maxlength="200" class="input-mini required digits"/>&nbsp;
				<span>
					<input id="weightTop" type="checkbox" onclick="$('#weight').val(this.checked?'999':'0')"><label for="weightTop">置顶</label>
				</span>
				&nbsp;过期时间：
				<input id="weightDate" name="weightDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
					value="<fmt:formatDate value="${article.weightDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
				<span class="help-inline">数值越大排序越靠前，过期时间可为空，过期后取消置顶。</span>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">项目描述:</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">缩略图:</label>
			<div class="controls">
                <input type="hidden" id="image" name="image" value="${article.imageSrc}" />
				<sys:ckfinder input="image" type="thumb" uploadPath="/cms/article" selectMultiple="false"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">正文:</label>
			<div class="controls">
				<form:textarea id="content" htmlEscape="true" path="articleData.content" rows="4" maxlength="200" class="input-xxlarge" onkeyup="pressShow(event);" />
				<sys:ckeditor4 replace="content" uploadPath="/cms/article" />
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">来源:</label>
			<div class="controls">
				<form:input path="articleData.copyfrom" htmlEscape="false" maxlength="200" class="input-xlarge"/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">相关文章:</label>
			<div class="controls">
				<form:hidden id="articleDataRelation" path="articleData.relation" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<ol id="articleSelectList"></ol>
				<a id="relationButton" href="javascript:" class="btn">添加相关</a>
				<script type="text/javascript">
					var articleSelect = [];
					function articleSelectAddOrDel(id,title){
						var isExtents = false, index = 0;
						for (var i=0; i<articleSelect.length; i++){
							if (articleSelect[i][0]==id){
								isExtents = true;
								index = i;
							}
						}
						if(isExtents){
							articleSelect.splice(index,1);
						}else{
							articleSelect.push([id,title]);
						}
						articleSelectRefresh();
					}
					function articleSelectRefresh(){
						$("#articleDataRelation").val("");
						$("#articleSelectList").children().remove();
						for (var i=0; i<articleSelect.length; i++){
							$("#articleSelectList").append("<li>"+articleSelect[i][1]+"&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"articleSelectAddOrDel('"+articleSelect[i][0]+"','"+articleSelect[i][1]+"');\">×</a></li>");
							$("#articleDataRelation").val($("#articleDataRelation").val()+articleSelect[i][0]+",");
						}
					}
					$.getJSON("${ctx}/cms/article/findByIds",{ids:$("#articleDataRelation").val()},function(data){
						for (var i=0; i<data.length; i++){
							articleSelect.push([data[i][1],data[i][2]]);
						}
						articleSelectRefresh();
					});
					$("#relationButton").click(function(){
						top.$.jBox.open("iframe:${ctx}/cms/article/selectList?pageSize=8", "添加相关",$(top.document).width()-220,$(top.document).height()-180,{
							buttons:{"确定":true}, loaded:function(h){
								$(".jbox-content", top.document).css("overflow-y","hidden");
							}
						});
					});
				</script>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">是否允许评论:</label>
			<div class="controls">
				<form:radiobuttons path="articleData.allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">推荐位:</label>
			<div class="controls">
				<form:checkboxes path="posidList" items="${fns:getDictList('cms_posid')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发布时间:</label>
			<div class="controls">
				<input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div> --%>
		<%-- <shiro:hasPermission name="cms:article:audit">
			<div class="control-group">
				<label class="control-label">发布状态:</label>
				<div class="controls">
					<form:radiobuttons path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
					<span class="help-inline"></span>
				</div>
			</div>
		</shiro:hasPermission>
		<shiro:hasPermission name="cms:category:edit">
            <div class="control-group">
                <label class="control-label">自定义内容视图:</label>
                <div class="controls">
                      <form:select path="customContentView" class="input-medium">
                          <form:option value="" label="默认视图"/>
                          <form:options items="${contentViewList}" htmlEscape="false"/>
                      </form:select>
                      <span class="help-inline">自定义内容视图名称必须以"${article_DEFAULT_TEMPLATE}"开始</span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">自定义视图参数:</label>
                <div class="controls">
                      <form:input path="viewConfig" htmlEscape="true"/>
                      <span class="help-inline">视图参数例如: {count:2, title_show:"yes"}</span>
                </div>
            </div>
		</shiro:hasPermission>
		<c:if test="${not empty article.id}">
			<div class="control-group">
				<label class="control-label">查看评论:</label>
				<div class="controls">
					<input id="btnComment" class="btn" type="button" value="查看评论" onclick="viewComment('${ctx}/cms/comment/?module=article&contentId=${article.id}&status=0')"/>
					<script type="text/javascript">
						function viewComment(href){
							top.$.jBox.open('iframe:'+href,'查看评论',$(top.document).width()-220,$(top.document).height()-180,{
								buttons:{"关闭":true},
								loaded:function(h){
									$(".jbox-content", top.document).css("overflow-y","hidden");
									$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
									$("body", h.find("iframe").contents()).css("margin","10px");
								}
							});
							return false;
						}
					</script>
				</div>
			</div>
		</c:if> --%>
		<div class="form-actions">
			<shiro:hasPermission name="bussiness:program:edit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<%--产品参数 --%>
	<div id="productList"  class="form-horizontal pannelDiv" style="display:none;background:#FFFFFF;">
		<div class="control-group">
			<label class="control-label" style="width:60px">产品名称:</label>
			<div class="controls" style="margin-left:80px">
				<select id="productName" name="productName" class="input-xlarge" onchange="showOp([this.value,'#productSupplier','#productMemo'])">
					<option value="">请选择</option>
					<c:forEach items="${productList}" var="pro" >
						<option value="${pro.proName }_${pro.proSupplier }_${pro.memo }">${pro.proName }</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" style="width:60px">生产厂家:</label>
			<div id="productSupplier" style="margin-left:80px" class="controls"></div>
		</div>
		<div class="control-group">
			<label class="control-label" style="width:60px">产品描述:</label>
			<div id="productMemo" style="margin-left:80px" class="controls"></div>
		</div>
		<div class="form-actions" style="padding:5px 20px;padding-left:210px;">
			<input id="productListBtn"  class="btn btn-primary" type="button" onclick="getOpValue(['#productName','#productList','产品']);" value="确 定"/>&nbsp;
			<input  class="btn" type="button" value="取消" onclick="$('#productList').hide();"/>
		</div>
	</div>
	<%--材料参数 --%>
	<div id="materialsList"  class="form-horizontal pannelDiv"  style="display:none;background:#FFFFFF;">
		<div class="control-group">
			<label class="control-label" style="width:60px">细胞名称:</label>
			<div class="controls" style="margin-left:80px">
				<select id="materialsName" name="materialsName" class="input-xlarge" onchange="showOp([this.value,'#patientSample','#biologySample'])">
					<option value="">请选择</option>
					<c:forEach items="${materialsList}" var="mat" >
						<option value="${mat.cellName }_${mat.patientSample }_${mat.biologySample }">${mat.cellName }</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" style="width:60px">病人标本:</label>
			<div id="patientSample" style="margin-left:80px" class="controls"></div>
		</div>
		<div class="control-group">
			<label class="control-label" style="width:60px">生物样本:</label>
			<div id="biologySample" style="margin-left:80px" class="controls"></div>
		</div>
		<div class="form-actions" style="padding:5px 20px;padding-left:210px;">
			<input  id="materialsListBtn" class="btn btn-primary" type="button" onclick="getOpValue(['#materialsName','#materialsList','材料']);" value="确 定"/>&nbsp;
			<input  class="btn" type="button" value="取消" onclick="$('#materialsList').hide();"/>
		</div>
	</div>
	<%--参数选项 --%>
	<div id="optionDiv"  class="pannelDiv" style="width:80px;background:#FFFFFF;display:none">
		<div class="control-group" onclick="insertOp('产品','#productList')">
			<a href="javascript:void(0);" id="proOption" style="margin-left:10px" class="controls">产品</a>
		</div>
		<div class="control-group" onclick="insertOp('材料','#materialsList')">
			<a href="javascript:void(0);" id="matOption" style="margin-left:10px" class="controls">材料</a>
		</div>
	</div>
</body>
</html>