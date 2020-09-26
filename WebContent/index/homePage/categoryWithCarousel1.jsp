<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<script>
/*                              猫耳朵效果
监听菜单鼠标移入事件mouseenter，
当鼠标移入的时候，获取当前span的左，上和宽度信息，
根据这些信息，计算出猫耳朵应该出现的位置，
然后通过css设置猫耳朵的left和top数据， 
最后使用fadeIn(500)，在半秒内淡入猫耳朵图片。
*/
$(function(){
    $("div.rightMenu span").mouseenter(function(){
        var left = $(this).position().left;
        var top = $(this).position().top;
        var width = $(this).css("width");
        var destLeft = parseInt(left) + parseInt(width)/2;
        $("img#catear").css("left",destLeft);
        $("img#catear").css("top",top+193);
        $("img#catear").fadeIn(500);
    });
	//当鼠标移出的时候，隐藏猫耳朵
    $("div.rightMenu span").mouseleave(function(){
        $("img#catear").hide();
    });
});
</script>

<!--猫耳朵的交互-->
<div class="homepageDiv">
    <div style="height:50px"></div>
	<img class="catear" id="catear" src="img/site/catear.png"  style="left: 260.5px; top: 159.65px;display: none; ">
	
<!--categoryWithCarousel.html-->
<div  class="categoryWithCarousel">
  <!--导航条-->
  <div class="headbar">
    <div class="head">
        <span class="glyphicon glyphicon-th-list" style="margin-left:10px"></span>
		<span style="margin-left:10px">商品分类</span>
	</div>
	<div class="rightMenu">
	    <!--图片是白色的-->
	    <span><a href="forehome"><img src="img/site/chaoshi.png"></a></span>
	    <span><a href="forehome"><img src="img/site/guoji.png"></a></span>
	    <c:forEach items="${categorys}" var="c" varStatus="st">
	    <c:if test="${st.count<=4}">
	        <span><a href="forecategory?cid=${c.id}">${c.name}</a></span>
	    </c:if>
	    </c:forEach>
	</div>
  </div>
  <!--轮播-->
  <div id="myCarousel" class="carousel slide carousel-of-product">
	<!-- 轮播（Carousel）指标 -->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
		<li data-target="#myCarousel" data-slide-to="3"></li>
	</ol>   
	<!-- 轮播（Carousel）项目 -->
	<div class="carousel-inner">
		<div class="item active">
			<img src="img/lunbo/1.jpg" alt="First slide" class="carouselImage">
		</div>
		<div class="item">
			<img src="img/lunbo/2.jpg" alt="Second slide" class="carouselImage">
		</div>
		<div class="item">
			<img src="img/lunbo/3.jpg" alt="Third slide" class="carouselImage">
		</div>
		<div class="item">
			<img src="img/lunbo/4.jpg" alt="Four slide" class="carouselImage">
		</div>
	</div>
	<!-- 轮播（Carousel）导航 -->
	<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</a>
	<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</a>
</div> 
  <!--轮播下的背景色div-->
  <div class="carouselBackgroundDiv"></div> 
</div>
<!--categoryWithCarousel.html-->
</div>