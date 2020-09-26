package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.User;
import util.DBUtil;

public class UserDAO {
	public User get(String name,String password){
		String sql="select * from user where name=? and password=?";
		User user=new User();
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);){
			ps.setString(1, name);
			ps.setString(2, password);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				user.setId(rs.getInt(1));
				user.setName(rs.getString(2));
				user.setPassword(rs.getString(3));
			}else{
				user=null;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return user;
	}
	public void add(User user){
		String sql="insert into user values(null,?,?)";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setString(1, user.getName());
			ps.setString(2, user.getPassword());
			ps.execute();
			ResultSet rs=ps.getGeneratedKeys();
			if(rs.next()){
				user.setId(rs.getInt(1));
				System.out.println("��ӳɹ�");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public boolean isExist(String name){
		String sql="select * from user where name=?";
		boolean result=false;
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);){
			ps.setString(1, name);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				result=true;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}
	public User get(int id){
		String sql="select * from user where id="+id;
		User user=new User();
		try(Connection c=DBUtil.getConnection();
				Statement s=c.createStatement();){
			ResultSet rs=s.executeQuery(sql);
			while(rs.next()){
				user.setId(id);
				user.setName(rs.getString(2));
				user.setPassword(rs.getString(3));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return user;
	}
	public int getTotal(){
		String sql="select count(*) from user";
		int total=0;
		try(Connection c=DBUtil.getConnection();
				Statement s=c.createStatement();) {
			ResultSet rs=s.executeQuery(sql);
			while(rs.next()){
				total=rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return total;
	}
	public List<User> list(int start,int count){
		List<User> users=new ArrayList<>();
		String sql="select * from user order by id limit ?,?";
		try (Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);){
			ps.setInt(1, start);
			ps.setInt(2, count);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				User user=new User();
				user.setId(rs.getInt(1));
				user.setName(rs.getString(2));
				user.setPassword(rs.getString(3));
				users.add(user);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return users;
	}
}
