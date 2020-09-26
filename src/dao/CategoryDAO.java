package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import bean.Category;
import bean.Product;
import bean.Property;
import util.DBUtil;

public class CategoryDAO {

	public int getTotal(){
		String sql="select count(*) from category";
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
	
	public void setProducts(Category category){
		List<Product> products=new ProductDAO().list(0, Short.MAX_VALUE, category);
		category.setProducts(products);
	}
	public void setProductsList(Category category){
		List<Product> products=new ProductDAO().list(0, Short.MAX_VALUE, category);
		//category.setProducts(products);
		
		
		List<List<Product>>productLists=new ArrayList<List<Product>>();
		int listSize=products.size();
		int toIndex=8;//�Ӽ��ϳ���
		for(int i=0;i<listSize;i+=8){
			if(i+8>listSize){
				toIndex=listSize-i;
			}
			List<Product> newList=products.subList(i, i+toIndex);
			productLists.add(newList);
		}
		category.setProductLists(productLists);
	}
	public List<Category> list(int start,int count){
		List<Category> categories=new ArrayList<Category>();
		String sql="select * from category order by id limit ?,?";
		try (Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);){
			ps.setInt(1, start);
			ps.setInt(2, count);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				Category category=new Category();
				category.setId(rs.getInt(1));
				category.setName(rs.getString(2));
			
				List<Product> products=new ProductDAO().list(0, Short.MAX_VALUE, category);
				category.setProducts(products);				
				
				List<List<Product>>productLists=new ArrayList<List<Product>>();
				int listSize=products.size();
				int toIndex=8;//�Ӽ��ϳ���
				for(int i=0;i<listSize;i+=8){
					if(i+8>listSize){
						toIndex=listSize-i;
					}
					List<Product> newList=products.subList(i, i+toIndex);
					productLists.add(newList);
				}
				category.setProductLists(productLists);
				
				categories.add(category);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return categories;
	}
	public void add(Category bean){
		String sql="insert into category values(null,?)";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setString(1, bean.getName());
			ps.execute();
			ResultSet rs=ps.getGeneratedKeys();
			while(rs.next()){
				bean.setId(rs.getInt(1));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
    public boolean delete(int id){
    	String sql="delete from category where id="+id;
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();){
			s.execute(sql);
			return true;
		} catch (Exception e) {
			return false;
		}
    }
    public Category get(int id){   	
    	String sql="select * from category where id="+id;
    	Category category=new Category();
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();) {
			ResultSet rs=s.executeQuery(sql);
			while(rs.next()){
				category.setId(rs.getInt(1));
				category.setName(rs.getString(2));
				setProducts(category);//���List<Product>products
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return category;
    }
    public void update(Category bean){
    	String sql="update category set name=? where id=?";
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
