package bean;

import java.util.List;

public class Category {
    private String name;
    private int id;
    private List<Product> products;
    private List<List<Product>>productLists;
 
	public String getName() {  
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	public List<List<Product>> getProductLists() {
		return productLists;
	}
	public void setProductLists(List<List<Product>> productLists) {
		this.productLists = productLists;
	}
	
    
}
