package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import bean.ProductImage;
import util.DBUtil;

public class ProductImageDAO {
	public void delete(int id){
    	String sql="delete from productimage where id="+id;
    	try(Connection c=DBUtil.getConnection();
    			Statement s=c.createStatement();){
			s.execute(sql);
		} catch (Exception e) {
			// TODO: handle exception
		}
    }
	public void add(ProductImage bean){
		String sql="insert into productimage values(null,?,?)";
		try(Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);) {
			ps.setInt(1, bean.getProduct().getId());
			ps.setString(2, bean.getType());
			ps.execute();
			ResultSet rs=ps.getGeneratedKeys();
			while(rs.next()){
				bean.setId(rs.getInt(1));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public int getTotal(int pid){
		String sql="select count(*) from productimage wehere pid="+pid;
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
	public List<ProductImage> list(int pid,String type){
		
		List<ProductImage> productImages=new ArrayList<>();
		String sql="select * from productimage where pid=? and type=? order by id";
		try (Connection c=DBUtil.getConnection();
				PreparedStatement ps=c.prepareStatement(sql);){
			ps.setInt(1, pid);
			ps.setString(2, type);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				ProductImage productImage=new ProductImage();
				productImage.setId(rs.getInt(1));
				productImage.setProduct(new ProductDAO().get(pid));
				productImage.setType(type);
                productImages.add(productImage);
        
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return productImages;
	}
}
