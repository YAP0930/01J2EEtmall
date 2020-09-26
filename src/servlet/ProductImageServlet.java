package servlet;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Category;
import bean.Product;
import bean.ProductImage;
import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductImageDAO;

public class ProductImageServlet extends BaseBackServlet{
	 public void delete(HttpServletRequest request,HttpServletResponse response) throws IOException{
	    	int id=Integer.parseInt(request.getParameter("id"));
	    	new ProductImageDAO().delete(id);
	    	
	    	String filePath=request.getSession().getServletContext().getRealPath("img/productImage");
	    	String fileName=id+".jpg";
	    	File imageFile = new File(filePath+"/"+fileName);
	    	imageFile.delete();
	    	System.out.println(imageFile);
	    	int pid=Integer.parseInt(request.getParameter("pid"));
	    	int cid=Integer.parseInt(request.getParameter("cid"));
	    	int cstart=Integer.parseInt(request.getParameter("cstart"));
	    	int pstart=Integer.parseInt(request.getParameter("pstart"));
	    	response.sendRedirect("admin_productImage_list?pid="+pid+"&&cid="+cid
	    			+"&&cstart="+cstart+"&&pstart="+pstart);
	    }
	public void add(HttpServletRequest request,HttpServletResponse response) throws Exception{
		Map<String, String> params=new HashMap<>();
		InputStream is=null;
		InputStream is1=null;
		InputStream is2=null;
    	ProductImage productImage=new ProductImage();
    	
    	is=super.upload(request,params);//流读过一次就不能再读了
    	//先把InputStream转化成ByteArrayOutputStream
    	ByteArrayOutputStream baos = new ByteArrayOutputStream();  
    	byte[] buffer = new byte[1024];
    	int len;
    	while ((len = is.read(buffer)) > -1 ) {
    		baos.write(buffer, 0, len);
    	}
    	baos.flush();
    	//后面要使用InputStream对象时，再从ByteArrayOutputStream转化回来
    	               
    	//
    	productImage.setType(params.get("type"));
    	int pid=Integer.parseInt(params.get("pid"));
    	productImage.setProduct(new ProductDAO().get(pid));
    	new ProductImageDAO().add(productImage);
    	//
    	int id=productImage.getId();
    	String type=params.get("type");
    	char c=type.charAt(5);
    	String context="img/product"+Character.toUpperCase(c)+type.substring(6);
   
    	if(type.equals("type_single")){
    		InputStream stream = new ByteArrayInputStream(baos.toByteArray());  
    		super.saveUplod(request, stream, id,context);	    		
    		stream = new ByteArrayInputStream(baos.toByteArray());  
    		super.saveUplod(request, stream, id,context+"_middle");	
    		stream = new ByteArrayInputStream(baos.toByteArray());  
    		super.saveUplod(request, stream, id,context+"_small");
    	}else {
    		InputStream stream = new ByteArrayInputStream(baos.toByteArray());
    		super.saveUplod(request, stream, id,context);
		}	
    	int cid=Integer.parseInt(params.get("cid"));
    	int cstart=Integer.parseInt(params.get("cstart"));
    	int pstart=Integer.parseInt(params.get("pstart"));
    	response.sendRedirect("admin_productImage_list?pid="+pid+"&&cid="+cid
    			+"&&cstart="+cstart+"&&pstart="+pstart);
	}
	public void list(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	
    	int pid=Integer.parseInt(request.getParameter("pid"));
    	List<ProductImage>productSingleImages=new ProductImageDAO().list(pid,"type_single");
    	List<ProductImage>productDetailImages=new ProductImageDAO().list(pid,"type_detail");
    	int cid=Integer.parseInt(request.getParameter("cid"));
    	int cstart=Integer.parseInt(request.getParameter("cstart"));
    	int pstart=Integer.parseInt(request.getParameter("pstart"));
    	Category c=new CategoryDAO().get(cid);
    	Product p=new ProductDAO().get(pid);
    	request.setAttribute("c", c);
    	request.setAttribute("p", p);
    	request.setAttribute("pid", pid);
    	request.setAttribute("cstart", cstart);
    	request.setAttribute("pstart", pstart);
    	request.setAttribute("productSingleImages", productSingleImages);//��categories���ݸ�jsp
    	request.setAttribute("productDetailImages", productDetailImages);//��categories���ݸ�jsp
    	request.getRequestDispatcher("/admin/productimage/productImageList.jsp").forward(request, response);
    
    }
}
