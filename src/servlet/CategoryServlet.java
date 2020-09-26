package servlet;

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
import dao.CategoryDAO;
import dao.ProductDAO;
import dao.PropertyDAO;

public class CategoryServlet extends BaseBackServlet{
	public void add(HttpServletRequest request,HttpServletResponse response) throws Exception{
		Map<String, String> params=new HashMap<>();
		InputStream is=null;
    	Category category=new Category();

    	is=super.upload(request,params);
    
    	category.setName(params.get("name"));
    	new CategoryDAO().add(category);
    
    	int id=category.getId();
    	String context="img/category";
    	super.saveUplod(request, is, id,context);
    	   	
    	response.sendRedirect("admin_category_list");
	}
	public void deleteAjax(HttpServletRequest request,HttpServletResponse response) throws IOException{ 	
    	int cid=Integer.parseInt(request.getParameter("cid"));
    	boolean result=new CategoryDAO().delete(cid);
    	if(result==true){
    		response.getWriter().print("success");
    	}else{
    		response.getWriter().print("fail");
    	}
    	
    	//String filePath=request.getSession().getServletContext().getRealPath("img/category");
    	//String fileName=cid+".jpg";
    	//File imageFile = new File(filePath+"/"+fileName);
    	//imageFile.delete();
    	
    	//response.sendRedirect("admin_category_list");
    }
    public void delete(HttpServletRequest request,HttpServletResponse response) throws IOException{ 	
    	int cid=Integer.parseInt(request.getParameter("cid"));
    	new CategoryDAO().delete(cid);
    	
    	
    	String filePath=request.getSession().getServletContext().getRealPath("img/category");
    	String fileName=cid+".jpg";
    	File imageFile = new File(filePath+"/"+fileName);
    	imageFile.delete();
    	response.getWriter().print("success");
    	//response.sendRedirect("admin_category_list");
    }
    public void edit(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	int cid = Integer.parseInt(request.getParameter("cid"));
    	Category c = new CategoryDAO().get(cid);
    	
    	int cstart = Integer.parseInt(request.getParameter("cstart"));
    	request.setAttribute("c", c);
    	request.setAttribute("cstart", cstart);
    	request.getRequestDispatcher("/admin/category/categoryEdit.jsp").forward(request, response);
    
    }
    public void update(HttpServletRequest request,HttpServletResponse response) throws Exception{
    	
    	
    	InputStream is=null;
        Category category=new Category();
        Map<String, String> params=new HashMap<>();
        
        is=super.upload(request, params);
        
        category.setId(Integer.parseInt(params.get("id")));
        category.setName(params.get("name"));
        new CategoryDAO().update(category);
        
        
        String context="img/category";
        saveUplod(request, is, category.getId(),context);
       
        int cid=Integer.parseInt(params.get("id"));
        int cstart=Integer.parseInt(params.get("cstart"));
       // response.setHeader("Pragma","no-cache");    
       // response.setHeader("Cache-Control","no-cache");    
        //response.setDateHeader("Expires", -1);   
        response.sendRedirect("admin_category_list?cid="+cid+"&&start="+cstart);
    }
    public void list(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	int start=0;//每页开始位置ֵ
    	int count=5;//每页显示的数量
    	
    	try {
    		start=Integer.parseInt(request.getParameter("start"));
		} catch (NumberFormatException e) {
			// TODO: handle exception
		}
    	
    	List<Category>categories=new CategoryDAO().list(start,count);
    	
    	int total=new CategoryDAO().getTotal();//总共的数据数
    	
    	
    	int last=0;//末页的开始数值ֵ
    	if(0==total%count)
    		last=total - count;
    	else
    		last=total - total % count;
 
    	int pre=start-count;//前一页的开始位置ֵ
    	pre=pre>0?pre:0;//
    	int next=start+count;//后一页的开始位置ֵ
    	next=next<last?next:last;//
    	
    	int page=0;//定义总页数
    	if(0==total%count)
    		page=total / count;
    	else
    		page=total / count+1;
    
    	request.setAttribute("start", start);//传递一个start给propertyList.jsp页面
    	request.setAttribute("pre", pre);
    	request.setAttribute("next", next);
    	request.setAttribute("last", last);
    	request.setAttribute("page", page);
    	request.setAttribute("count", count);
    	request.setAttribute("categories", categories);
    	request.getRequestDispatcher("/admin/category/categoryList.jsp").forward(request, response);
    
    }
}
