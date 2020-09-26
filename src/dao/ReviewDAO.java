package dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bean.Product;
import bean.Review;
import bean.User;
import util.DBUtil;
import util.DateUtil;

public class ReviewDAO {
	 public void add(Review bean) {



	        String sql = "insert into review values(null,?,?,?,?)";
	        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
	 
	            ps.setString(1, bean.getContent());
	            ps.setInt(2, bean.getUser().getId());
	            ps.setInt(3, bean.getProduct().getId());
	            ps.setTimestamp(4, DateUtil.d2t(bean.getCreateDate()));
	            
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
	
	public List<Review> list(int pid) {
		return list(pid, 0, Short.MAX_VALUE);
	}

	public List<Review> list(int pid, int start, int count) {
		List<Review> beans = new ArrayList<Review>();

		String sql = "select * from review where pid = ? order by id desc limit ?,? ";

		try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {

			ps.setInt(1, pid);
			ps.setInt(2, start);
			ps.setInt(3, count);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Review bean = new Review();
				int id = rs.getInt(1);

				int uid = rs.getInt("uid");
				Date createDate = DateUtil.t2d(rs.getTimestamp("createDate"));

				String content = rs.getString("content");

				Product product = new ProductDAO().get(pid);
				User user = new UserDAO().get(uid);

				bean.setContent(content);
				bean.setCreateDate(createDate);
				bean.setId(id);
				bean.setProduct(product);
				bean.setUser(user);
				beans.add(bean);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return beans;
	}

	public int getCount(int pid) {
		String sql = "select count(*) from review where pid = ? ";

		try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {

			ps.setInt(1, pid);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return 0;
	}
}
