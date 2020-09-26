package servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Category;
import bean.Product;
import bean.Property;
import bean.PropertyValue;
import dao.CategoryDAO;
import dao.ProductDAO;
import dao.PropertyDAO;
import dao.PropertyValueDAO;

public class ProductServlet extends BaseBackServlet{
	public void updatePropertyValue(HttpServletRequest request,HttpServletResponse response) throws IOException{
		int pvid=Integer.parseInt(request.getParameter("pvid"));
		System.out.print("pvid:"+pvid);
		String value=request.getParameter("value");
		PropertyValue pValue=new PropertyValueDAO().get(pvid);
		pValue.setValue(value);
		String result=new PropertyValueDAO().update(pValue);
		System.out.print(result);
		response.getWriter().print(result);
	}
	public void editPropertyValue(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		int pid=Integer.parseInt(request.getParameter("pid"));
		Product p=new ProductDAO().get(pid);
		
		List<PropertyValue> pValues=new PropertyValueDAO().list(pid);
		int cstart=Integer.parseInt(request.getParameter("cstart"));
		int pstart=Integer.parseInt(request.getParameter("pstart"));
		int cid=Integer.parseInt(request.getParameter("cid"));
		Category c=new CategoryDAO().get(cid);
		
		request.setAttribute("p", p);
		request.setAttribute("pValues", pValues);
		request.setAttribute("cstart", cstart);
		request.setAttribute("pstart", pstart);
		request.setAttribute("c", c);
		request.getRequestDispatcher("/admin/propertyValue/propertyValueEdit.jsp").forward(request, response);
	}
     
	public void add(HttpServletRequest request,HttpServletResponse response) throws Exception{
	    Product product=new Product();
    	String name=request.getParameter("name");
    	String subTitle=request.getParameter("subTitle");
    	Float orignalPrice=Float.parseFloat(request.getParameter("orignalPrice"));
    	Float promotePrice=Float.parseFloat(request.getParameter("promotePrice"));
    	int stock=Integer.parseInt(request.getParameter("stock"));
    	int cid=Integer.parseInt(request.getParameter("cid"));
    	
    	product.setName(name);
    	product.setSubTitle(subTitle);
    	product.setOrignalPrice(orignalPrice);
    	product.setPromotePrice(promotePrice);
    	product.setStock(stock);
    	product.setCategory(new CategoryDAO().get(cid));
    	product.setCreateDate(new Date() );
    	
    	new ProductDAO().add(product);
    	new PropertyValueDAO().setPropertyValue(cid,product);//ceshi
    	int pstart=Integer.parseInt(request.getParameter("pstart"));  
    	int cstart=Integer.parseInt(request.getParameter("cstart"));   	
    	response.sendRedirect("admin_product_list?cid="+cid+"&&cstart="+cstart+"&&start="+pstart);
	}
	public void deleteAjax(HttpServletRequest request,HttpServletResponse response) throws IOException{
    	int pid=Integer.parseInt(request.getParameter("pid"));
    	boolean result=new ProductDAO().delete(pid);
    	if(true==result){
    		response.getWriter().print("success");
    	}else{
    		response.getWriter().print("fail");
    	}
    	//int cid=Integer.parseInt(request.getParameter("cid"));
    	//int cstart=Integer.parseInt(request.getParameter("cstart"));
    	//response.sendRedirect("admin_product_list?cid="+cid+"&&cstart="+cstart);
    }
    public void delete(HttpServletRequest request,HttpServletResponse response) throws IOException{
    	int id=Integer.parseInt(request.getParameter("id"));
    	new ProductDAO().delete(id);
    	int cid=Integer.parseInt(request.getParameter("cid"));
    	int cstart=Integer.parseInt(request.getParameter("cstart"));
    	response.sendRedirect("admin_product_list?cid="+cid+"&&cstart="+cstart);
    }
    public void edit(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	int id = Integer.parseInt(request.getParameter("id"));
    	int cid = Integer.parseInt(request.getParameter("cid"));
    	int pstart = Integer.parseInt(request.getParameter("pstart"));
    	Product product  = new ProductDAO().get(id);
    	
    	Category c=new CategoryDAO().get(cid);
    	int cstart = Integer.parseInt(request.getParameter("cstart"));//返回分类管理页面
    	request.setAttribute("c", c);
    	request.setAttribute("pstart", pstart);
    	request.setAttribute("cstart", cstart);
    	request.setAttribute("product", product);
    	request.setAttribute("cid", cid);
    	request.getRequestDispatcher("/admin/product/productEdit.jsp").forward(request, response);
    
    }
    public void update(HttpServletRequest request,HttpServletResponse response) throws Exception{
        Product product=new Product();
        int id=Integer.parseInt(request.getParameter("id"));
        product=new ProductDAO().get(id);
        
        String name=request.getParameter("name");
        String subTitle=request.getParameter("subTitle");
        float orignalPrice=Float.parseFloat(request.getParameter("orignalPrice"));
        float promotePrice=Float.parseFloat(request.getParameter("promotePrice"));
        int stock=Integer.parseInt(request.getParameter("stock"));
        
        product.setName(name);
        product.setSubTitle(subTitle);
        product.setOrignalPrice(orignalPrice);
        product.setPromotePrice(promotePrice);
        product.setStock(stock);
        
        new ProductDAO().update(product);
        int cid=Integer.parseInt(request.getParameter("cid"));
        int cstart=Integer.parseInt(request.getParameter("cstart"));
        int pstart=Integer.parseInt(request.getParameter("pstart"));
    	response.sendRedirect("admin_product_list?cid="+cid+"&&cstart="
    			+cstart+"&&id="+id+"&&start="+pstart);
    }
    public void list(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	int start=0;
    	int count=5;
    	
    	try {
    		start=Integer.parseInt(request.getParameter("start"));
		} catch (NumberFormatException e) {
			// TODO: handle exception
		}
    	
    	int cid=Integer.parseInt(request.getParameter("cid"));
    	Category c=new CategoryDAO().get(cid);
    	List<Product>products=new ProductDAO().list(start,count,c);
    	
    	
    	
    	request.setAttribute("c", c);
    	int total=new ProductDAO().getTotal(cid);
    	
    	
    	
    	int last=0;
    	if(0==total%count)
    		last=total - count;
    	else
    		last=total - total % count;
 
    	int pre=start-count;
    	pre=pre>0?pre:0;
    	int next=start+count;
    	next=next<last?next:last;
    	
    	int page=0;
    	if(0==total%count)
    		page=total / count;
    	else
    		page=total / count+1;
    
    	int cstart = Integer.parseInt(request.getParameter("cstart"));//返回分类管理页面
    	request.setAttribute("cstart", cstart);
    	request.setAttribute("start", start);
    	request.setAttribute("pre", pre);
    	request.setAttribute("next", next);
    	request.setAttribute("last", last);
    	request.setAttribute("page", page);
    	request.setAttribute("count", count);
    	request.setAttribute("products", products);
    	request.getRequestDispatcher("/admin/product/productList.jsp").forward(request, response);
    
    }
}
