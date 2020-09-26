<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>



<style>
div.navitagorDiv{
    background-color:#000000;
	font-size:25px;
	padding:20px 0px;
}
div.navitagorDiv a{
	margin:10px 20px;
}
div.navitagorDiv nav.adminNav span a:link{
   color:#C0C0C0;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span a:visited{
   color:#C0C0C0;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span a:hover{
   color:#FFFFFF;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span a:active{
   color:#FFFFFF;
   text-decoration:none;
}


div.adminMessagePage{
   width:80%;
   margin:0 auto;
}
table{
   table-layout:fixed;
}
.subtitleTD{
    width:28%;
}
</style>
<div class="navitagorDiv">
	<nav class="adminNav">
		<img style="margin-left:10px;margin-right:0px;position:relative;left:0px;top:-10px;" 
		class="pull-left" src="img/site/tmallbuy.png" height="50px">
		<span id="admin"><a  href="admin/index.jsp" id="admin">天猫后台</a></span>
		<span id="category"><a  href="admin_category_list">分类管理</a></span>
		<span id="user"><a  href="admin_user_list">用户管理</a></span>
		<span id="order"><a  href="admin_order_list">订单管理</a></span>
	</nav>
</div>

