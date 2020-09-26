package servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Order;
import dao.OrderDAO;

public class OrderServlet extends BaseBackServlet{
	public void delivery(HttpServletRequest request,HttpServletResponse response) throws IOException{
		int oid=Integer.parseInt(request.getParameter("id"));
		Order order=new OrderDAO().get(oid);
		order.setDelivertDate(new Date());
		order.setStatus(OrderDAO.waitConfirm);
		new OrderDAO().update(order);
		
		int count=5;
		int start=oid;
		if(0==start%count)
			start=(start/count-1)*count;
		else
			start=start/count*count;
			
				
		response.sendRedirect("admin_order_list?start="+start);
	}
	public void list(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	
		int start=0;//
		int count=5;//
    	
    	try {//
    		start=Integer.parseInt(request.getParameter("start"));
		} catch (NumberFormatException e) {
			// TODO: handle exception
		}
    	
    	List<Order>orders=new OrderDAO().list(start,count);
    	
    	
    	for(Order order:orders){
    		//System.out.println("order.id"+order.getId());
    		//System.out.println("order.statusDesc"+order.getStatusDesc());
    		//System.out.println("order.total"+order.getTotal());
    		//System.out.println("order.totalNumber"+order.getTotalNumber());
    		//System.out.println("order.user.name"+order.getUser().getName());
    		
    	}
    	new OrderDAO().setOrderItems(orders);//填充订单项
    	
    	
    	
    	
    	int total=new OrderDAO().getTotal();//
    	
    	int last=0;//
    	if(0==total%count)
    		last=total - count;
    	else
    		last=total - total % count;
    	
    	int pre=start-count;//
    	pre=pre>0?pre:0;//
        int next=start+count;//
        next=next<last?next:last;//
        
    	int page=0;//
    	if(0==total%count)
    		page=total / count;
    	else
    		page=total / count+1;
    
    	
    	request.setAttribute("pre", pre);//
    	request.setAttribute("next", next);//
    	request.setAttribute("last", last);//
    	request.setAttribute("page", page);//
    	request.setAttribute("count", count);//
    	request.setAttribute("orders", orders);//
    	request.getRequestDispatcher("/admin/order/orderList.jsp").forward(request, response);
    
    }
}
