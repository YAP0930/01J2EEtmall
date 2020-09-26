<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<!--第1个div-->
<div class="reviewStasticsDiv">
	<!--左侧div-->
	<div class="reviewStasticsLeft">
		<!--左上div-->
		<div class="reviewStasticsLeftTop"></div>
		<!--左中div-->
		<div class="reviewStasticsLeftContent">
			累计评价 <span class="reviewStasticsNumber">
				${oi.product.reviewCount}</span>
		</div>
		<!--左下div-->
		<div class="reviewStasticsLeftFoot"></div>
	</div>
	<!--右侧div-->
	<div class="reviewStasticsRight">
		<!--右上div-->
		<div class="reviewStasticsRightEmpty"></div>
		<!--右下div-->
		<div class="reviewStasticsFoot"></div>
	</div>
</div>

<c:if test="${param.showonly==true}">
	<div class="productReviewContentPart">
		<c:forEach items="${rlists}" var="rlist">
			<c:forEach items="${rlist}" var="review">
			<c:if test="${review.getProduct().id==oi.product.id}">
			<div class="productReviewItem">
				<div class="productReviewItemDesc">
					<div class="productReviewItemContent">${review.content}</div>			
					<div class="productReviewItemDate">
						<fmt:formatDate value="${review.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" />
					</div>
				</div>
				<div class="productReviewItemUserInfo">
					${review.user.anonymousName}<span class="userInfoGrayPart">（匿名）</span>
				</div>
				<div style="clear: both"></div>
			</div>
			</c:if>
			</c:forEach>
		</c:forEach>
	</div>
</c:if>

<!--第2个div-->
<c:if test="${param.showonly!=true}">
	<div class="makeReviewDiv">
		<div class="reviewForm">
			其他买家，需要你的建议哦！
			<div class="makeReviewText">
				<table class="makeReviewTable">
					<tbody>
						<tr>
							<td class="makeReviewTableFirstTD">评价商品</td>
							<td><textarea name="content" class="content" st="${st.count}" showonly="false"
									pid="${oi.product.id}" oid="${oi.order.id}"></textarea></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 提交按钮 -->
		</div>
	</div>
</c:if>
