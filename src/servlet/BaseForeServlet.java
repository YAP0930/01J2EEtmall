package servlet;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BaseForeServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request,
    		HttpServletResponse response){ 	
    	    try {
    	    	String method=(String) request.getAttribute("method");
    		    Method m=this.getClass().getMethod(method, 
    		    		HttpServletRequest.class,HttpServletResponse.class);
    		    m.invoke(this, request,response);
			} catch (Exception e) {
				// TODO: handle exception
			}
		
    }
}
