<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<div class="confirmPayPageDiv">
    <div class="confirmPayOrderDetailDiv">
        <table class="confirmPayOrderDetailTable">
	        <tbody>
		        <tr>
			        <td>订单编号：</td>
				    <td>
				        ${o.orderCode}
				        <img width="23px" src="http://how2j.cn/tmall/img/site/confirmOrderTmall.png">
				    </td>
			    </tr>
			    <tr>
			        <td>卖家昵称: </td>
				    <td>天猫商铺<span class="confirmPayOrderDetailWangWangGif"></span></td>
			    </tr>
			    <tr>
			        <td>收货信息：</td>
				    <td>${o.address}，${o.receiver}， ${o.mobile}，${o.post}</td>
			    </tr>
			    <tr>
			        <td>成交时间：</td>
				    <td>${o.createDate}</td>
			    </tr>
		    </tbody>
	    </table>
	</div>
	<div class="confirmPayButtonDiv">
	    <div class="confirmPayWarning">请收到货后，再确认收货！否则您可能钱货两空！</div>
		<a href="foreorderFinish?oid=${o.id}"><button class="confirmPayButton">确认支付</button></a>
	</div>
</div>
