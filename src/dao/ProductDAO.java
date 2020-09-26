package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import bean.Category;
import bean.Product;
import bean.ProductImage;
import util.DBUtil;
import util.DateUtil;

public class ProductDAO {
	public void setSaleAndReviewNumber(List<Product> products) {
        for (Product p : products) {
            setSaleAndReviewNumber(p);
        }
    }
	 public List<Product> search(String keyword, int start, int count) {
         List<Product> beans = new ArrayList<Product>();
          
         if(null==keyword||0==keyword.trim().length())
             return beans;
            String sql = "select * from product where name like ? limit ?,? ";
      
            try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql);) {
                ps.setString(1, "%"+keyword.trim()+"%");
                ps.setInt(2, start);
                ps.setInt(3, count);
      
                ResultSet rs = ps.executeQuery();
      
                while (rs.next()) {
                    Product bean = new Product();
                    int id = rs.getInt(1);
                    int cid = rs.getInt("cid");
                    String name = rs.getString("name");
                    String subTitle = rs.getString("subTitle");
                    float orignalPrice = rs.getFloat("orignalPrice");
                    float promotePrice = rs.getFloat("promotePrice");
                    int stock = rs.getInt("stock");
                    Date createDate = DateUtil.t2d( rs.getTimestamp("createDate"));
 
                    bean.setName(name);
                    bean.setSubTitle(subTitle);
                    bean.setOrignalPrice(orignalPrice);
                    bean.setPromotePrice(promotePrice);
                    bean.setStock(stock);
                    bean.setCreateDate(createDate);
                    bean.setId(id);
 
                    Category category = new CategoryDAO().get(cid);
                    bean.setCategory(category);
                    setFirstProductImage(bean);                
                    beans.add(bean);
                }
            } catch (SQLException e) {
      
                e.printStackTrace();
            }
            return beans;
    }
	public void setSaleAndReviewNumber(Product p) {
		int reviewCount = new ReviewDAO().getCount(p.getId());
		p.setReviewCount(reviewCount);
		
		int saleCount = new OrderItemDAO().getSaleCount(p.getId());
        p.setSaleCount(saleCount);          
	}
	
	public void setFirstProductImage(Product p) {
        List<ProductImage> pis= new ProductImageDAO().list(p.getId(),"type_single");
        if(!pis.isEmpty()){
        	p.setFirstProductImage(pis.get(0));
        }
        p.setProductSingleImages(pis);
    }
	public void setProductDetailImages(Product p) {
		List<ProductImage> productDetailImages=new ProductImageDAO().list(p.getId(),"type_detail");			    			    			  
	    p.setProductDetailImages(productDetailImages);
       
    }
	public int getTotal(int cid){
		String sql="select count(*) from product where cid="+cid;
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
	
	public List<Product> list(int start,int count,Category category){
		List<Product> products=new ArrayList<>();
		String sql="select * from product where cid=? order by id limit ?,?";
		try (Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);){
			ps.setInt(1, category.getId());
			ps.setInt(2, start);
			ps.setInt(3, count);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				Product product=new Product();
				product.setId(rs.getInt(1));
				product.setName(rs.getString(2));
				product.setSubTitle(rs.getString(3));
				product.setOrignalPrice(rs.getFloat(4));
				product.setPromotePrice(rs.getFloat(5));
				product.setStock(rs.getInt(6));
				product.setCategory(category);
				//�漰����ʱ���Ҫ����
				Date createDate = DateUtil.t2d( rs.getTimestamp("createDate"));
				
				product.setCreateDate(createDate);
				setFirstProductImage(product);
				products.add(product);
				//setFirstProductImage(product);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return products;
	}
	public void add(Product bean){
		String sql="insert into product values(null,?,?,?,?,?,?,?)";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setString(1, bean.getName());
			ps.setString(2, bean.getSubTitle());
			ps.setFloat(3, bean.getOrignalPrice());
			ps.setFloat(4, bean.getPromotePrice());
			ps.setInt(5, bean.getStock());
			ps.setInt(6, bean.getCategory().getId());
			ps.setTimestamp(7, DateUtil.d2t(bean.getCreateDate()));//ע�⡣
			
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
    	String sql="delete from product where id="+id;
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();){
			s.execute(sql);
			return true;
		} catch (Exception e) {
			return false;
		}
    }
    public void deleteCategory(int cid){
    	String sql="delete from product where cid="+cid;
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();){
			s.execute(sql);
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
    public Product get(int id){   	
        
    	String sql="select * from product where id="+id;
    	Product product=new Product();
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();) {
			ResultSet rs=s.executeQuery(sql);
			while(rs.next()){	
				
				product.setId(rs.getInt(1));				
				product.setName(rs.getString(2));				
				product.setSubTitle(rs.getString(3));				
				product.setOrignalPrice(rs.getFloat(4));
				product.setPromotePrice(rs.getFloat(5));
				product.setStock(rs.getInt(6));
                
				Date createDate = DateUtil.t2d( rs.getTimestamp(8));
				product.setCreateDate(createDate);			
				
				//setFirstProductImage(product);				
				//setSaleAndReviewNumber(product);
				
				//<ProductImage> productDetailImages=new ProductImageDAO().list(id,"type_detail");			    			    			  
			   // product.setProductDetailImages(productDetailImages);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return product;
    }
    public void update(Product bean){
    	String sql="update product set name=?, subTitle=?, orignalPrice=?,promotePrice=?,"
    			+ "stock=? where id=?";
    	try(Connection c=DBUtil.getConnection();
    			PreparedStatement ps=c.prepareStatement(sql);) {
    		ps.setString(1, bean.getName());
            ps.setString(2, bean.getSubTitle());
            ps.setFloat(3, bean.getOrignalPrice());
            ps.setFloat(4, bean.getPromotePrice());
            ps.setInt(5, bean.getStock());
            ps.setInt(6, bean.getId());
			ps.execute();
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
}
