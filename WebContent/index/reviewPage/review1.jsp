<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<style>
div.productReviewContentPart {
	padding-top: 50px;
}

div.productReviewItem {
	border-bottom: 1px solid #E3E3E3;
	margin: 10px 0px;
}

div.productReviewItem div.productReviewItemDesc {
	width: 80%;
	display: inline-block;
	color: #333333;
	margin: 5px 20px;
	float: left;
}

div.productReviewItemDate {
	margin: 15px 0px 0px 0px;
	color: #CCCCCC;
}

div.productReviewItem div.productReviewItemUserInfo {
	color: #404040;
	margin: 5px 20px;
	padding: 20px 0;
}

span.userInfoGrayPart {
	color: #999999;
}
</style>
<script>
	$(function() {
		$(".reviewBtn").click(function() {
			var contents=$(".content");
			var oid=0;
			//alert(contents.length);
            for(i=1;i<=contents.length;i++){
            	var showonly=$(".content[st="+i+"]").attr("showonly");           	
            	oid=$(".content[st="+i+"]").attr("oid");           	
            	var pid=$(".content[st="+i+"]").attr("pid");           	
            	var content=$(".content[st="+i+"]").val();
            	//alert("showonly:"+showonly);
            	//alert("oid:"+oid);
            	//alert("pid:"+pid);
            	if(showonly=="false"){
                	if(content.length<=0){
                		alert("评论不能为空！");
                		//alert(1);
                		return false;
                		//alert("评论不能为空啊！");
                	}else{
                		//alert(2);
                	    //$(".content[st="+i+"]").attr("showonly",true);
                		//showonly=$(".content[st="+i+"]").attr("showonly");
                		//alert("showonly后:"+showonly);
                		//alert("content:"+content);
                		var page="foredoreview";
                		$.post(
                				page,
                			    {"pid":pid,"content":content,"oid":oid},
                			    function(result){
                			    	if("success"==result){
                			    		$(".content[st="+i+"]").attr("showonly","true");
                			    		//alert(3);
                			    	}
                			    }
                		);   
                		//alert(4);
                	}
                	//alert("1");
            	}
            }
            var newpage="forereviewAjax";
            $.post(
            		 newpage,
		    		 //{"oid":oid},
		    		 function(result){
		    			 location.href="forereview?oid="+oid+"&showonly=true";
		    		 }
            );
            //alert("2");
			//return false;
		});
	})
</script>
<c:forEach items="${o.orderItems}" var="oi" varStatus="st" >
	<div class="reviewDiv">
		<div class="reviewProductInfoDiv">
			<!--飘逸在左侧的div-->
			<div class="reviewProductInfoImg">
				<img class="reviewProductImg" width="100px" height="100px"
					src="http://how2j.cn/tmall/img/productSingle/${oi.product.firstProductImage.id}.jpg">
			</div>
			<!--overflow:hidden,自动填满右侧的div-->
			<div class="reviewProductInfoRightDiv">
				<div class="reviewProductInfoRightText">${oi.product.name}</div>
				<table class="reviewProductInfoTable">
					<tbody>
						<tr>
							<td width="75px">价格:</td>
							<td><span class="reviewProductInfoTablePrice"> ￥<fmt:formatNumber
										minFractionDigits="2" maxFractionDigits="2" type="number"
										value="${oi.product.promotePrice}" />
							</span> 元</td>
						</tr>
						<tr>
							<td>配送</td>
							<td>快递: 0.00</td>
						</tr>
						<tr>
							<td>月销量:</td>
							<td><span class="reviewProductInfoTableSellNumber">
									${oi.product.saleCount} </span> 件</td>
						</tr>
					</tbody>
				</table>

				<div class="reviewProductInfoRightBelowDiv">
					<span class="reviewProductInfoRightBelowImg"> <img
						src="http://how2j.cn/tmall/img/site/reviewLight.png">
					</span> <span class="reviewProductInfoRightBelowText">现在查看的是
						您所购买商品的信息于 <fmt:formatDate value="${o.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /> 下单购买了此商品
					</span>
				</div>
			</div>
			<div style="clear: both"></div>
		</div>
		<div class="pidDiv" pid="${oi.product.id}" style="display: none;"></div>
		<%@include file="../reviewPage/review2.jsp"%>
	</div>
</c:forEach>
<c:if test="${param.showonly!=true}">
<div class="makeReviewButtonDiv">
<button type="submit" class="reviewBtn" >提交评价</button>
</div>
</c:if>