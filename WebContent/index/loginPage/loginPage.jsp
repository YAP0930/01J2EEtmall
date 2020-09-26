<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	
<%@include file="../../include/header.jsp" %>

<script>
$(function(){
	<c:if test="${!empty message}">
	$("span.errorMessage").html("${message}");
	$("div.ErrorMessageDiv").css("visibility","visible"); 
	</c:if>
	
	$(".loginForm").submit(function(){
		if(0==$(".name").val().length||0==$(".password").val().length){
            $("span.errorMessage").html("请输入账号密码");
            $("div.ErrorMessageDiv").css("visibility","visible");     
            return false;
		}
		
		//return true;
	});
})
</script>
<div id="loginDiv">
    <!--天猫logo-->
    <div class="simpleLogo">
	    <img src="img/site/simpleLogo.png">
	</div>
	<!--背景图片-->
	<img class="loginBackgroundImg" id="loginBackgroundImg" src="http://how2j.cn/tmall/img/site/loginBackground.png" >
    <div class="loginSmallDiv" id="loginSmallDiv">
    <form class="loginForm"   action="<%=basePath%>forelogin" method="post">
    
	    
	    <div class="ErrorMessageDiv">
           <div class="alert alert-danger"   role="alert">
               <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                  <!--  <span aria-hidden="true">&times;</span>-->
               </button>
               <span  class="errorMessage" >错误信息</span>
           </div> 
        </div>
        <!--登录绝对定位div-->
        <div class="login_acount_text"> 账户登录</div>
		<br>
		<div class="input-group ">
			<span class="input-group-addon"><span class=" glyphicon glyphicon-user"></span></span>
			<input  name="name" id="name" type="text" class="form-control" placeholder="手机/会员名/邮箱">
		</div>
		<br>
		<div class="input-group ">
			<span class="input-group-addon"><span class=" glyphicon glyphicon-lock"></span></span>
			<input  name="password" id="password" type="text" class="form-control" placeholder="密码">
		</div>
		<br>
		     
		<div class="input-group ">
           <!--<a class="notImplementLink" href="#nowhere">忘记登录密码</a>-->
            <a class="pull-right" href="#nowhere">免费注册</a>
        </div>	
		<div>
            <button class="btn btn-block redButton" type="submit">登录</button>
        </div>
	
	</form>
	</div>
</div>