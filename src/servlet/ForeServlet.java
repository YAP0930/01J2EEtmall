package servlet;


import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.RandomUtils;


import Comparator.ProductAllComparator;
import Comparator.ProductDateComparator;
import Comparator.ProductPriceComparator;
import Comparator.ProductReviewComparator;
import Comparator.ProductSaleCountComparator;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import bean.Category;
import bean.Order;
import bean.OrderItem;
import bean.Product;
import bean.PropertyValue;
import bean.Review;
import bean.User;
import dao.CategoryDAO;
import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.ProductDAO;
import dao.PropertyValueDAO;
import dao.ReviewDAO;
import dao.UserDAO;

public class ForeServlet extends BaseForeServlet{

	public void deleteOrder(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		int oid = Integer.parseInt(request.getParameter("oid"));
	    Order o = new OrderDAO().get(oid);
	    o.setStatus(OrderDAO.delete);
	    new OrderDAO().update(o);
	    response.getWriter().print("success");
	}
	
	public void doreview(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//int oid = Integer.parseInt(request.getParameter("oid"));
	    //Order o = new OrderDAO().get(oid);
	    //o.setStatus(OrderDAO.finish);
	    //new OrderDAO().update(o);
	    
	    int pid = Integer.parseInt(request.getParameter("pid"));
	    Product p = new ProductDAO().get(pid);
	    
	    String content = request.getParameter("content");
	    //content = HtmlUtils.htmlEscape(content);
	    
	    User user =(User) request.getSession().getAttribute("user");
	    Review review = new Review();
	    review.setContent(content);
	    review.setProduct(p);
	    review.setCreateDate(new Date());
	    review.setUser(user);
	    new ReviewDAO().add(review);
	    //response.sendRedirect("forereview?oid="+oid+"&showonly=true"); 
	    response.getWriter().print("success");
	}	
	public void reviewAjax(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		/*
		int oid = Integer.parseInt(request.getParameter("oid"));
	    Order o = new OrderDAO().get(oid);	
	    o.setStatus(OrderDAO.finish);//
	    new OrderDAO().update(o);//
	    new OrderDAO().setOrderItems(o);
	    */
	    //Product p = o.getOrderItems().get(0).getProduct();
	    //List<Review> reviews = new ReviewDAO().list(p.getId());
	    //new ProductDAO().setSaleAndReviewNumber(p);
		/*
	    List<List<Review>>reviewlists=new ArrayList<List<Review>>();
	    List<Product> products=new ArrayList<Product>();
	    List<OrderItem>oItems= o.getOrderItems();
	    for(int i=0;i<oItems.size();i++){
	    	Product p=oItems.get(i).getProduct();
	    	new ProductDAO().setSaleAndReviewNumber(p);
	    	products.add(p);
	    	List<Review> reviews = new ReviewDAO().list(p.getId());
	    	reviewlists.add(reviews);
	    }
	    
	    
	    String showonly = request.getParameter("showonly");
	    request.setAttribute("showonly", showonly);	
	    //request.setAttribute("p", p);
	    request.setAttribute("ps", products);
	    request.setAttribute("o", o);
	    //request.setAttribute("reviews", reviews);
	    request.setAttribute("rlists", reviewlists);
	    */
	    response.getWriter().print("success");	
	}
	public void review(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		int oid = Integer.parseInt(request.getParameter("oid"));
	    Order o = new OrderDAO().get(oid);	
	    o.setStatus(OrderDAO.finish);//
	    new OrderDAO().update(o);//
	    new OrderDAO().setOrderItems(o);
	    
	    //Product p = o.getOrderItems().get(0).getProduct();
	    //List<Review> reviews = new ReviewDAO().list(p.getId());
	    //new ProductDAO().setSaleAndReviewNumber(p);
	    List<List<Review>>reviewlists=new ArrayList<List<Review>>();
	    List<Product> products=new ArrayList<Product>();
	    List<OrderItem>oItems= o.getOrderItems();
	    for(int i=0;i<oItems.size();i++){
	    	Product p=oItems.get(i).getProduct();
	    	new ProductDAO().setSaleAndReviewNumber(p);
	    	products.add(p);
	    	List<Review> reviews = new ReviewDAO().list(p.getId());
	    	reviewlists.add(reviews);
	    }
	    
	    
	    String showonly = request.getParameter("showonly");
	    request.setAttribute("showonly", showonly);	
	    //request.setAttribute("p", p);
	    request.setAttribute("ps", products);
	    request.setAttribute("o", o);
	    //request.setAttribute("reviews", reviews);
	    request.setAttribute("rlists", reviewlists);
	    request.getRequestDispatcher("/index/review.jsp").forward(request, response);     
	}	
	public void orderFinish(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int oid = Integer.parseInt(request.getParameter("oid"));
	    Order o = new OrderDAO().get(oid);
	    o.setStatus(OrderDAO.waitReview);
	    o.setConfirmDate(new Date());
	    new OrderDAO().update(o);
	     
	    request.getRequestDispatcher("/index/orderFinish.jsp").forward(request, response);
	}
	public void confirmPay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int oid = Integer.parseInt(request.getParameter("oid"));
	    Order o = new OrderDAO().get(oid);
	    new OrderDAO().setOrderItems(o);
	  
	    new OrderItemDAO().setFirstProductImage(o.getOrderItems());
	  
	    
	   
	    
	    
	    request.setAttribute("o", o);
	     
	    request.getRequestDispatcher("/index/confirmPay.jsp").forward(request, response);
	}
	public void bought(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    User user =(User) request.getSession().getAttribute("user");
	    List<Order> os= new OrderDAO().list(user.getId(),OrderDAO.delete);	     
	    new OrderDAO().setOrderItems(os);
	    for(Order o:os){
	    	new OrderItemDAO().setFirstProductImage(o.getOrderItems());
	    }
	    new OrderDAO().setTotalNumber(os, user);
	    request.setAttribute("os", os);
	     
	    request.getRequestDispatcher("/index/bought.jsp").forward(request, response);
	}
	public void payed(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		User user=(User) request.getAttribute("user");
		int oid = Integer.parseInt(request.getParameter("oid"));
	    Order order = new OrderDAO().get(oid);
	    new OrderDAO();
		order.setStatus(OrderDAO.waitDelivery);
	    order.setPayDate(new Date());
	    new OrderDAO().update(order);
	    
	  
	    request.setAttribute("o", order);
		request.getRequestDispatcher("/index/payed.jsp").forward(request, response);
	}
	public void alipay(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		request.getRequestDispatcher("/index/alipay.jsp").forward(request, response);
	}
	public void createOrder(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		User user=(User) request.getSession().getAttribute("user");
		int totalCart=(int) request.getSession().getAttribute("totalCart");//修改购物车的数量
		List<OrderItem> ois= (List<OrderItem>) request.getSession().getAttribute("ois");
		if(ois.isEmpty())
	        response.sendRedirect("index/login.jsp");
		
		Order order = new Order();
		String address = request.getParameter("address");
	    String post = request.getParameter("post");
	    String receiver = request.getParameter("receiver");
	    String mobile = request.getParameter("mobile");
	    String userMessage = request.getParameter("userMessage");
	    String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) +RandomUtils.nextInt(10000);
		
	    order.setOrderCode(orderCode);
	    order.setAddress(address);
	    order.setPost(post);
	    order.setReceiver(receiver);
	    order.setMobile(mobile);
	    order.setUserMessage(userMessage);
	    order.setCreateDate(new Date());
	    order.setUser(user);
	    new OrderDAO();
		order.setStatus(OrderDAO.waitPay);
	    
	    new OrderDAO().add(order);
	    
	    float total =0;
	    for (OrderItem oi: ois) {
	        oi.setOrder(order);
	        new OrderItemDAO().update(oi);
	        total+=oi.getProduct().getPromotePrice()*oi.getNumber();
	        //修改购物车的数量
	        totalCart=totalCart-oi.getNumber();
	    }
	    //修改购物车的数量
	    request.getSession().setAttribute("totalCart", totalCart);
	    response.sendRedirect("forealipay?oid="+order.getId() +"&total="+total);
	}
	public void deleteOrderItem(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		User user=(User) request.getSession().getAttribute("user");
		if(null==user){
			response.getWriter().print("fail");
		}
		else{
			int oiid = Integer.parseInt(request.getParameter("oiid"));
			int totalCartSpan = Integer.parseInt(request.getParameter("totalCartSpan"));
			request.getSession().setAttribute("totalCart",totalCartSpan);
			new OrderItemDAO().delete(oiid);
			response.getWriter().print("success");
		}
	}
	public void changeOrderItem(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		User user=(User) request.getSession().getAttribute("user");
		if(null==user){
			System.out.println("user1:"+user);
			System.out.println("user:"+" fail");
			response.getWriter().print("fail");
			 System.out.println("user:"+" fail");
		}
		    	
		else{
			System.out.println("user2:"+user);
			int pid = Integer.parseInt(request.getParameter("pid"));
		    int number = Integer.parseInt(request.getParameter("number"));
		    int totalCartSpan = Integer.parseInt(request.getParameter("totalCartSpan"));
		    request.getSession().setAttribute("totalCart",totalCartSpan);
		    List<OrderItem> oItems=new OrderItemDAO().listByUser(user.getId());
			 for (OrderItem oi : oItems) {
			        if(oi.getProduct().getId()==pid){
			            oi.setNumber(number);
			            new OrderItemDAO().update(oi);
			            break;
			        }
			         
			    }      
			 System.out.println("user:"+" success");
			 response.getWriter().print("success");
			 System.out.println("user:"+" success");
		}
		  
	}
	public void cart(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		User user=(User) request.getSession().getAttribute("user");
		
		List<OrderItem> oItems=new OrderItemDAO().listByUser(user.getId());
		for(OrderItem oi:oItems){
			new ProductDAO().setFirstProductImage(oi.getProduct());
		}
		request.setAttribute("ois", oItems);
		request.getRequestDispatcher("/index/cart.jsp").forward(request, response);
	}
	public void addCart(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		int pid=Integer.parseInt(request.getParameter("pid"));
		int num=Integer.parseInt(request.getParameter("num"));
		int totalCartSpan=Integer.parseInt(request.getParameter("totalCartSpan"));
		int oiid = 0;
		
		User user=(User) request.getSession().getAttribute("user");
		//int totalCart=(int) request.getSession().getAttribute("totalCart")+num;//修改购物车数量
		request.getSession().setAttribute("totalCart",totalCartSpan);//修改购物车数量
		List<OrderItem> ois = new OrderItemDAO().listByUser(user.getId());
		boolean found = false;
		for (OrderItem oi : ois) {
			if (oi.getProduct().getId() == pid) {//
				oi.setNumber(oi.getNumber() + num); //
				
				new OrderItemDAO().update(oi);
				oiid = oi.getId();
				
				found = true;
				break;
			}
		}    
		if(!found){
	        OrderItem oi = new OrderItem();
	        oi.setUser(user);
	        oi.setNumber(num);
	        oi.setProduct(new ProductDAO().get(pid));
	        new OrderItemDAO().add(oi);
	        oiid = oi.getId();
	    }
		
		response.getWriter().print("success");
		
    }
	public void buy(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		String[] oiids=request.getParameterValues("oiid");
	    List<OrderItem> ois = new ArrayList<>();
	    float total = 0;
	    for (String strid : oiids) {
	    	int oiid = Integer.parseInt(strid);
	    	OrderItem oi= new OrderItemDAO().get(oiid);
	    	new ProductDAO().setFirstProductImage(oi.getProduct());
	    	total +=oi.getProduct().getPromotePrice()*oi.getNumber();
	    	ois.add(oi);
	    }
		
	    request.getSession().setAttribute("ois", ois);
	    request.setAttribute("total", total);
		request.getRequestDispatcher("/index/buy.jsp").forward(request, response);
    
    }
	public void buyonce(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		int pid=Integer.parseInt(request.getParameter("pid"));
		int num=Integer.parseInt(request.getParameter("num"));
		int oiid = 0;
		
		User user=(User) request.getSession().getAttribute("user");
		List<OrderItem> ois = new OrderItemDAO().listByUser(user.getId());
		boolean found = false;
		for (OrderItem oi : ois) {
			if (oi.getProduct().getId() == pid) {
				oi.setNumber(oi.getNumber() + num); 
				
				new OrderItemDAO().update(oi);
				oiid = oi.getId();
				
				
				found = true;
				break;
			}
		}    
		if(!found){
	        OrderItem oi = new OrderItem();
	        oi.setUser(user);
	        oi.setNumber(num);
	        oi.setProduct(new ProductDAO().get(pid));
	        new OrderItemDAO().add(oi);
	        oiid = oi.getId();
	        
		}
	    
		response.sendRedirect("forebuy?oiid="+oiid);
		
    }
	public void  checkLogin(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{	
		User user =(User) request.getSession().getAttribute("user");		
	    System.out.println("user"+user);
		if(null!=user){	  
			System.out.println("【1】success");
			int totalCart=Integer.parseInt(request.getParameter("totalCartSpan"));
			System.out.println("【2】success");
			request.getSession().setAttribute("totalCart", totalCart);
			System.out.println("【3】success");
			response.getWriter().print("success");   
			System.out.println("【4】success");
		}else{
			response.getWriter().print("fail");
		}
	    
		
    }
	public void search(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		String keyword=request.getParameter("keyword");
		List<Product> ps= new ProductDAO().search(keyword,0,20);
	    new ProductDAO().setSaleAndReviewNumber(ps);
		
		request.setAttribute("ps", ps);
		request.getRequestDispatcher("/index/searchResult.jsp").forward(request, response);
    }
	public void product(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		int pid=Integer.parseInt(request.getParameter("pid"));
		Product product=new ProductDAO().get(pid);
		new ProductDAO().setFirstProductImage(product);
		new ProductDAO().setProductDetailImages(product);
		new ProductDAO().setSaleAndReviewNumber(product);
		List<PropertyValue> pValues=new PropertyValueDAO().list(pid);
		List<Review> reviews=new ReviewDAO().list(pid);
		
		System.out.println("pid"+product.getId());
		
		request.setAttribute("p", product);
		request.setAttribute("pValues", pValues);
		request.setAttribute("reviews", reviews);
		request.getRequestDispatcher("/index/product.jsp").forward(request, response);
    }
	public void category(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		int cid=Integer.parseInt(request.getParameter("cid"));
		Category category=new CategoryDAO().get(cid);
		new ProductDAO().setSaleAndReviewNumber(category.getProducts()); 
		
		String sort = request.getParameter("sort");
		if(null!=sort){
		    switch(sort){
		        case "review":
		            Collections.sort(category.getProducts(),new ProductReviewComparator());
		            break;
		        case "date" :
		            Collections.sort(category.getProducts(),new ProductDateComparator());
		            break;
		             
		        case "saleCount" :
		            Collections.sort(category.getProducts(),new ProductSaleCountComparator());
		            break;
		             
		        case "price":
		            Collections.sort(category.getProducts(),new ProductPriceComparator());
		            break;
		             
		        case "all":
		            Collections.sort(category.getProducts(),new ProductAllComparator());
		            break;
		        }
		    }
		
		request.setAttribute("c", category);
		request.getRequestDispatcher("/index/category.jsp").forward(request, response);
    }
	public void logout(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("totalCart");
		response.sendRedirect("forehome");
    }
	public void loginAjax(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		String name=request.getParameter("name");
    	String password=request.getParameter("password");
    	//name=HtmlUtils.htmlEscape(name);
    	System.out.println("name:"+request.getParameter("name"));
    	System.out.println("password:"+request.getParameter("password"));
    	User user=new UserDAO().get(name, password);
    	int totalCart=0;
    	if(null==user){
    		response.getWriter().print("fail");
    	}
    	else{
    		totalCart=new OrderItemDAO().getTotalCart(user);
    		request.getSession().setAttribute("totalCart", totalCart);
    		request.getSession().setAttribute("user", user);
    		System.out.println("user"+user);
    		response.getWriter().print("success");
    	}
    }
	public void login(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		String name=request.getParameter("name");
    	String password=request.getParameter("password");
    	//name=HtmlUtils.htmlEscape(name);
    	System.out.println("name:"+request.getParameter("name"));
    	System.out.println("password:"+request.getParameter("password"));
    	User user=new UserDAO().get(name, password);
    	int totalCart=0;
    	if(null==user){
    		request.getSession().setAttribute("totalCart", totalCart);
    		request.setAttribute("message", "账户密码错误");
    		request.getRequestDispatcher("/index/login.jsp").forward(request, response);
    	}
    	else{
    		totalCart=new OrderItemDAO().getTotalCart(user);//
    		request.getSession().setAttribute("user", user);
    		request.getSession().setAttribute("totalCart", totalCart);
        	response.sendRedirect("forehome");
    	}
    }
	public void register(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	System.out.println("进入register方法");
		String name=request.getParameter("name");
    	String password=request.getParameter("password");
    	//name=HtmlUtils.htmlEscape(name);
    	System.out.println("name："+request.getParameter("name"));
    	System.out.println("password："+request.getParameter("name"));
    	boolean exist=new UserDAO().isExist(name);
    	System.out.println("exist："+exist);
    	if(exist){
    		request.setAttribute("message", "用户名已存在");
    		request.getRequestDispatcher("/index/register.jsp").forward(request, response);
    	}
    	else{
    		User user=new User();
        	user.setName(name);
        	user.setPassword(password);
        	new UserDAO().add(user);
        	response.sendRedirect("index/registerSuccess.jsp");
    	}
    }
	
	public void home(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	List<Category> categorys=new CategoryDAO().list(0, Short.MAX_VALUE);
    	request.setAttribute("categorys", categorys);
    	request.getRequestDispatcher("/index/home.jsp").forward(request, response);
    }
	
	
}
