<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!--显示缩略图效果-->
<script>
//首先在小图片上有一个自定义属性bigImageURL，用于存放对应的图片的位置
//<img  width="100px" class="smallImage"  src="img/productSingle_small/8620.jpg" bigImageURL="img/productSingle/8620.jpg">
$(function(){
    //监听小图片的mouseenter事件
    $("img.smallImage").mouseenter(function(){
        var bigImageURL = $(this).attr("bigImageURL");//获取小图片的bigImageURL属性
        $("img.bigImg").attr("src",bigImageURL);//把大图片的src修改为该图片
        $(this).css({"border-style":"solid","border-color":"#C40000"});    
        $(this).mouseleave(function(){
        	$(this).css({"border-style":"solid","border-color":"white"});  
        	
        });
    });
	//预加载，因为图片比较大，所以需要进行预加载。
    $("img.bigImg").load(
        function(){
            $("img.smallImage").each(function(){
                var bigImageURL = $(this).attr("bigImageURL");//根据每个小图片的bigImageURL 
                img = new Image();//创建一个Image对象
                img.src = bigImageURL;//把这个image对象的src属性，设置为bigImageURL
                img.onload = function(){
                    console.log(bigImageURL);////当这个img对象加载完毕之后，  
                    $("div.img4load").append($(img));//再放到被隐藏的div.img4load中
                };
            });    
        }
    );
 
});
</script>
<div class="imgAndInfo">
	<div class="imgInimgAndInfo">
		<img alt="正在加载" src="img/productSingle/${p.firstProductImage.id}.jpg"
			width="100px" class="bigImg">
		<div class="smallImageDiv">
			<c:forEach items="${p.productSingleImages}" var="pi">
			<img alt="正在加载" width="100px" class="smallImage"
				src="img/productSingle_small/${pi.id}.jpg"
				bigImageURL="img/productSingle/${pi.id}.jpg">							
		    </c:forEach>
		</div>
		<div class="img4load hidden" ></div>
	</div>
</div>
