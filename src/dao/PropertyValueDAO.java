package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.PrivateCredentialPermission;

import bean.Category;
import bean.Product;
import bean.Property;
import bean.PropertyValue;
import util.DBUtil;

public class PropertyValueDAO {
    public void deletePropertyValue(int ptid){
    	String sql="delete from propertyvalue where ptid="+ptid;
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();) {
			s.execute(sql);
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
	public void setPropertyValue(Category c,Property property){
    	List<Product>products=new ProductDAO().list(0,Short.MAX_VALUE,c);
    	for(Product product:products){
    		add(product.getId(),property);
    	}
 
	}
	
	public void setPropertyValue(int cid,Product p){
    	List<Property> properties=new PropertyDAO().getProperty(cid);
    	for(Property pr:properties){
    		add(p.getId(),pr);
    	}
 
	}
	public void add(int pid,Property property){
		String sql="insert into propertyvalue values(null,?,?,null)";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setInt(1, pid);
			ps.setInt(2, property.getId());
			ps.execute();
			ResultSet rs=ps.getGeneratedKeys();
			while(rs.next()){
				int id=rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
    public String update(PropertyValue bean){
    	String result="success";
    	String sql="update propertyvalue set value=? where id=?";
    	try(Connection c=DBUtil.getConnection();
    			PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setString(1, bean.getValue());
			ps.setInt(2, bean.getId());
			ps.execute();
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return result;
    }
    public PropertyValue get(int id){
    	String sql="select * from propertyvalue where id="+id;
    	PropertyValue pValue=new PropertyValue();
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();){
    		ResultSet rs=s.executeQuery(sql);
    		while(rs.next()){
    			int pid=rs.getInt(2);
    			int ptid=rs.getInt(3);
    			String value=rs.getString(4);
    			pValue.setId(id);
    			pValue.setProduct(new ProductDAO().get(pid));
    			pValue.setProperty(new PropertyDAO().get(ptid));
    			pValue.setValue(value);
    		}
    	}catch (Exception e) {
			// TODO: handle exception
		}
    	return pValue;
    }
	public List<PropertyValue> list(int pid){
    
    	String sql="select * from propertyvalue where pid=? order by id";
    	List<PropertyValue> pValues=new ArrayList<>();
    	try(Connection c=DBUtil.getConnection();
    			PreparedStatement ps=c.prepareStatement(sql);){
    		ps.setInt(1, pid);
    		ResultSet rs=ps.executeQuery();
    		while(rs.next()){
    			PropertyValue pValue=new PropertyValue();
    			pValue.setId(rs.getInt(1));
    			pValue.setProduct(new ProductDAO().get(pid));
    			pValue.setProperty(new PropertyDAO().get(rs.getInt(3)));
    			pValue.setValue(rs.getString(4));
    			
    			pValues.add(pValue);
    		}
    	}catch (Exception e) {
			// TODO: handle exception
		}
    	
    	return pValues;
    }
}
