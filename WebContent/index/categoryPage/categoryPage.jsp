<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!--价格区间的交互-->
<script>
/*                       交互有两部分功能
                      1. 排序部分
排序功能，需要提交到服务器重新获取数据，这个就不属于js交互部分的内容了。
                      2. 价格区间
满足价格条件的产品都会列罗出来，比如输入开始价格输入200，结束价格输入500，就只会显示满足条件的产品，这个是用js做的，可以演示效果
*/

//<input class="sortBarPrice beginPrice" type="text" placeholder="请输入">
//<input class="sortBarPrice endPrice" type="text" placeholder="请输入">

//给这两个输入框添加keyup事件
$(function(){
$("input.sortBarPrice").keyup(function(){
    //获取数值
    var num= $(this).val();
    if(num.length==0){    //如果是空的，此时输入的价格是无效的。
        $("div.productUnit").show();//那么就让所有的产品项都显示出来
        return;
    }
    //判断输入的值,是否是数字     
    num = parseInt(num);
    if(isNaN(num)) //不是数字就显示1.
        num= 1;
    if(num<=0)  //是负数就显示1.
        num = 1;
    $(this).val(num);      
     
    var begin = $("input.beginPrice").val();  //获取开始价格
    var end = $("input.endPrice").val();      //获取结束价格
    if(!isNaN(begin) && !isNaN(end)){
        console.log(begin);
        console.log(end);
        $("div.productUnit").hide();  //隐藏所有的产品项
        $("div.productUnit").each(function(){//遍历每一个产品项
		    // <div price="799.2" class="productUnit">
			//产品项上有一个自定义属性price，标注了该产品项的价格
            var price = $(this).attr("price");
            price = new Number(price);
             
            if(price<=end && price>=begin) //当产品的价格在开始和结束区间
                $(this).show();//显示出来。
        });
    }
});
});
</script>
<div  class="categoryPageDiv">
    <!--categorySortBar.htm-->
    <img src="img/category/${c.id}.jpg">
    <div class="categorySortBar">
        <table class="categorySortBarTable categorySortTable">
		  <tbody>
		    <tr>
			   <td  <c:if test="${'all'==param.sort||empty param.sort}">class="grayColumn"</c:if>>
			       <a href="forecategory?cid=${c.id}&sort=all">
			                             综合<span class="glyphicon glyphicon-arrow-down"></span>
			       </a>
			   </td>
			   <td  <c:if test="${'review'==param.sort||empty param.sort}">class="grayColumn"</c:if>> 
			       <a href="forecategory?cid=${c.id}&sort=review">		   
			                            人气<span class="glyphicon glyphicon-arrow-down"></span>
			       </a>
			   </td>
			   <td  <c:if test="${'date'==param.sort||empty param.sort}">class="grayColumn"</c:if>>
			       <a href="forecategory?cid=${c.id}&sort=date">
			                           新品<span class="glyphicon glyphicon-arrow-down"></span>
			       </a>
			   </td>
			   <td  <c:if test="${'saleCount'==param.sort||empty param.sort}">class="grayColumn"</c:if>>
			       <a href="forecategory?cid=${c.id}&sort=saleCount">
			                           销量<span class="glyphicon glyphicon-arrow-down"></span>
			       </a>
			   </td>
			   <td  <c:if test="${'price'==param.sort||empty param.sort}">class="grayColumn"</c:if>>
			       <a href="forecategory?cid=${c.id}&sort=price">
			                          价格<span class="glyphicon glyphicon-resize-vertical"></span>
			       </a>
			   </td>
			</tr>
		  </tbody>
		</table>
		 <table class="categorySortBarTable">
		  <tbody>
		    <tr>
			   <td><input type="text" placeholder="请输入" class="sortBarPrice beginPrice"></td>
			   <td class="grayColumn priceMiddleColumn">-</td>
			   <td><input type="text" placeholder="请输入" class="sortBarPrice endPrice"></td>
			</tr>
		  </tbody>
		</table>
    </div>
	<!--categoryProducts.htm-->
	<div class="categoryProducts">
      <c:forEach items="${c.products}" var="p">
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
<div style="heigth:200px"></div>