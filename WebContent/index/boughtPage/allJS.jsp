<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script>//交互效果
/*          点击不同的订单类型按钮的时候
*1. 订单类型按钮状态发生变化
*2. 下方的订单数据，只显示当前订单类型，其他订单类型隐藏
*/
var deleteOrderid=0;
$(function(){
    //每一个订单类型超链都有一个自定义属性orderStatus，并且对应不同的值
	//<div class="selectedOrderType"><a href="#nowhere" orderstatus="all">所有订单</a></div>
    $("a[orderStatus]").click(function(){//通过选择器$("a[orderStatus]")，获取订单类型的超链
        var orderStatus = $(this).attr("orderStatus");//在超链的click事件中，获取自定义属性orderStatus值，判断点击的是哪个超链
        if('all'==orderStatus){
		    //对于每个订单所对应的table,也有一个orderStatus属性
			//<table orderstatus="waitReview" class="orderListItemTable" >
            $("table[orderStatus]").show();//当orderStatus是all的时候，那么就显示所有的table
        }
        else{//当orderStatus不是all的时候
            $("table[orderStatus]").hide();//先把所有的table隐藏，
            $("table[orderStatus="+orderStatus+"]").show();//然后把orderStatus对应的table显示出来        
        }
        $("div.orderType div").removeClass("selectedOrderType");//去掉原来的超链所在div的选中状态
        $(this).parent("div").addClass("selectedOrderType");//为当前的超链所在div加上选中状态
    });
	//删除要和服务端配合
    $("a.deleteOrderLink").click(function(){
        deleteOrderid = $(this).attr("oid");
        //deleteOrder = false;
        $("#deleteConfirmModal").modal("show");
    });
    $(".deleteConfirmButton").click(function(){
		$("#deleteConfirmModal").modal('hide');				
			var page="foredeleteOrder";
			$.post(
			    page,
			    {"oid":deleteOrderid},
			    function(result){
			    	if("success"==result){			    		
			    		$("table.orderListItemTable[oid="+deleteOrderid+"]").hide();
			    	}
			    	else{
			    		location.href="index/login.jsp";
			    	}
			    }
			);	  
	});
});
</script>
<div class="boughtDiv"><!--bought.html-->
    <!--订单类型-->
    <div class="orderType">
	    <div class="selectedOrderType" ><a orderstatus="all" >所有订单</a></div>
		<div><a orderstatus="waitPay" >待付款</a></div>
		<div><a orderstatus="waitDelivery"  >待发货</a></div>
		<div><a orderstatus="waitConfirm" >待收货</a></div>
		<div><a class="noRightborder" orderstatus="waitReview" >待评价</a></div>
		<div class="orderTypeLastOne"></div>
	</div>
	<div style="clear:both"></div>
	<!--产品表格标题，使用Table-->
	<div class="orderListTitle">
	    <table class="orderListTitleTable">
		    <tbody>
			    <tr>
				    <td style="width:55%;text-align:center">宝贝</td>
					<td style="width:15%;text-align:center">单价</td>
					<td style="text-align:center">数量</td>
					<td style="text-align:center">实付款</td>
					<td style="text-align:center">交易操作</td>
				</tr>
			</tbody>
		</table>
	</div>

    <!--orderListItem.html-->
    <div class="orderListItem">
	    <c:forEach items="${os}" var="o">
	    <table oid="${o.id}" orderstatus="${o.status}" class="orderListItemTable">
		    <tbody>
			   <tr class="orderListItemFirstTR">
			       <td colspan="2">
			           <b><fmt:formatDate value="${o.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></b>				    			      
				       <span>订单号: </span>
					   <span>${o.orderCode}</span>
				   </td>
				   <td colspan="2">
				       <img width="13px" src="img/site/orderItemTmall.png">
					   天猫商城
				   </td>
				   <td colspan="1"> 
				       <a   class="wangwanglink">
					       <div class="orderItemWangWangGif"></div>
					   </a>
				   </td>
				   <td class="orderItemDeleteTD">
				      <a class="deleteOrderLink" oid="${o.id}" >
					      <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
				      </a>
				  </td>
			   </tr>
			   <c:forEach items="${o.orderItems}" var="oi" varStatus="st">
			   <tr class="orderItemProductInfoPartTR">
			       <td class="orderItemProductInfoPartTD">
				        <img width="80" height="80" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg">
				   </td>
			       <td class="orderItemProductInfoPartTD">					  
					   <div class="orderListItemProductLinkOutDiv">
					      <a href="foreproduct?pid=${oi.product.id}">${oi.product.name}</a>
					      <div class="orderListItemProductLinkInnerDiv">
						      <img title="支持信用卡支付" src="img/site/creditcard.png">
						      <img title="消费者保障服务,承诺7天退货" src="img/site/7day.png">
						      <img title="消费者保障服务,承诺如实描述" src="img/site/promise.png">
						  </div>
					   </div>
				   </td>
				   <td width="100px" class="orderItemProductInfoPartTD">				      
					   <div class="orderListItemProductOriginalPrice">
					                 ￥<fmt:formatNumber type="number" value="${oi.product.orignalPrice}" minFractionDigits="2"/>
					   </div>
					   <div class="orderListItemProductPrice">
					                 ￥<fmt:formatNumber type="number" value="${oi.product.promotePrice}" minFractionDigits="2"/>
					   </div>					  
				   </td>
				   <c:if test="${st.count==1}">
				   <td width="100px" valign="center" rowspan="${fn:length(o.orderItems)}" class="orderListItemNumberTD orderItemOrderInfoPartTD">
				       <span class="orderListItemNumber">${o.totalNumber}</span>
				   </td>
				    
				   <td width="120px" valign="center" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD" rowspan="${fn:length(o.orderItems)}">
				       <div class="orderListItemProductRealPrice">
				           ￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${o.total}"/>
				       </div>
                       <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
				   </td>
				   <td width="100px" valign="center" class="orderListItemButtonTD orderItemOrderInfoPartTD" rowspan="${fn:length(o.orderItems)}">
				       <c:if test="${o.status=='waitConfirm' }">
                                    <a href="foreconfirmPay?oid=${o.id}">
                                        <button class="orderListItemConfirm">确认收货</button>
                                    </a>
                        </c:if>
                        <c:if test="${o.status=='waitPay' }">
                                    <a href="index/alipay.jsp?oid=${o.id}&total=${o.total}">
                                        <button class="orderListItemConfirm">付款</button>
                                    </a>                             
                        </c:if>
                                 
                        <c:if test="${o.status=='waitDelivery' }">
                                    <span>待发货</span>
<%--                                     <button class="btn btn-info btn-sm ask2delivery" link="admin_order_delivery?id=${o.id}">催卖家发货</button> --%>
                                     
                         </c:if>
 
                         <c:if test="${o.status=='waitReview' }">
                                    <a href="forereview?oid=${o.id}">
                                        <button  class="orderListItemReview">评价</button>
                                    </a>
                         </c:if>
				   </td>
				 </c:if>
			   </tr>
			  </c:forEach>
			</tbody>
	    </table>
	    </c:forEach>
	</div>
</div>