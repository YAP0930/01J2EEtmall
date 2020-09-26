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

public  class ForeServletFilter implements Filter{

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("********这是ForeServletFilter过滤器**********");
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        request.setCharacterEncoding("UTF-8");//
        String contextPath=request.getServletContext().getContextPath();
        String uri = request.getRequestURI();
        uri =StringUtils.remove(uri, contextPath);
        System.out.println("uri路径："+uri);
        if(uri.startsWith("/fore")&&!uri.startsWith("/foreServlet")){  
        	System.out.println("/fore");

            String method = StringUtils.substringAfterLast(uri,"/fore" );
            request.setAttribute("method", method);
            
            System.out.println("servletPath:"+"/foreServlet");
            System.out.println("method:"+method);
            req.getRequestDispatcher("/foreServlet").forward(request, response);
     
            return;
        }
        System.out.println("**********放行************");  
        chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
