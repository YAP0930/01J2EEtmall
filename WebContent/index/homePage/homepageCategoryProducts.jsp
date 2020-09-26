<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
a.categoryTitleA:hover{
  text-decoration:none;
  color:red;
}
</style>
<script>
$(function(){
	$("div.productItem").mouseenter(function(){

        $(this).css({"border-style":"solid","border-color":"#C40000"});    
        $(this).mouseleave(function(){
        	$(this).css({"border-style":"solid","border-color":"white"});  
        	
        });
    });
});
</script>
<div  class="homepageCategoryProducts">
    <c:forEach items="${categorys}" var="c" varStatus="st">
	   <c:if test="${st.count<=5}">
	   <div class="eachHomepageCategoryProducts">
			<div class="left-mark"></div>
			<a href="forecategory?cid=${c.id}" class="categoryTitleA">
			<span class="categoryTitle">${c.name}</span>
			</a><br>
			<c:forEach items="${c.products}" var="p" varStatus="st">
			<c:if test="${st.count<=5}">
			<div class="productItem">
				<a href="foreproduct?pid=${p.id}"> <img
					src="img/productSingle_middle/${p.firstProductImage.id}.jpg">
				</a> 
				<a href="foreproduct?pid=${p.id}" class="productItemDescLink"> 
				    <span class="productItemDesc">[热销] ${fn:substring(p.name, 0, 20)}</span>
				</a>
				<span class="productPrice">
				    <fmt:formatNumber type="number" value="${p.promotePrice}" minFractionDigits="2"/>
				</span>
			</div>
			</c:if>
			</c:forEach>
			
			<div style="clear: both"></div>
	  </div>
	  </c:if>
	  </c:forEach>
	<img src="img/site/end.png" class="endpng" id="endpng">
</div>

    