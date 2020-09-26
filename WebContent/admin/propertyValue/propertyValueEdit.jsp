<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@include file="../../include/adminHeader.jsp"%>
<%@include file="../../include/adminNav.jsp"%>
<style>
div.navitagorDiv nav.adminNav span#category a:link{
   color:#C0C0C0;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#category a:visited{
   color:#FFFFFF;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#category a:hover{
   color:#FFFFFF;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#category a:active{
   color:#FFFFFF;
   text-decoration:none;
}
/*编辑面板里的样式**/
div.eachPV{
	float:left;
	margin:5px;
}
span.pvValue {
	display:inline-block;
	width:200px;
	border:1px solid lightgray;	
	padding:0px;
}
span.pvValue input{
	display:inline-block;
	width:198px;
	border:0px solid lightgray;	
	
}

span.pvName{
	display:inline-block;
	width:100px;	
	color:#555555;
	font-size:16px;
/* 	font-weight:bold; */
	margin-left:20px;
	
}
</style>

<script>
$(function() {
    $("input.pvValue").keyup(function(){
        var value = $(this).val();
        var page = "admin_product_updatePropertyValue";
        var pvid = $(this).attr("pvid");
        var parentSpan = $(this).parent("span");
        parentSpan.css("border","1px solid yellow");
        $.post(
                page,
                {"value":value,"pvid":pvid},
                function(result){
                    if("success"==result)
                        parentSpan.css("border","1px solid green");
                    else
                        parentSpan.css("border","1px solid red");
                }
            );     
    });
});
</script>
</head>
<body>
<div class="adminMessagePage">
<br/><br/><ol class="breadcrumb">
  <li><a href="admin_category_list">所有分类</a></li>
  <li><a href="admin_category_list?cid=${c.id}&&start=${cstart}">${c.name}</a></li>
  <li><a href="admin_product_list?cid=${c.id}&&cstart=${cstart}&&start=${pstart}">产品管理</a></li>
  <li class="active">${p.name}</li>
</ol>

<div style="width:80%;margin:0 auto;">
<div class="panel panel-warning">
  <div class="panel-heading">编辑属性值</div>
  <div class="panel-body">
      <!-- 面板内容 -->
      <c:forEach items="${pValues}" var="pValue">
      <div class="eachPV">
                <span class="pvName" >${pValue.property.name}</span>
                <span class="pvValue"><input class="form-control pvValue" pvid="${pValue.id}" type="text" value="${pValue.value}"></span>
      </div>
      </c:forEach>
      
  </div>
</div>

</div>

</div>

</body>
</html>