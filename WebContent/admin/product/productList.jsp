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
</style>
<script type="text/javascript">
$(function(){
	$(".productAddForm").submit(function(){
		if(0==$("#namePro").val().length){
			alert("请输入产品名称");
			return false;
		}
		if(0==$("#subTitlePro").val().length){
			alert("请输入产品小标题");
			return false;
		}
		var orignalPricePro=$("#orignalPricePro").val();
		if(0==orignalPricePro.length){
			alert("请输入产品原价格");
			return false;
		}		
		var promotePricePro=$("#promotePricePro").val();
		if(0==promotePricePro.length){
			alert("请输入产品优惠价格");
			return false;
		}	
		var stockPro=$("#stockPro").val();
		if(0==stockPro.length){
			alert("请输入库存");
			return false;
		}	
		
		
	});
});
</script>
<body>
<div class="adminMessagePage">
<br/><br/><ol class="breadcrumb">
  <li><a href="admin_category_list">所有分类</a></li>
  <li><a href="admin_category_list?cid=${c.id}&&start=${cstart}">${c.name}</a></li>
  <li class="active">产品管理 </li>
</ol>
<table class="table table-striped  table-bordered table-hover  table-condensed">
    <thead>
        <tr class="success">
        <td>ID</td>
        <td>图片</td>
        <td style="width:30%;">产品名称</td>
        <td style="width:15%;">产品小标题</td>
        <td>原价格</td>
        <td>优惠价格</td>
        <td>库存数量</td>
        <td>设置属性</td>
        <td>图片管理</td>
        <td>编辑</td>
        <td>删除</td>
    </tr>
    </thead>
    <tbody>
        <c:forEach  items="${products}"  var="product">
        <tr>
            <td>${product.id}</td>
            <td>
            <c:if test="${!empty product.firstProductImage}">
				<img width="40px" src="img/productSingle/${product.firstProductImage.id}.jpg">
		    </c:if>
		    </td>
            <td>${product.name}</td>
            <td>${product.subTitle}</td>
            <td>${product.orignalPrice}</td>
            <td>${product.promotePrice}</td>
            <td>${product.stock}</td>        
            <td><a href="admin_product_editPropertyValue?pid=${product.id}&&cid=${c.id}&&cstart=${cstart}&&pstart=${start}"><span class="glyphicon glyphicon-th-list"></span></a></td>
            <td><a href="admin_productImage_list?pid=${product.id}&&cid=${c.id}&&cstart=${cstart}&&pstart=${start}"><span class="glyphicon glyphicon-th-list"></span></a></td>
            <td><a href="admin_product_edit?id=${product.id}&&cid=${c.id}&&cstart=${cstart}&&pstart=${start}"><span class="glyphicon glyphicon-edit"></span></a></td>
            <td><a class="deleteLinkProduct" pid="${product.id}" cid="${c.id}" cstart="${cstart}"><span class="glyphicon glyphicon-remove"></span></a></td>
        </tr>  
        </c:forEach>  
    </tbody>
    <tfoot>
        <tr>
            <td colspan="11" align="center">
                <!-- 点击超链接时，相当于提交了一个带有参数start的请求 -->
                <a href="admin_product_list?start=0&&cid=${c.id}&&cstart=${cstart}">[首页]</a>
                <a href="admin_product_list?start=${pre}&&cid=${c.id}&&cstart=${cstart}">[上一页]</a>
                <!-- 中间页 -->
                <a href="admin_product_list?start=0&&cid=${c.id}&&cstart=${cstart}">[1]</a>
                <c:if test="${page-1>1}">
                    <c:forEach var="i" begin="2" end="${page-1}">
                    <a href="admin_product_list?start=${(i-1)*count}&&cid=${c.id}&&cstart=${cstart}">[${i}]</a>
                    </c:forEach>
                </c:if>
                <c:if test="${last>1}">
                    <a href="admin_product_list?start=${last}&&cid=${c.id}&&cstart=${cstart}">[${page}]</a>
                </c:if>
                <!-- 中间页 -->
                <a href="admin_product_list?start=${next}&&cid=${c.id}&&cstart=${cstart}">[下一页]</a>
                <a href="admin_product_list?start=${last}&&cid=${c.id}&&cstart=${cstart}">[末页]</a>
            </td>
        </tr>
    </tfoot>
</table>






<br>
<div style="width:50%;margin:0 auto;">
<div class="panel panel-warning">
  <div class="panel-heading">新增产品</div>
  <div class="panel-body">
      <!-- 面板内容 -->
      <form action="admin_product_add"  method="post"  class="productAddForm">
          <table>
              <tr>
                  <td class="subtitleTD">产品名称</td>
                  <td><input id="namePro"  type="text"  name="name"  class="form-control"></td>
              </tr> 
              <tr><td><br></td></tr>
               <tr>
                  <td>产品小标题</td>
                  <td><input id="subTitlePro"  type="text"  name="subTitle"  class="form-control"></td>
              </tr> 
              <tr><td><br></td></tr>
               <tr>
                  <td>原价格</td>
                  <td><input id="orignalPricePro"  type="text"  name="orignalPrice"  class="form-control"></td>
              </tr> 
              <tr><td><br></td></tr>
               <tr>
                  <td>优惠价格</td>
                  <td><input id="promotePricePro"  type="text"  name="promotePrice"  class="form-control"></td>
              </tr> 
              <tr><td><br></td></tr>
               <tr>
                  <td>库存</td>
                  <td><input id="stockPro"  type="text"  name="stock"  class="form-control"></td>
              </tr>  
              <tr><td><br></td></tr>   
              <tr>
                  <td colspan="2" align="center">
                      <input type="hidden" name="cid" value="${c.id}">
                      <input type="hidden" name="cstart" value="${cstart}">
                      <input type="hidden" name="pstart" value="${start}">
                      <button type="submit" class="btn btn-success">提交</button>
                  </td>
              </tr>                                       
          </table>          
      </form>
  </div>
</div>

</div>
</div>
</body>
</html>