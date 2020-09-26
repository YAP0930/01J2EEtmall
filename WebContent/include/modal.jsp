<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<style>
button.subButton{
   color: white;/*字体颜色: white*/
   background-color: #C40000;/*背景色: #C40000*/
   font-size: 14px;/*字体大小: 14px*/
   font-weight: bold;/*粗体*/
}
</style>
<script>
$(function(){
	
	$(".subButton").click(function(){
	
		if(0==$("#name").val().length||0==$("#password").val().length){
            $("span.errorMessage").html("请输入账号密码");
            $("div.ErrorMessageDiv").css("visibility","visible");                
	        return false;
		}
		
		var page = "foreloginAjax";	
		var name = $("#name").val();
        var password = $("#password").val();
		$.get(
	            page,
	            {"name":name,"password":password},
	            function(result){
	            	if("success"==result){	            		
	            		location.reload();
	            	}
	            	else{	            		
	            		$("span.errorMessage").html("账号密码错误");
	            		$("div.ErrorMessageDiv").css("visibility","visible");             		
	            	}
	            }
		);	
		return true;
	});
})
</script>

<div class="modal " id="loginModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog loginDivInProductPageModalDiv">
            <div class="modal-content">
			<div class="loginDivInProductPage">
				<div id="loginDiv">
					<div class="loginSmallDiv" id="loginSmallDiv">
						<div class="ErrorMessageDiv">
							<div class="alert alert-danger" role="alert">
								<button type="button" class="close" data-dismiss="alert"
									aria-label="Close">
									<!--   <span aria-hidden="true">&times;</span> -->
								</button>
								<span class="errorMessage">错误信息</span>
							</div>
						</div>
						<!--登录绝对定位div-->
						<div class="login_acount_text">账户登录</div>
						<br>
						<div class="input-group ">
							<span class="input-group-addon"><span
								class=" glyphicon glyphicon-user"></span></span> <input name="name"
								id="name" type="text" class="form-control"
								placeholder="手机/会员名/邮箱">
						</div>
						<br>
						<div class="input-group ">
							<span class="input-group-addon"><span
								class=" glyphicon glyphicon-lock"></span></span> <input name="password"
								id="password" type="text" class="form-control" placeholder="密码">
						</div>
						<br>

						<div class="input-group ">
							<!--<a class="notImplementLink" href="#nowhere">忘记登录密码</a>-->
							<a class="pull-right" href="#nowhere">免费注册</a>
						</div>
						<div>
							<button class="btn btn-block subButton" type="submit">登录</button>
						</div>



					</div>
				</div>
			</div>
		</div>
    </div>
</div>
 
<div class="modal" id="deleteConfirmModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog deleteConfirmModalDiv">
       <div class="modal-content">
          <div class="modal-header">
            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
            <h4 class="modal-title">确认删除？</h4>
          </div>
          <div class="modal-footer">
            <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
            <button class="btn btn-primary deleteConfirmButton" id="submit" type="button">确认</button>
          </div>
        </div>
      </div>
    </div>
</div>