<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div  class="categoryPageDiv">
   <div class="categoryProducts">
      <!--产品清单1-->
      <c:if test="${empty ps}">
        <div class="noMatch">没有满足条件的产品<div>
      </c:if>
	  <c:forEach items="${ps}" var="p">
	  <div  price="${p.promotePrice}" class="productUnit">
	    <!--产品框架-->
        <div class="productUnitFrame">
	       <a href="foreproduct?pid=${p.id}"><img src="img/productSingle_middle/${p.firstProductImage.id}.jpg" class="productImage"></a>
		   <span class="productPrice">¥
               <fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
           </span>
		   <a href="foreproduct?pid=${p.id}" class="productLink">${fn:substring(p.name, 0, 50)}</a>
		   <a href="#nowhere" class="tmallLink">天猫专卖</a>
		   <div class="productInfo">
		       <span class="monthDeal ">月成交<span class="productDealNumber">${p.saleCount}笔</span></span>
		       <span class="productReview">评价<span class="productReviewNumber">${p.reviewCount}</span></span>
		       <span class="wangwang"><a href="#nowhere" class="wangwanglink"><img src="img/site/wangwang.png"></a></span>
	       </div>
		</div>
	  </div>
      </c:forEach>
   </div>
</div>
<div style="clear: both"></div>
<div style="height:50px"></div>