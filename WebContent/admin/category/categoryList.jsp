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
</ol>
<table class="table table-striped  table-bordered table-hover  table-condensed">
    <thead>
        <tr class="success">
        <td>ID</td>
        <td style="width:55%;">图片</td>
        <td>分类名称</td>
        <td>属性管理</td>
        <td>产品管理</td>
        <td>编辑</td>
        <td>删除</td>
    </tr>
    </thead>
    <tbody>
        <c:forEach  items="${categories}"  var="categorie">
        <tr>
            <td >${categorie.id}</td>
            <td><img height="40px" src="img/category/${categorie.id}.jpg"></td>
            <td>${categorie.name}</td>
            <td><a href="admin_property_list?cid=${categorie.id}&cstart=${start}"><span class="glyphicon glyphicon-th-list"></span></a></td>
            <td><a href="admin_product_list?cid=${categorie.id}&cstart=${start}"><span class="glyphicon glyphicon-th-list"></span></a></td>
            <td><a href="admin_category_edit?cid=${categorie.id}&cstart=${start}"><span class="glyphicon glyphicon-edit"></span></a></td>
            <td><a class="deleteLinkCategory" cid="${categorie.id}"><span class="glyphicon glyphicon-remove"></span></a></td>
        </tr>  
        </c:forEach>  
    </tbody>
    <tfoot>
        <tr>
            <td colspan="7" align="center">
                <!-- 点击超链接时，相当于提交了一个带有参数start的请求 -->
                <a href="admin_category_list?start=0">[首页]</a>
                <a href="admin_category_list?start=${pre}">[上一页]</a>
                
                <!-- 中间页 -->
                <a href="admin_category_list?start=0">[1]</a>
                <c:if test="${page-1>1}">
                    <c:forEach var="i" begin="2" end="${page-1}">
                    <a href="admin_category_list?start=${(i-1)*count}">[${i}]</a>
                    </c:forEach>
                </c:if>
                <c:if test="${last>1}">
                    <a href="admin_category_list?start=${last}">[${page}]</a>
                </c:if>
                <!-- 中间页 -->
                <a href="admin_category_list?start=${next}">[下一页]</a>
                <a href="admin_category_list?start=${last}">[末页]</a>
            </td>
        </tr>
    </tfoot>
</table>

<br>
<div style="width:50%;margin:0 auto;">
<div class="panel panel-warning">
  <div class="panel-heading">新增分类</div>
  <div class="panel-body">
      <!-- 面板内容 -->
      <form action="admin_category_add" method="post" enctype="multipart/form-data">
          <table>
              <tr>
                  <td class="subtitleTD">分类名称</td>
                  <td ><input id="a"  type="text"  name="name"  class="form-control"></td>
              </tr>
              <tr>
                  <td><br></td>
              </tr>
              <tr>
                  <td>分类图片</td>
                  <td ><input id="b"  type="file"  accept="image/*" name="filepath"></td>
              </tr>
               <tr>
                  <td><br></td>
              </tr>
              <tr>
                  <td colspan="2" align="center">
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