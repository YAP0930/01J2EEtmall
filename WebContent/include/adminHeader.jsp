<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" +     
        request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>">

<script src="<%=basePath%>/js/jquery/2.0.0/jquery.min.js"></script>
<link href="<%=basePath%>/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet"/>
<script src="<%=basePath%>/js/bootstrap/3.3.6/bootstrap.min.js"></script>

<script>
$(function(){
    $(".deleteLink").click(function(){     
        	var confirmDelete = confirm("确认要删除");
            if(confirmDelete)
                return true;
            return false;
             
  
    });
    $(".deleteLinkCategory").click(function(){     
    	var confirmDelete = confirm("确认要删除");
        if(confirmDelete){//true
        	var cid=$(this).attr("cid");
            cid=parseInt(cid);
            
        	var pageAjax="admin_category_deleteAjax";
        	
        	$.get(
        		pageAjax,
        		{"cid":cid},
        		function(result){
        			if("success"==result){
        				var page="admin_category_delete";
        				$.get(
        					page,
        					{"cid":cid},
            				function(result){
            					if("success"==result){
            						location.href="admin_category_list";
            					}
            				}
        				);
        			}else{
        				alert("删除失败！请先将该分类下的属性和产品数据进行删除！");
        			}
        		}
        	);
        }                   

    });
    $(".deleteLinkProduct").click(function(){     
    	var confirmDelete = confirm("确认要删除");
        if(confirmDelete){//true
        	var cid=$(this).attr("cid");
            cid=parseInt(cid);
            var pid=parseInt($(this).attr("pid"));
            var cstart=parseInt($(this).attr("cstart"));
        	var pageAjax="admin_product_deleteAjax";
        	
        	$.get(
        		pageAjax,
        		{"pid":pid},
        		function(result){
        			if("success"==result){
        				location.href="admin_product_list?cid="+cid+"&&cstart="+cstart;
        			}else{
        				//alert(result);
        				alert("删除失败！请先将该产品下的图片数据进行删除！");
        			}
        		}
        	);
        }                   

    });
})
</script>