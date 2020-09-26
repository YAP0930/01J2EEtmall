package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

public class BackServletFilter implements Filter{
	@Override
	public void destroy() {
        
    }
	
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
    	System.out.println("*********这是BackServletFilter过滤器**********");
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        request.setCharacterEncoding("UTF-8");//
        String contextPath=request.getServletContext().getContextPath();
        String uri = request.getRequestURI();//uri: /tmall/admin_category_list
        uri =StringUtils.remove(uri, contextPath);
        System.out.println("uri路径："+uri);
        if(uri.startsWith("/admin_")){ 
        	System.out.println("/admin_");
            String servletPath = StringUtils.substringBetween(uri,"_", "_") + "Servlet";
            String method = StringUtils.substringAfterLast(uri,"_" );
            request.setAttribute("method", method);
            req.getRequestDispatcher("/" + servletPath).forward(request, response);
           
            System.out.println("servletPath:"+servletPath);
            System.out.println("method:"+method);
     
            return;
        }
        System.out.println("**********放行************"); 
        chain.doFilter(request, response);
    }
	@Override
    public void init(FilterConfig arg0) throws ServletException {
     
    }
}
