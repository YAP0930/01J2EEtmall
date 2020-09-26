package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bean.Order;
import bean.OrderItem;
import bean.Product;
import bean.User;
import util.DBUtil;
import util.DateUtil;

public class OrderDAO {
	public static final String waitPay = "waitPay";
	public static final String waitDelivery = "waitDelivery";
	public static final String waitConfirm = "waitConfirm";
	public static final String waitReview = "waitReview";
	public static final String finish = "finish";
	public static final String delete = "delete";
    
	/*给用户的订单填充订单的购买数量*/
	public void setTotalNumber(List<Order>orders,User user){
		for(Order r:orders){
			setTotalNumber(r,user);
		}
	}
	public void setTotalNumber(Order order,User user){
		String sql="select * from orderitem where oid=? and uid=?";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setInt(1, order.getId());
			ps.setInt(2, user.getId());
			ps.execute();
			ResultSet rs=ps.executeQuery();
			int num=0;
 			while(rs.next()){
 				num=num+rs.getInt("number");
 			}
 			order.setTotalNumber(num);						
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void setOrderItems(List<Order> os){
		for(Order o:os){
			   new OrderDAO().setOrderItems(o);
		   }
	}
	public void setOrderItems(Order o){
		List<OrderItem> ois=new OrderItemDAO().list(o.getId());
		float total = 0;
		for (OrderItem oi : ois) {
			 total+=oi.getNumber()*oi.getProduct().getPromotePrice();
		}
		o.setTotal(total);
		o.setOrderItems(ois);//填充订单项
		new OrderItemDAO().setFirstProductImage(ois);//给订单项填充产品信息
	}
	
	public List<Order> list(int uid, String excludedStatus) {
		return list(uid, excludedStatus, 0, Short.MAX_VALUE);
	}

	public List<Order> list(int uid, String excludedStatus, int start, int count) {
		List<Order> beans = new ArrayList<Order>();

		String sql = "select * from order_ where uid = ? and status != ? order by id desc limit ?,? ";

		try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {

			ps.setInt(1, uid);
			ps.setString(2, excludedStatus);
			ps.setInt(3, start);
			ps.setInt(4, count);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Order bean = new Order();
				String orderCode = rs.getString("orderCode");
				String address = rs.getString("address");
				String post = rs.getString("post");
				String receiver = rs.getString("receiver");
				String mobile = rs.getString("mobile");
				String userMessage = rs.getString("userMessage");
				String status = rs.getString("status");
				Date createDate = DateUtil.t2d(rs.getTimestamp("createDate"));
				Date payDate = DateUtil.t2d(rs.getTimestamp("payDate"));
				Date deliveryDate = DateUtil.t2d(rs.getTimestamp("deliveryDate"));
				Date confirmDate = DateUtil.t2d(rs.getTimestamp("confirmDate"));

				int id = rs.getInt("id");
				bean.setId(id);
				bean.setOrderCode(orderCode);
				bean.setAddress(address);
				bean.setPost(post);
				bean.setReceiver(receiver);
				bean.setMobile(mobile);
				bean.setUserMessage(userMessage);
				bean.setCreateDate(createDate);
				bean.setPayDate(payDate);
				bean.setDelivertDate(deliveryDate);
				bean.setConfirmDate(confirmDate);
				User user = new UserDAO().get(uid);
				bean.setStatus(status);
				bean.setUser(user);
				beans.add(bean);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return beans;
	}

	public void add(Order bean) {

		String sql = "insert into order_ values(null,?,?,?,?,?,?,?,?,?,?,?,?)";
		try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {

			ps.setString(1, bean.getOrderCode());
			ps.setString(2, bean.getAddress());
			ps.setString(3, bean.getPost());
			ps.setString(4, bean.getReceiver());
			ps.setString(5, bean.getMobile());
			ps.setString(6, bean.getUserMessage());

			ps.setTimestamp(7, DateUtil.d2t(bean.getCreateDate()));
			ps.setTimestamp(8, DateUtil.d2t(bean.getPayDate()));
			ps.setTimestamp(9, DateUtil.d2t(bean.getDelivertDate()));
			ps.setTimestamp(10, DateUtil.d2t(bean.getConfirmDate()));
			ps.setInt(11, bean.getUser().getId());
			ps.setString(12, bean.getStatus());

			ps.execute();

			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				int id = rs.getInt(1);
				bean.setId(id);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}

	public void update(Order bean) {
		String sql = "update order_ set status=?, payDate=?,deliveryDate=? ,confirmDate=? where id=?";
		try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
			ps.setString(1, bean.getStatus());			
			ps.setTimestamp(2, DateUtil.d2t(bean.getPayDate()));
			ps.setTimestamp(3, DateUtil.d2t(bean.getDelivertDate()));
			ps.setTimestamp(4, DateUtil.d2t(bean.getConfirmDate()));
			ps.setInt(5, bean.getId());
			ps.execute();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public Order get(int id) {
		String sql = "select * from order_  where id=" + id;
		Order order = new Order();
		try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
				order.setId(rs.getInt(1));
				order.setOrderCode(rs.getString(2));
				order.setAddress(rs.getString(3));
				order.setPost(rs.getString(4));
				order.setReceiver(rs.getString(5));
				order.setMobile(rs.getString(6));
				order.setUserMessage(rs.getString(7));
				order.setCreateDate(rs.getTimestamp(8));
				order.setPayDate(DateUtil.t2d(rs.getTimestamp(9)));
				order.setDelivertDate(DateUtil.t2d(rs.getTimestamp(10)));
				order.setConfirmDate(DateUtil.t2d(rs.getTimestamp(11)));
				order.setUser(new UserDAO().get(rs.getInt(12)));
				order.setStatus(rs.getString(13));

				List<OrderItem> oItems = order.getOrderItems();
				for (OrderItem oItem : oItems) {
					Product product = oItem.getProduct();
					order.setTotalNumber(order.getTotalNumber() + oItem.getNumber());
					float total = oItem.getNumber() * product.getPromotePrice();
					order.setTotal(order.getTotal() + total);
				}

			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return order;
	}

	public int getTotal() {
		String sql = "select count(*) from order_";
		int total = 0;
		try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return total;
	}

	public List<Order> list(int start, int count) {
		String sql = "select * from order_  order by id limit ?,?";
		List<Order> orders = new ArrayList<>();
		try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
			ps.setInt(1, start);
			ps.setInt(2, count);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt(1));
				order.setOrderCode(rs.getString(2));
				order.setAddress(rs.getString(3));
				order.setPost(rs.getString(4));
				order.setReceiver(rs.getString(5));
				order.setMobile(rs.getString(6));
				order.setUserMessage(rs.getString(7));
				order.setCreateDate(rs.getTimestamp(8));
				order.setPayDate(DateUtil.t2d(rs.getTimestamp(9)));
				order.setDelivertDate(DateUtil.t2d(rs.getTimestamp(10)));
				order.setConfirmDate(DateUtil.t2d(rs.getTimestamp(11)));
				order.setUser(new UserDAO().get(rs.getInt(12)));
				order.setStatus(rs.getString(13));
				order.setOrderItems(new OrderItemDAO().list(rs.getInt(1)));
				List<OrderItem> oItems = new OrderItemDAO().list(rs.getInt(1));
				for (OrderItem oItem : oItems) {
					Product product = oItem.getProduct();
					order.setTotalNumber(order.getTotalNumber() + oItem.getNumber());
					System.out.println("product.getPromotePrice()" + product.getPromotePrice());
					float total = oItem.getNumber() * product.getPromotePrice();
					order.setTotal(order.getTotal() + total);
					System.out.println("order.getTotalNumber()" + order.getTotalNumber());
					System.out.println("order.getTotal()" + order.getTotal());
					System.out.println("total" + total);
				}

				orders.add(order);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return orders;
	}
}
