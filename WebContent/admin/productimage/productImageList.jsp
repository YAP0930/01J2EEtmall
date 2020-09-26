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
<body>
<div class="adminMessagePage">
<br/><br/>
<ol class="breadcrumb">
  <li><a href="admin_category_list">所有分类</a></li>
  <li><a href="admin_category_list?cid=${c.id}&&start=${cstart}">${c.name}</a></li>
  <li><a href="admin_product_list?id=${p.id}&&cid=${c.id}&&cstart=${cstart}&&start=${pstart}">${p.name}</a></li>
  <li class="active">图片管理</li>
</ol>
<div class="container" style="width:100%;margin:0 auto;">
	<div class="row clearfix">
			<div class="col-md-6 column">
				<div class="panel panel-warning">
					<div class="panel-heading">
						<h3 class="panel-title">新增产品单个图片</h3>
					</div>
					<div class="panel-body">
						<!-- 面板内容 -->
						<form action="admin_productImage_add" method="post"
							enctype="multipart/form-data">
							<table>
								<tr>请选择本地图片 尺寸400X400为佳
								</tr>
								<tr>
									<td>图片</td>
									<td>
									<input id="a" type="file" accept="image/*"
										name="filepath"></td>
								</tr>
								<tr>
									<td colspan="10" align="center">
									    <input type="hidden" name="type" value="type_single">
									    <input type="hidden" name="pid" value="${pid}">
									    <input type="hidden" name="cid" value="${c.id}">								
										<input type="hidden" name="cstart" value="${cstart}">
									    <input type="hidden" name="pstart" value="${pstart}">
										<button type="submit" class="btn btn-success">提交</button></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<div class="row clearfix">
					<div class="col-md-12 column">
						<table
							class="table table-striped  table-bordered table-hover  table-condensed">
							<thead>
								<tr class="success">
									<td>ID</td>
									<td>产品单个图片缩略图</td>
									<td>删除</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${productSingleImages}" var="productSingleImage">
									
										<tr>
											<td>${productSingleImage.id}</td>
											<td><img height="40px" src="img/productSingle/${productSingleImage.id}.jpg"></td>
											<td><a
												href="admin_productImage_delete?id=${productSingleImage.id}&&pid=${pid}&&cid=${c.id}&&cstart=${cstart}&&pstart=${pstart}">
												<span class="glyphicon glyphicon-remove"></span>
											   </a>
											</td>
										</tr>
									
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-md-6 column">
				<div class="panel panel-warning">
					<div class="panel-heading">
						<h3 class="panel-title">新增产品详情图片</h3>
					</div>
					<div class="panel-body">
						<!-- 面板内容 -->
						<form action="admin_productImage_add" method="post"
							enctype="multipart/form-data">
							<table>
								<tr>请选择本地图片 宽度790为佳
								</tr>
								<tr>
									<td>图片</td>
									<td><input id="b" type="file" accept="image/*"
										name="filepath"></td>
								</tr>
								<tr>
									<td colspan="10" align="center">
									    <input type="hidden" name="type" value="type_detail">
									    <input type="hidden"  name="pid" value="${pid}">
									    <input type="hidden" name="cid" value="${c.id}">								
										<input type="hidden" name="cstart" value="${cstart}">
									    <input type="hidden" name="pstart" value="${pstart}">
										<button type="submit" class="btn btn-success">提交</button></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<div class="row clearfix">
					<div class="col-md-12 column">
						<table
							class="table table-striped  table-bordered table-hover  table-condensed">
							<thead>
								<tr class="success">
									<td>ID</td>
									<td>产品详情图片缩略图</td>
									<td>删除</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${productDetailImages}" var="productDetailImage">
									
										<tr>
											<td>${productDetailImage.id}</td>
											<td><img height="40px" src="img/productDetail/${productDetailImage.id}.jpg"></td>
											<td><a
												href="admin_productImage_delete?id=${productDetailImage.id}&&pid=${pid}&&cid=${c.id}&&cstart=${cstart}&&pstart=${pstart}">
												<span class="glyphicon glyphicon-remove"></span>
											   </a></td>
										</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
	</div>
</div>
</div>
</body>
</html>