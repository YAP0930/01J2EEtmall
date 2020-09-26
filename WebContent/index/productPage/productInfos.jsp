<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<script>
	$(function() {
		var stock = ${p.stock}
		;//定义最大库存(这个值是从服务端取出来的)
		/*
		 *监听keyup键盘弹起事件,不能监听keypress和keydown
		 *因为只有keyup才能获取到最后输入的值，其他不能。
		 */
		//<input type="text" value="1" class="productNumberSetting">
		$(".productNumberSetting").keyup(function() {
			var num = $(".productNumberSetting").val();//获取输入框的值
			num = parseInt(num);// parseInt会把文本中的非数字前的数字解析出来，所以如果文本框的内容是22B,那么解析出来是22.
			if (isNaN(num))//如果是非数字，那么就设置为1。
				num = 1;
			if (num <= 0)//如果是负数，那么设置为1。
				num = 1;
			if (num > stock)//如果大于库存，设置为最大库存。
				num = stock;
			$(".productNumberSetting").val(num);
		});
		//<a class="increaseNumber" href="#nowhere">
		//点击增加按钮的时候，获取当前的值，并在当前值的基础上+1，如果超过了库存就取库存最大值
		$(".increaseNumber").click(function() {
			var num = $(".productNumberSetting").val();
			num++;
			if (num > stock)
				num = stock;
			$(".productNumberSetting").val(num);
		});
		//<a class="decreaseNumber" href="#nowhere">
		//点击减少按钮的时候，获取当前的值，并在当前值的基础上-1，如果<=0，则取1.
		$(".decreaseNumber").click(function() {
			var num = $(".productNumberSetting").val();
			--num;
			if (num <= 0)
				num = 1;
			$(".productNumberSetting").val(num);
		});
		// 立即购买 按钮的监听
		$(".buyLink").click(function(){
			var num = $(".productNumberSetting").val();
			var totalCartSpan=parseInt($("#totalCartSpan").html())+parseInt(num);
	        var page = "forecheckLogin";
	        $.get(
	                page,
	                {"totalCartSpan":totalCartSpan},
	                function(result){
	                    if("success"==result){
	                    	//修改购物车数量
	                    	//var totalCartSpan=parseInt($("#totalCartSpan").html())+parseInt(num);
	                    	$("#totalCartSpan").html(totalCartSpan);
	                    	//alert("跳转路径，传递参数，增加一个订单项，返回原页面，提示操作成功"); 
	                    	var num = $(".productNumberSetting").val();
	                        var attr=$(".buyLink").attr("href")+"&num="+num;
	                        location.href=attr;
	                    }	    
	                    else {                   	
	                        $("#loginModal").modal('show');        
	                    }
	                }
	        );     
	        return false;
	        });
		// 加入购物车 按钮的监听addCartButton
		$(".addCartLink").click(function(){
	    var totalCartSpan=parseInt($("#totalCartSpan").html());
        var page = "forecheckLogin";
        $.get(
                page,
                {"totalCartSpan":totalCartSpan},
                function(result){
                    if("success"==result){
                    	//alert("result"+result);  
                        //alert("跳转路径，传递参数，增加一个订单项，进入结算页面");
                        var pid = ${p.id};
                        //alert("pid:"+pid);  
                        var num = $(".productNumberSetting").val();
                        var addCartpage = "foreaddCart";
                        //alert("addCartpage:"+addCartpage);
                        //alert("#totalCartSpan:"+$("#totalCartSpan").html());
                        totalCartSpan=parseInt($("#totalCartSpan").html())+parseInt(num);
                        $.get(
                        		addCartpage,
                        		{"pid":pid,"num":num,"totalCartSpan":totalCartSpan},
                        		function(result){
                        			if("success"==result){
                        				$(".addCartButton").html("已加入购物车");
                        				$(".addCartButton").attr("disabled","disabled");
                        				$(".addCartButton").css("background-color","lightgray")
                        			    $(".addCartButton").css("border-color","lightgray")
                        				$(".addCartButton").css("color","black")                       		
                        			    //alert(parseInt($("#totalCartSpan").html())+parseInt(num));
                        				//var totalCartSpan=parseInt($("#totalCartSpan").html())+parseInt(num);
                        				$("#totalCartSpan").html(totalCartSpan);
                        			}else{}
                        		}
                        );
                    }
                    else{        
                    	//alert("result"+result);  
                        $("#loginModal").modal('show');        
                    }
                }
        );     
        return false;
        });
		
		
	});
</script>

<div class="imgAndInfo">
	<!--左侧图片-->
	<div class="imgInimgAndInfo"></div>
	<!--右侧基本信息-->
	<div class="infoInimgAndInfo">
		<div class="productTitle">${p.name}</div>
		<div class="productSubTitle">${p.subTitle}</div>
		<div class="productPrice">
			<div class="juhuasuan">
				<span class="juhuasuanBig">聚划算</span> <span>此商品即将参加聚划算，<span
					class="juhuasuanTime">1天19小时</span>后开始，
				</span>
			</div>
			<div class="productPriceDiv">
				<div class="gouwujuanDiv">
					<img height="16px"
						src="http://how2j.cn/tmall/img/site/gouwujuan.png"> <span>全天猫实物商品通用</span>
				</div>
				<div class="originalDiv">
					<span class="originalPriceDesc">价格</span> <span
						class="originalPriceYuan">¥</span> <span class="originalPrice">${p.orignalPrice}</span>
				</div>
				<div class="promotionDiv">
					<span class="promotionPriceDesc">促销价</span> <span
						class="promotionPriceYuan">¥</span> <span class="promotionPrice">${p.promotePrice}</span>
				</div>

			</div>
		</div>
		<div class="productSaleAndReviewNumber">
			<div>
				销量 <span class="redColor boldWord"> ${p.saleCount}</span>
			</div>
			<div>
				累计评价 <span class="redColor boldWord"> ${p.reviewCount}</span>
			</div>
		</div>
		<div class="productNumber">
			<span>数量</span> <span> <span class="productNumberSettingSpan">
					<input type="text" value="1" class="productNumberSetting">
			</span> <span class="arrow"> <a class="increaseNumber"> <span
						class="updown"> <img src="img/site/increase.png">
					</span>
				</a> <span class="updownMiddle"> </span> <a class="decreaseNumber">
						<span class="updown"> <img src="img/site/decrease.png">
					</span>
				</a>
			</span> 件
			</span> <span>库存${p.stock}件</span>
		</div>
		<div class="serviceCommitment">
			<span class="serviceCommitmentDesc">服务承诺</span> <span
				class="serviceCommitmentLink"> <span >正品保证</span> <span
				>极速退款</span> <span >赠运费险</span> <span
				>七天无理由退换</span>
			</span>
		</div>
		<div class="buyDiv">
			<a class="buyLink" href="forebuyonce?pid=${p.id}">
				<button class="buyButton">立即购买</button>
			</a> <a class="addCartLink">
				<button class="addCartButton">
					<span class="glyphicon glyphicon-shopping-cart"></span> 加入购物车
				</button>
			</a>
		</div>
	</div>
	<div style="height: 50px"></div>
</div>
