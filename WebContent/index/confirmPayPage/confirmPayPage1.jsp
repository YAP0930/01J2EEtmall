<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>




<div class="confirmPayPageDiv">
    <!--第1个div--->
    <div class="confirmPayImageDiv">
	    <img src="http://how2j.cn/tmall/img/site/comformPayFlow.png">
		<div class="confirmPayTime1">
		    <fmt:formatDate value="${o.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" />
		</div>
		<div class="confirmPayTime2">
		    <fmt:formatDate value="${o.payDate}"
							pattern="yyyy-MM-dd HH:mm:ss" />
		</div>
		<div class="confirmPayTime3">
		<fmt:formatDate value="${o.delivertDate}"
							pattern="yyyy-MM-dd HH:mm:ss" />		 
		</div>
	</div> 
	<!--第2个div--->
	<div class="confirmPayOrderInfoDiv">
        <div class="confirmPayOrderInfoText">我已收到货，同意支付宝付款</div> 
	</div>
	<!--第3个div--->
    <div class="confirmPayOrderItemDiv"> 
	    <div class="confirmPayOrderItemText">订单信息</div> 
	    <table class="confirmPayOrderItemTable">
		    <thead>
                <tr>
				    <th colspan="2">宝贝</th>      
                    <th width="120px">单价</th>      
                    <th width="120px">数量</th>      
                    <th width="120px">商品总价 </th>       
                    <th width="120px">运费</th>      
                </tr>
			</thead>
		    <tbody>
		        <c:forEach items="${o.orderItems}" var="oi">
			    <tr>
				    <td><img  width="50px" src="http://how2j.cn/tmall/img/productSingle_middle/${oi.product.firstProductImage.id}.jpg"></td>
					<td class="confirmPayOrderItemProductLink">
					    <a href="#nowhere">${oi.product.name}</a></td>
					<td>￥${oi.product.promotePrice}</td>
					<td>${oi.number}</td>
					<td>
					    <span class="conformPayProductPrice">
					    ￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${oi.number*oi.product.promotePrice}"/>
					    </span>
					</td>
					<td><span>快递 ： 0.00 </span></td>
				</tr> 
				</c:forEach> 
			</tbody>
		</table>
		<!--第4个div--->
        <div class="confirmPayOrderItemText pull-right">
	       实付款： <span class="confirmPayOrderItemSumPrice">
	         ￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.total}"/>	       
	       </span>
	    </div> 
	</div> 
</div> 