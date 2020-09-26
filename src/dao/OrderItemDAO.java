package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.PseudoColumnUsage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.Order;
import bean.OrderItem;
import bean.Product;
import bean.User;
import util.DBUtil;

public class OrderItemDAO {
	public int getTotalCart(User user){
		int totalCart=0;
		String sql="select * from orderitem where oid=? and uid=?";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setInt(1, -1);
			ps.setInt(2, user.getId());
			ps.execute();
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				totalCart+=rs.getInt(5);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalCart;
	}
	public int getTotal(User user){
		int total=0;
		String sql="select count(*) from orderitem where oid=? and uid=?";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setInt(1, -1);
			ps.setInt(2, user.getId());
			ps.execute();
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				total+=rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return total;
	}
	public void setFirstProductImage(List<OrderItem> ois){
		for(OrderItem oi:ois){
			   new ProductDAO().setFirstProductImage(oi.getProduct());
		   }
		//填充产品信息
	}
	public void delete(int id) {
		 
	        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
	 
	            String sql = "delete from orderitem where id = " + id;
	 
	            s.execute(sql);
	 
	        } catch (SQLException e) {
	 
	            e.printStackTrace();
	        }
	    }
    public OrderItem get(int id) {
	        OrderItem bean = new OrderItem();
	 
	        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
	 
	            String sql = "select * from orderitem where id = " + id;
	 
	            ResultSet rs = s.executeQuery(sql);
	 
	            if (rs.next()) {
	                int pid = rs.getInt("pid");
	                int oid = rs.getInt("oid");
	                int uid = rs.getInt("uid");
	                int number = rs.getInt("number");
	                Product product = new ProductDAO().get(pid);
	                User user = new UserDAO().get(uid);
	                bean.setProduct(product);
	                bean.setUser(user);
	                bean.setNumber(number);
	                
	                if(-1!=oid){
	                    Order order= new OrderDAO().get(oid);
	                    bean.setOrder(order);               	
	                }
	                
	                bean.setId(id);
	            }
	 
	        } catch (SQLException e) {
	 
	            e.printStackTrace();
	        }
	        return bean;
	    }
	public void add(OrderItem bean){
		 String sql = "insert into orderitem values(null,?,?,?,?)";
	        try (Connection c = DBUtil.getConnection(); 
	        		PreparedStatement ps = c.prepareStatement(sql);) { 
	            ps.setInt(1, bean.getProduct().getId());
	            if(null==bean.getOrder())
	            	ps.setInt(2, -1);
	            else
	            	ps.setInt(2, bean.getOrder().getId());  
	            
	            ps.setInt(3, bean.getUser().getId());
	            ps.setInt(4, bean.getNumber());
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
	public void update(OrderItem bean) {

	        String sql = "update orderitem set pid= ?, oid=?, uid=?,number=?  where id = ?";
	        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {


	            ps.setInt(1, bean.getProduct().getId());
	            if(null==bean.getOrder())
	            	ps.setInt(2, -1);
	            else
	            	ps.setInt(2, bean.getOrder().getId());            	
	            ps.setInt(3, bean.getUser().getId());
	            ps.setInt(4, bean.getNumber());
	            

	            ps.setInt(5, bean.getId());
	            ps.execute();
	 
	        } catch (SQLException e) {
	 
	            e.printStackTrace();
	        }
	 
	    }
	public List<OrderItem> listByUser(int uid) {
		return listByUser(uid, 0, Short.MAX_VALUE);
	}

	public List<OrderItem> listByUser(int uid, int start, int count) {
		List<OrderItem> beans = new ArrayList<OrderItem>();

		String sql = "select * from orderitem where uid = ? and oid=-1 order by id desc limit ?,? ";

		try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {

			ps.setInt(1, uid);
			ps.setInt(2, start);
			ps.setInt(3, count);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				OrderItem bean = new OrderItem();
				int id = rs.getInt(1);

				int pid = rs.getInt("pid");
				int oid = rs.getInt("oid");
				int number = rs.getInt("number");

				Product product = new ProductDAO().get(pid);
				if (-1 != oid) {
					Order order = new OrderDAO().get(oid);
					bean.setOrder(order);
				}

				User user = new UserDAO().get(uid);
				bean.setProduct(product);

				bean.setUser(user);
				bean.setNumber(number);
				bean.setId(id);
				beans.add(bean);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return beans;
	}
	public int getSaleCount(int pid) {
		 int total = 0;
	        try (Connection c = DBUtil.getConnection(); Statement s = c.createStatement();) {
	 
	            String sql = "select sum(number) from orderitem where pid = " + pid;
	 
	            ResultSet rs = s.executeQuery(sql);
	            while (rs.next()) {
	                total = rs.getInt(1);
	            }
	        } catch (SQLException e) {
	 
	            e.printStackTrace();
	        }
	        return total;
	}
	public List<OrderItem> list(int oid){
    	List<OrderItem> oItems=new ArrayList<>();
    	String sql="select * from orderitem  where oid=? order by id";
    	try(Connection c=DBUtil.getConnection();
    			PreparedStatement ps=c.prepareStatement(sql)) {
    		ps.setInt(1, oid);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				OrderItem oItem=new OrderItem();
				oItem.setId(rs.getInt(1));
				Product product=new ProductDAO().get(rs.getInt(2));
				oItem.setProduct(product);
				Order order=new OrderDAO().get(rs.getInt(3));
				oItem.setOrder(order);
				oItem.setUser(new UserDAO().get(rs.getInt(4)));
				oItem.setNumber(rs.getInt(5));
				
			
				oItems.add(oItem);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return oItems;
    }
}
