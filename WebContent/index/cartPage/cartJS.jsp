<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<style>
.numberMinus,.numberPlus{
    cursor:pointer;
}
.inp:focus{
  outline:none;
  border-style:solid;
  border-color:#03a9f4;
  box-shadow:0 0 5px #03a9f4;
}
</style>
<script>
/*
*公共函数：以千进制格式化金额，比如金额是123456,就会显示成123,456
*/
function formatMoney(num){
    num = num.toString().replace(/\$|\,/g,''); 
    if(isNaN(num)) 
        num = "0"; 
    sign = (num == (num = Math.abs(num))); 
    num = Math.floor(num*100+0.50000000001); 
    cents = num%100; 
    num = Math.floor(num/100).toString(); 
    if(cents<10) 
    cents = "0" + cents; 
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++) 
    num = num.substring(0,num.length-(4*i+3))+','+ 
    num.substring(num.length-(4*i+3)); 
    return (((sign)?'':'-') + num + '.' + cents); 
}
/*
*公共函数：判断是否有商品被选中，
*只要有任意商品被选中了，就把结算按钮的颜色变为天猫红，
*并且是可点击状态，否则就是灰色，并且无法点击。
*/
function syncCreateOrderButton(){
    var selectAny = false;
    $(".cartProductItemIfSelected").each(function(){
        if("selectit"==$(this).attr("selectit")){
            selectAny = true;
        }
    });
    if(selectAny){
        $("button.createOrderButton").css("background-color","#C40000");
        $("button.createOrderButton").removeAttr("disabled");
    }
    else{
        $("button.createOrderButton").css("background-color","#AAAAAA");
        $("button.createOrderButton").attr("disabled","disabled");     
    }
}
/*
*公共函数：同步"全选"状态。 
*选中和未选中是采用了两个不同的图片实现的，
*并且是可点击状态，否则就是灰色，并且无法点击。
*遍历所有的商品，看是否全部都选中了，只要有任意一个没有选中，那么就不是全选状态。
*然后通过切换图片显示是否全选状态的效果。
*/
function syncSelect(){
    var selectAll = true;
    $(".cartProductItemIfSelected").each(function(){
        if("false"==$(this).attr("selectit")){
            selectAll = false;
        }
    });
    if(selectAll)
        $("img.selectAllItem").attr("src","http://how2j.cn/tmall/img/site/cartSelected.png");
    else
        $("img.selectAllItem").attr("src","http://how2j.cn/tmall/img/site/cartNotSelected.png");
}
/*
*公共函数：显示被选中的商品总数，以及总价格。 
*通过遍历每种商品是否被选中，累加被选中商品的总数和总价格，
*然后修改在上方的总价格，以及下方的总价格，总数
*/
function calcCartSumPriceAndNumber(){
    var sum = 0;
    var totalNumber = 0;
    $("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
        var oiid = $(this).attr("oiid");
        var price =$(".cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
        price = price.replace(/,/g, "");
        price = price.replace(/￥/g, "");
        sum += new Number(price);  
        var num =$(".orderItemNumberSetting[oiid="+oiid+"]").val();
        totalNumber += new Number(num);
    });
    $("span.cartSumPrice").html("￥"+formatMoney(sum));
    $("span.cartTitlePrice").html("￥"+formatMoney(sum));
    $("span.cartSumNumber").html(totalNumber);
}
/*
*公共函数：同步商品总数和总价格 
*根据商品数量，商品价格，同步小计价格，
*接着调用calcCartSumPriceAndNumber()函数同步商品总数和总价格
*/
function syncPrice(pid,num,numOrigin,price){	
    $(".orderItemNumberSetting[pid="+pid+"]").val(num);
    var cartProductItemSmallSumPrice = formatMoney(num*price);
    $(".cartProductItemSmallSumPrice[pid="+pid+"]").html("￥"+cartProductItemSmallSumPrice);
    calcCartSumPriceAndNumber();
    var totalCartSpan=parseInt($("#totalCartSpan").html())+parseInt(num)-parseInt(numOrigin);//修改后购物车数量
    
    var page = "forechangeOrderItem";
    $.post(
    		page,
            {"pid":pid,"number":num,"totalCartSpan":totalCartSpan},
            function(result){
                if("success"!=result){
                    //alert("result:"+result);
                	location.href="login.jsp";
                }else{
                	
                	//var totalCartSpan=parseInt($("#totalCartSpan").html())+parseInt(num)-parseInt(numOrigin);
                	$("#totalCartSpan").html(totalCartSpan);
                	//alert(totalCartSpan);
                }
            }
    );
}
</script>
<script>
/*
*接下来是对各种不停的事件进行监听，并作出响应，有如下4中事件需要监听
*1. 选中一种商品
*2. 商品全选
*3. 增加和减少数量
*4. 直接修改数量
*/
$(function(){
    /*                      1 选中一种商品
	*当选中某一种商品的时候，根据这个图片上的自定义属性selectit，判断当前的选中状态。
    *<img src="http://127.0.0.1/tmall/img/site/cartNotSelected.png" class="selectAllItem" selectit="false">
    */
	$("img.cartProductItemIfSelected").click(function(){
        var selectit = $(this).attr("selectit")
		//如果已经选中了，那么就切换为未选中图片，修改selectit属性为false,并且把所在的tr背景色换为白色
        if("selectit"==selectit){
            $(this).attr("src","http://how2j.cn/tmall/img/site/cartNotSelected.png");
            $(this).attr("selectit","false")
            $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
        }
		//如果是未选中，那么就切换为已选中图片，修改selectit属性为selected,并且把所在的tr背景色换为#FFF8E1
        else{
            $(this).attr("src","http://how2j.cn/tmall/img/site/cartSelected.png");
            $(this).attr("selectit","selectit")
            $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
        }
		//然后调用
        syncSelect();
        syncCreateOrderButton();
        calcCartSumPriceAndNumber();		
    });//对结算按钮，是否全选按钮，总数量、总价格信息显示进行同步
    /*                       2  商品全选
	*当点击全选图片的时候，做出的响应
	*首选全选图片上有一个自定义的selectit属性，用于表示该图片是否被选中
	*<img src="http://127.0.0.1/tmall/img/site/cartNotSelected.png" class="selectAllItem" selectit="false">
	*/
	$("img.selectAllItem").click(function(){
        var selectit = $(this).attr("selectit")//获取当前的选中状态
		//如果是已选中，那么就把图片切换为未选中状态，并把selectit属性值修改为false，
		//然后把每种商品对应的图片，都修改为未选中图片
		//属性selected也修改为false，背景颜色修改为白色。
        if("selectit"==selectit){
            $("img.selectAllItem").attr("src","http://how2j.cn/tmall/img/site/cartNotSelected.png");
            $("img.selectAllItem").attr("selectit","false")
            $(".cartProductItemIfSelected").each(function(){
                $(this).attr("src","http://how2j.cn/tmall/img/site/cartNotSelected.png");
                $(this).attr("selectit","false");
                $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
            });        
        }
		//如果是未选中，那么就把图片切换为以选中状态，并把selectit属性值修改为selected，
		//然后把每种商品对应的图片，都修改为已选中图片，
		//属性selected也修改为selected，背景颜色修改为#FFF8E1。
        else{
            $("img.selectAllItem").attr("src","http://how2j.cn/tmall/img/site/cartSelected.png");
            $("img.selectAllItem").attr("selectit","selectit")
            $(".cartProductItemIfSelected").each(function(){
                $(this).attr("src","http://how2j.cn/tmall/img/site/cartSelected.png");
                $(this).attr("selectit","selectit");
                $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
            });            
        }
		//最后调用
        syncCreateOrderButton();
        calcCartSumPriceAndNumber();
    });//同步结算按钮和价格数量信息
	/*                     直接修改数量
	*监听keyup事件，根据超链上的pid，获取这种商品对应的库存，价格和数量。 
	*如果数量小于1，那么就取1,如果大于库存，就取库存值。
	*/
	$(".orderItemNumberSetting").focus(function(){
		var pid=$(this).attr("pid");		
		var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
		var stock= $("span.orderItemStock[pid="+pid+"]").text();
		var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
        var numOrigin=parseInt(num);//保存修改前的数量值
        //alert("修改前numOrigin"+numOrigin);      
        $(this).change(function(){
        	num= $(".orderItemNumberSetting[pid="+pid+"]").val();
        	num=parseInt(num);
        	if(isNaN(num))
                num= 1;
            if(num<=0)
                num = 1;
            if(num>stock)
                num = stock;
        	//alert("修改后num"+num);
        	//alert("修改前numOrigin"+numOrigin); 
        	syncPrice(pid,num,numOrigin,price);  
        });
             
	});
    
	/*                     3  增加和减少数量
	*点击增加按钮，根据超链上的pid，获取这种商品对应的库存，价格和数量。
	*如果数量超过了库存，那么就取库存值。
	*/
    $(".numberPlus").click(function(){
        var pid=$(this).attr("pid");
        var stock= $("span.orderItemStock[pid="+pid+"]").text();
        var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
        var num= $(".orderItemNumberSetting[pid="+pid+"]").val();    
        var numOrigin=parseInt(num);//保存修改前的数量值
        num = parseInt(num);
        num++;
        if(num>stock)
            num = stock;
        //最后调用syncPrice，同步价格和总数信息。       
        syncPrice(pid,num,numOrigin,price);
    });
	/*                     3  增加和减少数量
	*点击减少按钮，根据超链上的pid，获取这种商品对应的库存，价格和数量。
	*如果数量小于1，那么就取1.
	*/
    $(".numberMinus").click(function(){
        var pid=$(this).attr("pid");
        var stock= $("span.orderItemStock[pid="+pid+"]").text();
        var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
        var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
        var numOrigin=parseInt(num);//保存修改前的数量值
        num = parseInt(num);
        --num;
        if(num<=0)
            num=1;
		//最后调用syncPrice，同步价格和总数信息。
        syncPrice(pid,num,numOrigin,price);
    });
})
</script>
<script>
/*删除*/
 var deleteOrderItemid = 0;//全局变量
 $(function(){
	 $("a.deleteOrderItem").click(function(){
		 var oiid = $(this).attr("oiid");
	     deleteOrderItemid = oiid;	 	  
	     $("#deleteConfirmModal").modal('show');   		 
	 });
	 $(".deleteConfirmButton").click(function(){
			$("#deleteConfirmModal").modal('hide');			
				var page="foredeleteOrderItem";		
				var deleteNum=$(".orderItemNumberSetting[oiid="+deleteOrderItemid+"]").val();//被删除订单项的数量	   
			    var totalCartSpan=parseInt($("#totalCartSpan").html())-parseInt(deleteNum);//购物车数量
			    totalCartSpan=parseInt(totalCartSpan);	   
				$.post(
				    page,
				    {"oiid":deleteOrderItemid,"totalCartSpan":totalCartSpan},
				    function(result){
		                if("success"==result){
		                	//alert(result);
		                    $("tr.cartProductItemTR[oiid="+deleteOrderItemid+"]").hide();
		                    $("#totalCartSpan").html(totalCartSpan);//修改购物车数量
		                }
		            }
				);							
		});
 });
 
</script>
<script>
$(function(){
	$("button.createOrderButton").click(function(){
		var params = "";
		 $(".cartProductItemIfSelected").each(function(){
			 if("selectit"==$(this).attr("selectit")){
				 var oiid = $(this).attr("oiid");
				 params += "&oiid="+oiid;
			 }
		 });
		
		params = params.substring(1);
		location.href="forebuy?"+params;
	});
});
</script>
<div class="cartDiv">
    <!--上方的结算,飘在右边--->
    <div class="cartTitle pull-right">
	    <span>已选商品（不含运费）</span>
		<span class="cartTitlePrice">￥0.00</span>
		<button class="createOrderButton" style="background-color: rgb(170, 170, 170);" disabled="disabled">结算</button>
	</div>
	<!--订单项内容-->
	<div class="cartDiv">
<div class="cartProductList">
    <table class="cartProductTable">
	   <thead>
	       <tr>
		      <th class="selectAndImage">
			      <img class="selectAllItem" selectit="false" src="http://how2j.cn/tmall/img/site/cartNotSelected.png">
		          <span>全选</span>	
			  </th>
			  <th>商品信息</th>
			  <th>单价</th>
			  <th>数量</th>
			  <th width="120px">金额</th>
			  <th  class="operation">操作</th>
		   </tr>
	   </thead>
	   <tbody>
	       <c:forEach items="${ois}" var="oi">
	       <tr class="cartProductItemTR" oiid="${oi.id}">
		       <td>
			       <img class="cartProductItemIfSelected" oiid="${oi.id}" selectit="false" src="img/site/cartNotSelected.png">
		           <a href="#nowhere" style="display:none">
			           <img src="img/site/cartSelected.png">
			       </a>
			       <img  class="cartProductImg" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg">
			   </td>
			   <td>
			       <div class="cartProductLinkOutDiv">
				        <a class="cartProductLink" href="#nowhere">${oi.product.name}</a>
						<div class="cartProductLinkInnerDiv">
						    <img title="支持信用卡支付" src="http://how2j.cn/tmall/img/site/creditcard.png">
							<img title="消费者保障服务,承诺7天退货" src="http://how2j.cn/tmall/img/site/7day.png">
							<img title="消费者保障服务,承诺如实描述" src="http://how2j.cn/tmall/img/site/promise.png">
						</div>
				   </div>
			   </td>
			   <td>
			       <span class="cartProductItemOringalPrice">￥ ${oi.product.orignalPrice}</span>
				   <span class="cartProductItemPromotionPrice">￥ ${oi.product.promotePrice}</span>
			   </td>
			   <td>
			       <div class="cartProductChangeNumberDiv">
				       <!--自定义-->
				       <span pid="${oi.product.id}" class="hidden orderItemStock ">${oi.product.stock}</span>
					   <span pid="${oi.product.id}" class="hidden orderItemPromotePrice ">${oi.product.promotePrice}</span>
					   <!--自定义-->
					   <a  class="numberMinus" pid="${oi.product.id}">-</a>
					   <input  value="${oi.number}" autocomplete="off" class="orderItemNumberSetting inp" oiid="${oi.id}" pid="${oi.product.id}">
					   <a  class="numberPlus" pid="${oi.product.id}" stock="${oi.product.stock}">+</a>
				   </div>
			   </td>
			   <td>
			       <span pid="${oi.product.id}" oiid="${oi.id}" class="cartProductItemSmallSumPrice">
			           ￥<fmt:formatNumber type="number" value="${oi.product.promotePrice*oi.number}" minFractionDigits="2"/>
			       </span>
			   </td>
			     <td>
			       <a class="deleteOrderItem" oiid="${oi.id}"  >删除</a>
			   </td>
		   </tr>
		   </c:forEach>
	   </tbody>
	</table>
</div>
</div>
	<!--下方的结算-->
	<div class="cartFoot">
	    <img src="http://how2j.cn/tmall/img/site/cartNotSelected.png" class="selectAllItem" selectit="false">
		<span>全选</span>
	    <!--结算子div，飘在右边-->
	    <div class="pull-right">
		     <span >已选商品<span  class="cartSumNumber">0</span>件 合计（不含运费）</span>
			 <span class="cartSumPrice">￥0.00</span>
			 <button class="createOrderButton" style="background-color: rgb(170, 170, 170);" disabled="disabled">
			           结算
			 </button>
		</div>
	</div>
</div>