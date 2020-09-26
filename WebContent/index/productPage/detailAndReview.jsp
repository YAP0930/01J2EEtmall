<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!--切换商品详情和累计评价js-->
<script>
$(function(){
    $("div.productReviewDiv").hide();//首先让评价div隐藏
	//当点击评价按钮的时候，显示评价div，隐藏详情div
    $("a.productDetailTopReviewLink").click(function(){
        $("div.productReviewDiv").show();
        $("div.productDetailDiv").hide();
    });
	//当点击详情按钮的时候，显示详情div，隐藏评价div
    $("a.productReviewTopPartSelectedLink").click(function(){
        $("div.productReviewDiv").hide();
        $("div.productDetailDiv").show();      
    });
})
</script>

<!--productdetaill.htm-->
<div class="productDetailDiv" style="display: block;">
    <div class="productDetailTopPart">
        <a class="productDetailTopPartSelectedLink selected" >商品详情</a>
        <a class="productDetailTopReviewLink" >累计评价 <span class="productDetailTopReviewLinkNumber">${p.reviewCount}</span> </a>
    </div>
    <div class="productParamterPart">
        <div class="productParamter">产品参数：</div>
        <div class="productParamterList">
                <c:forEach items="${pValues}" var="pValue">
                <span><strong><font color="black">${pValue.property.name}:</font></strong>${pValue.value}</span>
                </c:forEach>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="productDetailImagesPart">
          <c:forEach items="${p.productDetailImages}" var="pdi">
              <img src="img/productDetail/${pdi.id}.jpg">
          </c:forEach>              
    </div>
</div>
<!--productReview.htm-->
<div class="productReviewDiv" style="display: block;">
    <div class="productReviewTopPart">
        <a class="productReviewTopPartSelectedLink" >商品详情</a>
        <a class="selected" >累计评价 <span class="productReviewTopReviewLinkNumber">${p.reviewCount}</span> </a>
    </div>
    <div class="productReviewContentPart">
        <c:forEach items="${reviews}" var="review">
        <div class="productReviewItem">
            <div class="productReviewItemDesc">
                <div class="productReviewItemContent">
                   <font color="black">${review.content}</font>
                </div>
                <div class="productReviewItemDate">                
                <fmt:formatDate value="${review.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" />
                </div>
            </div>
            <div class="productReviewItemUserInfo">
                ${review.user.anonymousName}<span class="userInfoGrayPart">（匿名）</span>
            </div>
            <div style="clear:both"></div>
        </div>
        </c:forEach>    
    </div>
</div>

