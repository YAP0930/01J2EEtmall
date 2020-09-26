<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script>
	/*
	 显示和隐藏效果
	 1. 把所有的产品列表都隐藏
	 2. 当鼠标移动到菜单项上的时候，取出对应的cid
	 3. 根据cid，找到对应的产品列表
	 4. 显示该产品列表
	 5. 当鼠标移开的时候，隐藏对应的产品列表								 
	 */
	//显示产品列表函数
	function showProductsAsideCategorys(cid) {
		$("div.eachCategory[cid=" + cid + "]").css("background-color", "white");
		$("div.eachCategory[cid=" + cid + "] a").css("color", "#87CEFA");
		$("div.productsAsideCategorys[cid=" + cid + "]").show();
	}
	//隐藏产品列表函数
	function hideProductsAsideCategorys(cid) {
		$("div.eachCategory[cid=" + cid + "]").css("background-color",
				"#e2e2e3");
		$("div.eachCategory[cid=" + cid + "] a").css("color", "#000");
		$("div.productsAsideCategorys[cid=" + cid + "]").hide();
	}

	$(function() {
		//当鼠标移入菜单项的时候，显示对应的产品列表
		$("div.eachCategory").mouseenter(function() {
			var cid = $(this).attr("cid");
			showProductsAsideCategorys(cid);
		});
		//当鼠标移出菜单项的时候，隐藏对应的产品列表
		$("div.eachCategory").mouseleave(function() {
			var cid = $(this).attr("cid");
			hideProductsAsideCategorys(cid);
		});
		//当鼠标移入产品列表的时候，显示对应的产品列表
		$("div.productsAsideCategorys").mouseenter(function() {
			var cid = $(this).attr("cid");
			showProductsAsideCategorys(cid);
		});
		//当鼠标移出产品列表的时候，隐藏对应的产品列表
		$("div.productsAsideCategorys").mouseleave(function() {
			var cid = $(this).attr("cid");
			hideProductsAsideCategorys(cid);
		});
	});
</script>
<div class="homepageDiv">
	<div style="height: 50px"></div>
	<div class="categoryWithCarousel">
		<!--分类菜单和产品列表都会和下面的轮播重叠在一起，所以会采用绝对定位的方式-->
		<!--而绝对定位又是基于已经定位了的父容器-->
		<!--所以在他们之上，会做一个div style="position: relative;left: 0;top: 0;"-->
		<!--专门用于在当前位置进行绝对定位，否则就会基于整个窗体进行绝对定位。-->
		<div style="position: relative">
			<!--左侧菜单-->
			<div class="categoryMenu ">
				<c:forEach items="${categorys}" var="c">
					<div class="eachCategory" cid="${c.id}">
						<span class="glyphicon glyphicon-link"></span> <a
							href="forecategory?cid=${c.id}">${c.name}</a>
					</div>
				</c:forEach>
			</div>
		</div>
		<div style="position: relative; left: 0; top: 0;">
			<!--右侧产品列表-->
			<c:forEach items="${categorys}" var="c">
					<div class="productsAsideCategorys"  cid="${c.id}">
						<c:forEach items="${c.productLists}" var="products">
							<div class="row">
								<c:forEach items="${products}" var="p">
									<c:if test="${!empty p.subTitle}">
										<a href="foreproduct?pid=${p.id}"> 
										<c:forEach
												items="${fn:split(p.subTitle, ' ')}" var="title"
												varStatus="st">
												<c:if test="${st.index==0}">
                                    ${title}
                                </c:if>
											</c:forEach>
										</a>
									</c:if>
								</c:forEach>
								<div class="seperator"></div>
							</div>
						</c:forEach>
					</div>
				</c:forEach>
				
		</div>
		
		<div style="height: 0px"></div>
	</div>
</div>