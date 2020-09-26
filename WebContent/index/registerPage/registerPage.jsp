<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	
<style>
.inp:focus{
  outline:none;
  border-style:solid;
  border-color:#03a9f4;
  box-shadow:0 0 5px #03a9f4;
}
</style>
<script>
$(function(){
	<c:if test="${!empty message}">
	$("span.errorMessage").html("${message}");
    $("div.ErrorMessageDiv").css("visibility","visible"); 
	</c:if>
	
	$(".registerForm").submit(function(){
		if(0==$("#name").val().length){
			$("span.errorMessage").html("请输入用户名");
            $("div.ErrorMessageDiv").css("visibility","visible");      
            return false;
		}
		if(0==$("#password").val().length){
			$("span.errorMessage").html("请输入密码");
            $("div.ErrorMessageDiv").css("visibility","visible");      
            return false;
		}
		if(0==$("#repeatpassword").val().length){
			$("span.errorMessage").html("请输入重复密码");
            $("div.ErrorMessageDiv").css("visibility","visible");      
            return false;
		}
		if($("#password").val() !=$("#repeatpassword").val()){
			$("span.errorMessage").html("重复密码不一致");
            $("div.ErrorMessageDiv").css("visibility","visible");      
            return false;
		}
		return true;
	});
	
})
</script>
<form method="get" action="foreregister" class="registerForm" >
<div class="registerDiv">
    <div class="ErrorMessageDiv">
        <div class="alert alert-danger"   role="alert">
          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <!--   <span aria-hidden="true">&times;</span> -->
          </button>
          <span  class="errorMessage" >错误信息</span>
        </div> 
    </div>
    
    <table align="center" class="registerTable">
	    <tbody>
		    <tr>
			    <td class="registerTip registerTableLeftTD">设置会员名</td>
				<td></td>
			</tr>
			<tr>
			    <td class="registerTableLeftTD">登陆名</td>
				<td class="registerTableRightTD">
				    <input class="inp" name="name" id="name" placeholder="会员名一旦设置成功，无法修改">
				</td>
			</tr>
			<tr>
			    <td class="registerTip registerTableLeftTD">设置登陆密码</td>
				<td>登陆时验证，保护账号信息</td>
			</tr>
			<tr>
			    <td class="registerTableLeftTD">登陆密码</td>
				<td class="registerTableRightTD">
				    <input class="inp" name="password" id="password" type="password" placeholder="设置你的登陆密码">
				</td>
			</tr>
			<tr>
			    <td class="registerTableLeftTD">密码确认</td>
				<td class="registerTableRightTD">
				    <input class="inp" id="repeatpassword" type="password" placeholder="请再次输入你的密码">
				</td>
			</tr>
			<tr>
			    <td class="registerButtonTD" colspan="2">
                        
				        <button class="inpButton"id="registBut" type="submit"> 提   交</button>
                </td>
			</tr>
		</tbody>
	</table>

</div>
</form>
