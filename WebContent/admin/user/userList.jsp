<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@include file="../../include/adminHeader.jsp"%>
<%@include file="../../include/adminNav.jsp"%>
<style>
div.navitagorDiv nav.adminNav span#user a:link{
   color:#C0C0C0;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#user a:visited{
   color:#FFFFFF;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#user a:hover{
   color:#FFFFFF;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#user a:active{
   color:#FFFFFF;
   text-decoration:none;
}
</style>
<body>

<div class="adminMessagePage">
<br/><br/>

<ol class="breadcrumb">
  <li><a href="admin_user_list">所有用户</a></li>
</ol>
<table class="table table-striped  table-bordered table-hover  table-condensed">
    <thead>
        <tr class="success">
        <td>ID</td>
        <td>用户名称</td>
        <td>密码</td>
       
    </tr>
    </thead>
    <tbody>
        <c:forEach  items="${users}"  var="user">
        <tr>
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.password}</td>
        </tr>  
        </c:forEach>  
    </tbody>
    <tfoot>
        <tr>
           
            <td colspan="3" align="center">
            <c:if test="${!empty users}">
                <!-- 点击超链接时，相当于提交了一个带有参数start的请求 -->
                <a href="admin_user_list?start=0">[首页]</a>
                <a href="admin_user_list?start=${pre}">[上一页]</a>
                <!-- 中间页 -->
                <a href="admin_user_list?start=0">[1]</a>
                <c:if test="${page-1>1}">
                    <c:forEach var="i" begin="2" end="${page-1}">
                    <a href="admin_user_list?start=${(i-1)*count}">[${i}]</a>
                    </c:forEach>
                </c:if>
                <c:if test="${last>1}">
                    <a href="admin_user_list?start=${last}">[${page}]</a>
                </c:if>
                <!-- 中间页 -->
                <a href="admin_user_list?start=${next}">[下一页]</a>
                <a href="admin_user_list?start=${last}">[末页]</a>
            </c:if>
            </td>
            
        </tr>
    </tfoot>
</table>






<br><br>
</div>



</body>
</html>