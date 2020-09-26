package Comparator;

import java.util.Comparator;

import bean.Product;
/*
 * 销量比较器
 * 把 销量高的放前面
 */
public class ProductSaleCountComparator implements Comparator<Product>{

	@Override
	public int compare(Product p1, Product p2) {
		// TODO Auto-generated method stub
		return p2.getSaleCount()-p1.getSaleCount();
	}

}
