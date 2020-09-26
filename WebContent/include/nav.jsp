<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	

<nav class="top ">
    <a href="forehome">
        <span class="glyphicon glyphicon-home redColor"></span>天猫首页
    </a>
    <span>喵，欢迎来天猫</span>
	<c:if test="${empty user}">
	    <a href="index/login.jsp">请登录</a>
	</c:if>
    <c:if test="${!empty user}">
	    <a >${user.name}</a>
	    <a href="forelogout">退出</a>
	</c:if>
	<c:if test="${empty user}">
	    <a href="index/register.jsp">免费注册</a>
	</c:if>
    <span class="pull-right">
	<!--.pull-right	元素浮动到右边(bootstrap辅助类)-->
    <c:if test="${empty user}">
        <a href="forebought">我的订单</a>     
        <a href="forecart">
            <span class="glyphicon glyphicon-shopping-cart redColor"></span>
                                购物车
        </a>      
    </c:if>
    <c:if test="${!empty user}">
        <a href="forebought">我的订单</a>     
        <a href="forecart">
            <span class="glyphicon glyphicon-shopping-cart redColor"></span>
                                购物车<strong><span id="totalCartSpan">${totalCart}</span></strong>件
        </a>      
    </c:if>
    </span>
</nav>