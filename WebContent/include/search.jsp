<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<script>
$(function(){
	$(".searchButton").keydown(function(){
		//$(this).css("border","1px solid transparent");
	});
});
</script>
<div>
    <!--绝对定位的图片-->
    <a href="#nowhere"> 	
	    <img class="logo" src="img/site/logo.gif"id="logo">
    </a>
        <form action="foresearch" method="post" >
        <!--居中div-->
        <div class="searchDiv">
            <input type="text" placeholder="时尚男鞋  太阳镜 " name="keyword" value="${param.keyword}">
            <button class="searchButton" type="submit">搜索</button>
            <!--子div-->
            <div class="searchBelow">
            <c:forEach items="${categorys}" var="c" varStatus="st">
            <c:if test="${st.count>=5 and st.count<=8}">
               <span> <a href="forecategory?cid=${c.id}"> ${c.name} </a>
               <c:if test="${st.count!=8}">
                    <span>|</span>
                </c:if>
                </span>
            </c:if>
            </c:forEach>
            </div>
        </div>
        </form>
</div>
<div style="height:1px"></div>