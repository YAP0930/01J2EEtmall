<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<style>
.inp:focus{
  outline:none;
  border-style:solid;
  border-color:#03a9f4;
  box-shadow:0 0 5px #03a9f4;
}
span.leaveMessageTextareaSpan {
    display: inilne-block;
}
textarea.leaveMessageTextarea {
    border: 1px solid #FFAD35;
    width: 250px;
    height: 60px;
    resize: none;
}
</style>
<script>//点击显示用户留言输入框效果
/*
*点击输入框的时候，出来一个边框是橘黄色的文本域
*/
$(function(){
    //默认显示的输入框其实是一个图片，点击的时候，显示可编辑的div
    //var textLength=$(leaveMessageTextarea).val().length;
    $("img.leaveMessageImg").click(function(){
        $(this).hide();
        $("span.leaveMessageTextareaSpan").show();
        $("div.orderItemSumDiv").css("height","100px");
    });
    $(".leaveMessageTextarea").keyup(function(){
    	var textLength=$(this).val().length;
    	//(textLength);
    	var inpLength=parseInt(200)-textLength;
    	//alert(inpLength);
    	if(inpLength>0){   		
    		$(".userMessage").css("color","#999999");
    		$(".userMessage").html("还可以输入"+inpLength+"个字符");
    	}else if(inpLength==0){   		
    		$(".userMessage").html("留言字数已满！");
    		$(".userMessage").css("color","red");
    	}else{
    		$(".userMessage").html("留言字数已超限制！");
    		$(".userMessage").css("color","red");
    	}
    });
});
</script>
<script>//判断必填信息是否为空
$(function(){
    $("form.createOrderForm").submit(function(){
        if(0==$("#address").val().length){
        	//详细地址
        	alert("请输入  详细地址");
            return false;
        }
        if(0==$("#receiver").val().length){
        	alert("请输入  收货人姓名");
            return false;
        }
        if(25<$("#receiver").val().length){
        	alert("收货人姓名  超出长度");
            return false;
        }
        if(0==$("#mobile").val().length){
        	//手机号码
        	alert("请输入  手机号码");
            return false;
        }
        if(11!=$("#mobile").val().length){
        	//手机号码
        	alert("请输入  含11个数字的手机号码");
            return false;
        }
        if(200<$("textarea.leaveMessageTextarea").val().length){
        	//留言备注
        	alert("留言备注  超出长度");
            return false;
        }       
        var num = $(".orderItemProductNumber").val();
		var totalCartSpan=parseInt($("#totalCartSpan").html())+parseInt(num);
		$("#totalCartSpan").html(totalCartSpan);//修改购物车的数量
        
        return true;
    });
});
</script>
<div class="buyPageDiv"><!--buyPage.html-->
<form action="forecreateOrder" method="post" class="createOrderForm">
    <!--结算页面标题图片-->
    <div class="buyFlow">
	    <img class="pull-left" src="http://how2j.cn/tmall/img/site/simpleLogo.png">
		<img class="pull-right" src="http://how2j.cn/tmall/img/site/buyflow.png">
	    <div style="clear:both"></div>
	</div>
	<div class="address">
	    <!--收货地址div-->
	    <div class="addressTip">输入收货地址</div>
		<!--地址信息-->
		<div>
	    <table class="addressTable">
		    <tbody>
			    <tr>
				    <td class="firstColumn">
					    详细地址
						<span class="redStar">*</span>
					</td>
					<td><textarea class="inp" id="address" name="address" placeholder="建议您如实填写详细收货地址，例如街道名称，门牌号码，楼层和房间号等信息"></textarea></td>
				</tr>
				<tr>
				    <td>邮政编码</td>
					<td><input class="inp" name="post" type="text" placeholder="如果您不清楚邮递区号，请填写000000"></td>
				</tr>
				<tr>
				    <td>收货人姓名<span class="redStar">*</span></td>
					<td><input class="inp" id="receiver" name="receiver" type="text" placeholder="长度不超过25个字符"></td>
				</tr>
				<tr>
				    <td>手机号码<span class="redStar">*</span></td>
					<td><input class="inp" id="mobile" name="mobile" type="text" placeholder="请输入11位手机号码"></td>
				</tr>
			</tbody>
		</table>
	</div>
	</div>	
<!--productList.html-->
    <div class="productList">
        <div class="productListTip">确定订单信息</div>
	        <table class="productListTable">
		    <thead>
			    <tr>
				    <th class="productListTableFirstColumn" colspan="2">
					   <img class="tmallbuy" src="img/site/tmallbuy.png" >
					   <a class="marketLink" href="#nowhere">店铺：天猫店铺</a>
					   <a  class="wangwanglink" href="#nowhere"><span class="wangwangGif"></span></a>
					</th>
					<th><span>单价</span></th>
					<th><span>数量</span></th>
					<th><span>小计</span></th>
					<th><span>配送方式</span></th>
				</tr>
				<tr class="rowborder">
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
			</thead>
			<tbody class="productListTableTbody">
				<c:forEach items="${ois}" var="oi" varStatus="st">
				<tr class="orderItemTR">
				    <td class="orderItemFirstTD"><img width="20px" class="orderItemImg" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg"></td>
					<td class="orderItemProductInfo">
					   
						    <a class="orderItemProductLink" href="foreproduct?pid=${oi.product.id}">
						        ${oi.product.name}
						    </a>
						
						
						    <img title="支持信用卡支付" src="img/site/creditcard.png">
							<img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
							<img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">
					    
					</td>
					<td>
					    <span class="orderItemProductPrice">￥
					        <fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/>
					    </span>
					</td>
					<td>
					    <span class="orderItemProductNumber">
					        ${oi.number}
					    </span>
					</td>
					<td>
					    <span class="orderItemUnitSum">￥
					    <fmt:formatNumber type="number" value="${oi.number*oi.product.promotePrice}" minFractionDigits="2"/>
					    </span>
					</td>
					<c:if test="${st.count==1}">
					<td class="orderItemLastTD" rowspan="5">
					    <label class="orderItemDeliveryLabel">
					        <input type="radio" checked="checked" value="">
                                普通配送
						</label>						
					    <select class="orderItemDeliverySelect">
                            <option>快递 免邮费</option>
                        </select>						
					</td>
					</c:if>
				</tr>
				</c:forEach>
			</tbody>
		   </table>
	        <div class="orderItemSumDiv">
	            <div class="pull-left">
	                <span class="leaveMessageText">给卖家留言:</span>
			        <span>
                        <img class="leaveMessageImg" src="img/site/leaveMessage.png">
                    </span>
					<span class="leaveMessageTextareaSpan" style="display: none;">
					    <textarea class="leaveMessageTextarea inp" name="userMessage"></textarea>
						<div>
						    <span class="userMessage">还可以输入200个字符</span>
						</div>
					</span>
	            </div>
		        <span class="pull-right">店铺合计（含运费）：￥
		            <fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/>
		        </span>
	        </div>
        </div>
        <div class="orderItemTotalSumDiv">
	        <div class="pull-right">
	            <span>实付款：</span>
			    <span class="orderItemTotalSumSpan">￥
			        <fmt:formatNumber type="number" value="${total}" minFractionDigits="2"/>
			    </span>
		    </div>
	    </div>
	    <div class="submitOrderDiv">
	        <button  class="submitOrderButton" type="submit">提交订单</button>
	    </div>
</form>
</div>