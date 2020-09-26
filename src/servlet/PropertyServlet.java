package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Category;
import bean.Product;
import bean.Property;
import dao.CategoryDAO;
import dao.ProductDAO;
import dao.PropertyDAO;
import dao.PropertyValueDAO;


public class PropertyServlet extends BaseBackServlet{
	public void add(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
    	Property property=new Property();
    	String name=request.getParameter("name");
    	int cid=Integer.parseInt(request.getParameter("cid"));
    	property.setName(name);
    	property.setCategory(new CategoryDAO().get(cid));
    	int cstart=Integer.parseInt(request.getParameter("cstart"));//返回分类管理页面
    	new PropertyDAO().add(property);
    	/**填为该分类产品下的产品填充该属性**/
    	Category c=new CategoryDAO().get(cid);
    	new PropertyValueDAO().setPropertyValue(c, property);
    	/**/   	
    	response.sendRedirect("admin_property_list?cid="+cid+"&&cstart="+cstart);
	}
    public void delete(HttpServletRequest request,HttpServletResponse response) throws IOException{
    	int ptid=Integer.parseInt(request.getParameter("id"));
    	new PropertyValueDAO().deletePropertyValue(ptid);
    	new PropertyDAO().delete(ptid);
    	int cid=Integer.parseInt(request.getParameter("cid"));
    	int cstart=Integer.parseInt(request.getParameter("cstart"));//返回分类管理页面
    	response.sendRedirect("admin_property_list?cid="+cid+"&&cstart="+cstart);
    }
    public void edit(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	int id = Integer.parseInt(request.getParameter("id"));
    	int cid = Integer.parseInt(request.getParameter("cid"));
    	int cstart = Integer.parseInt(request.getParameter("cstart"));
    	Property p = new PropertyDAO().get(id);
    	Category c=new CategoryDAO().get(cid);
    	int prstart = Integer.parseInt(request.getParameter("prstart"));
    	request.setAttribute("p", p);
    	request.setAttribute("cid", cid);
    	request.setAttribute("c", c);//便于返回上一级：分类
    	request.setAttribute("cstart", cstart);//便于返回上一级：分类
    	request.setAttribute("prstart", prstart);//便于返回上一级：属性管理
    	request.getRequestDispatcher("/admin/property/propertyEdit.jsp").forward(request, response);
    
    }
    public void update(HttpServletRequest request,HttpServletResponse response) throws Exception{
        Property property=new Property();
        int id=Integer.parseInt(request.getParameter("id"));
        property=new PropertyDAO().get(id);
        
        String name=request.getParameter("name");
        property.setName(name);
        
        new PropertyDAO().update(property);
        
        int cid=Integer.parseInt(request.getParameter("cid"));
        int prstart=Integer.parseInt(request.getParameter("prstart"));
        int cstart=Integer.parseInt(request.getParameter("cstart"));
    	response.sendRedirect("admin_property_list?cid="+cid+"&&start="+prstart
    			+"&&cstart="+cstart);
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
    	List<Property>properties=new PropertyDAO().list(start,count,c);
    	request.setAttribute("c", c);
    	int total=new PropertyDAO().getTotal(cid);
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
    
    	request.setAttribute("start", start);//传递一个start给propertyList.jsp页面
    	int cstart=Integer.parseInt(request.getParameter("cstart"));    	    	
    	request.setAttribute("cstart", cstart);//传递给property.jsp，好返回上一级分类管理页面
    	request.setAttribute("pre", pre);
    	request.setAttribute("next", next);
    	request.setAttribute("last", last);
    	request.setAttribute("page", page);
    	request.setAttribute("count", count);
    	request.setAttribute("properties", properties);
    	request.getRequestDispatcher("/admin/property/propertyList.jsp").forward(request, response);
    
    }
}
