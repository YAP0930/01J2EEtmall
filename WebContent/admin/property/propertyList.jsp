<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <li><a href="admin_category_list?start=${cstart}">${c.name}</a></li>
  <li class="active">属性管理 </li>
</ol>

<table class="table table-striped  table-bordered table-hover  table-condensed">
    <thead>
        <tr class="success">
        <td>ID</td>
        <td style="width:55%;">属性名称</td>
        <td>编辑</td>
        <td>删除</td>
    </tr>
    </thead>
    <tbody>
        <c:forEach  items="${properties}"  var="property">
        <tr>
            <td>${property.id}</td>
            <td>${property.name}</td>
            <td><a href="admin_property_edit?id=${property.id}&&prstart=${start}&&cid=${c.id}&&cstart=${cstart}"><span class="glyphicon glyphicon-edit"></span></a></td>
            <td><a class="deleteLink" href="admin_property_delete?id=${property.id}&&cid=${c.id}&&cstart=${cstart}"><span class="glyphicon glyphicon-remove"></span></a></td>
        </tr>  
        </c:forEach>  
    </tbody>
    <tfoot>
        <tr>
            <td colspan="4" align="center">
                <!-- 点击超链接时，相当于提交了一个带有参数start的请求 -->
                <a href="admin_property_list?start=0&&cid=${c.id}&&cstart=${cstart}">[首页]</a>
                <a href="admin_property_list?start=${pre}&&cid=${c.id}&&cstart=${cstart}">[上一页]</a>
                <!-- 中间页 -->
                <a href="admin_property_list?start=0&&cid=${c.id}&&cstart=${cstart}">[1]</a>
                <c:if test="${page-1>1}">
                    <c:forEach var="i" begin="2" end="${page-1}">
                    <a href="admin_property_list?start=${(i-1)*count}&&cid=${c.id}&&cstart=${cstart}">[${i}]</a>
                    </c:forEach>
                </c:if>
                <c:if test="${last>1}">
                <a href="admin_property_list?start=${last}&&cid=${c.id}&&cstart=${cstart}">[${page}]</a>
                    </c:if>
                <!-- 中间页 -->
                <a href="admin_property_list?start=${next}&&cid=${c.id}&&cstart=${cstart}">[下一页]</a>
                <a href="admin_property_list?start=${last}&&cid=${c.id}&&cstart=${cstart}">[末页]</a>
            </td>
        </tr>
    </tfoot>
</table>






<br>
<div style="width:50%;margin:0 auto;">
<div class="panel panel-warning">
  <div class="panel-heading">新增属性</div>
  <div class="panel-body">
      <!-- 面板内容 -->
      <form action="admin_property_add"  method="post" >
          <table>
              <tr>
                  <td class="subtitleTD">属性名称</td>
                  <td><input id="a"  type="text"  name="name"  class="form-control"></td>
              </tr>   
              <tr><td><br></td></tr>  
              <tr>
                  <td colspan="2" align="center">
                      <input type="hidden" name="cid" value="${c.id}">
                      <input type="hidden" name="cstart" value="${cstart}">
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