package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bean.Category;
import bean.Property;
import bean.PropertyValue;
import util.DBUtil;

public class PropertyDAO {
	
	public int getTotal(int cid){
		String sql="select count(*) from property where cid="+cid;
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
	
	public List<Property> list(int start,int count,Category category){
		List<Property> properties=new ArrayList<Property>();
		String sql="select * from property where cid=? order by id limit ?,?";
		try (Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);){
			ps.setInt(1, category.getId());
			ps.setInt(2, start);
			ps.setInt(3, count);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				Property property=new Property();
				property.setId(rs.getInt(1));
				property.setName(rs.getString(3));
				property.setCategory(category);
				properties.add(property);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return properties;
	}
	public void add(Property bean){
		String sql="insert into property values(null,?,?)";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setInt(1, bean.getCategory().getId());
			ps.setString(2, bean.getName());
			ps.execute();
			ResultSet rs=ps.getGeneratedKeys();
			while(rs.next()){
				bean.setId(rs.getInt(1));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
    public void delete(int id){
    	String sql="delete from property where id="+id;
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();){
			s.execute(sql);
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
    public void deleteCategory(int cid){
    	String sql="delete from property where cid="+cid;
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();){
			s.execute(sql);
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
    public Property get(int id){   	
    	String sql="select * from property where id="+id;
    	Property property=new Property();
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();) {
			ResultSet rs=s.executeQuery(sql);
			while(rs.next()){
				property.setId(rs.getInt(1));
				property.setCategory(new CategoryDAO().get(rs.getInt(2)));
				property.setName(rs.getString(3));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return property;
    }
    /*
    public Property getProperty(int cid){   	
    	String sql="select * from property where cid="+cid;
    	Property property=new Property();
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();) {
			ResultSet rs=s.executeQuery(sql);
			while(rs.next()){
				property.setId(rs.getInt(1));
				property.setCategory(new CategoryDAO().get(rs.getInt(2)));
				property.setName(rs.getString(3));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return property;
    }
    */
    public List<Property> getProperty(int cid){   	
    	String sql="select * from property where cid="+cid;
    	List<Property> prs=new ArrayList<Property>();
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();) {
			ResultSet rs=s.executeQuery(sql);
			while(rs.next()){
				Property property=new Property();
				property.setId(rs.getInt(1));
				property.setCategory(new CategoryDAO().get(rs.getInt(2)));
				property.setName(rs.getString(3));
				prs.add(property);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return prs;
    }
    public void update(Property bean){
    	String sql="update property set name=? where id=?";
    	try(Connection c=DBUtil.getConnection();
    			PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setString(1, bean.getName());
			ps.setInt(2, bean.getId());
			ps.execute();
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
}
