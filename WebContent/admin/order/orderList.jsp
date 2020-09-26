<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@include file="../../include/adminHeader.jsp"%>
<%@include file="../../include/adminNav.jsp"%>
<style>
div.navitagorDiv nav.adminNav span#order a:link{
   color:#C0C0C0;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#order a:visited{
   color:#FFFFFF;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#order a:hover{
   color:#FFFFFF;
   text-decoration:none;
}
div.navitagorDiv nav.adminNav span#order a:active{
   color:#FFFFFF;
   text-decoration:none;
}
</style>

<style>
tr.orderPageOrderItemTR {
	display: none;
}
</style>
<script>
$(function(){
	//var div=$("#oisDiv");
	$(".oisBtn").click(function(){
		var oid = $(this).attr("oid");
		$("tr.orderPageOrderItemTR[oid="+oid+"]").toggle();
	});
});
</script>
</head>
<body>
<div class="adminMessagePage">
<br/><br/>

<ol class="breadcrumb">
  <li><a href="admin_order_list">所有订单</a></li>
</ol>
	<table
		class="table table-striped  table-bordered table-hover  table-condensed">
		<thead>
			<tr class="success">
				<td style="width:5%;">ID</td>
				<td style="width:5%;">状态</td>
				<td style="width:10%;">金额</td>
				<td style="width:5%;">商品数量</td>
				<td>买家名称</td>
				<td>创建时间</td>
				<td>支付时间</td>
				<td>发货时间</td>
				<td>确认收货时间</td>
				<td>操作</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${orders}" var="order">
				<tr>
					<td>${order.id}</td>
					<td>${order.statusDesc}</td>
					<td>
					 ￥<fmt:formatNumber type="number" value="${order.total}" minFractionDigits="2"/>
					</td>
					<td align="center">${order.totalNumber}</td>
					<td align="center">${order.user.name}</td>
					<td><fmt:formatDate value="${order.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${order.payDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${order.delivertDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${order.confirmDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>
						<button class="oisBtn" oid="${order.id}">查看详情</button>
						<c:if test="${order.status=='waitDelivery'}">
                        <a href="admin_order_delivery?id=${order.id}">
                            <button class="btn btn-primary btn-xs">发货</button>
                        </a>                         
                       </c:if>
					</td>
				</tr>
				<tr class="orderPageOrderItemTR" oid="${order.id}">
					<td colspan="10" align="center">
						<div >
							<table width="800px" align="center">
								<c:forEach items="${order.orderItems}" var="oi">
									<tr>

										<td align="left"><img width="40px" height="40px"
											src="img/productSingle/${oi.product.firstProductImage.id}.jpg">
										</td>
										<td class="text-muted">${oi.product.name}</td>
										<td class="text-muted" align="right">${oi.number}个</td>
										<td class="text-muted" align="right">￥
										<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${oi.product.promotePrice}"/>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="10" align="center">
					<!-- 点击超链接时，相当于提交了一个带有参数start的请求 --> 
					<a href="admin_order_list?start=0">[首页]</a> 
					<a href="admin_order_list?start=${pre}">[上一页]</a> 
					<!-- 中间页 --> 
					<a href="admin_order_list?start=0">[1]</a> 
					<c:if test="${page-1>1}">
						<c:forEach var="i" begin="2" end="${page-1}">
							<a href="admin_order_list?start=${(i-1)*count}">[${i}]</a>
						</c:forEach>
					</c:if> 
					<c:if test="${last>1}">
						<a href="admin_order_list?start=${last}">[${page}]</a>
					</c:if> 
					<!-- 中间页 --> 
					<a href="admin_order_list?start=${next}">[下一页]</a> 
					<a href="admin_order_list?start=${last}">[末页]</a>
				</td>
			</tr>
		</tfoot>
	</table>
</div>







</body>
</html>