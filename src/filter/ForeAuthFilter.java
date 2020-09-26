package filter;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import bean.User;

public class ForeAuthFilter implements Filter{
    
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("********这是ForeAuthFilter过滤器**********");
		
		//1.
		 String[] noNeedAuthPage = new String[]{
	                "home",
	                "checkLogin",
	                "register",
	                "loginAjax",
	                "login",
	                "product",
	                "category",
	                "search"};
		//2.
		 HttpServletRequest request = (HttpServletRequest) req;
		 HttpServletResponse  response = (HttpServletResponse) res;
		 String uri = request.getRequestURI();
		//3. 
		 String contextPath=request.getServletContext().getContextPath();
		 uri =StringUtils.remove(uri, contextPath);
		 System.out.println("uri路径："+uri);
		//4. 
		 if(uri.startsWith("/fore")&&!uri.startsWith("/foreServlet")){
			    /*4.1 */
			 String method = StringUtils.substringAfterLast(uri,"/fore" );
				/*4.2 */
			 if(!Arrays.asList(noNeedAuthPage).contains(method)){
				 /*4.3*/
					/*4.3 */
				 User user =(User) request.getSession().getAttribute("user");
				 if(null==user){
					  /*4.4*/
	                    response.sendRedirect("index/login.jsp");
	                    return;
	                }	
			 }			
		 }
		 System.out.println("**********放行************"); 
		 chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
