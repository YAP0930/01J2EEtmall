package servlet;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


import util.ImageUtil;

public class BaseBackServlet extends HttpServlet{
    @Override
	protected void service(HttpServletRequest request,
    		HttpServletResponse response){ 	
    	    try {
    	    	String method=(String) request.getAttribute("method");
    		    Method m=this.getClass().getMethod(method, 
    		    		HttpServletRequest.class,HttpServletResponse.class);
    		    m.invoke(this, request,response);
			} catch (Exception e) {
				// TODO: handle exception
			}
		
    }
    
    public InputStream upload(HttpServletRequest request,
    		Map<String, String> params){
    	InputStream is=null;
    	try {
    		 DiskFileItemFactory factory = new DiskFileItemFactory();
	         ServletFileUpload upload = new ServletFileUpload(factory);
	         factory.setSizeThreshold(1024 * 10240);
	         
	         List items = upload.parseRequest(request);
	         Iterator iter = items.iterator();
	         while (iter.hasNext()) {
	        	 FileItem item = (FileItem) iter.next();
	        	 if (!item.isFormField()) {
	        		 is = item.getInputStream();
	        		 
	        	 }else{
	        		 String paramName = item.getFieldName();
	                 String paramValue = item.getString();
	                 paramValue = new String(paramValue.getBytes("ISO-8859-1"), "UTF-8");
	               
	             	params.put(paramName, paramValue);
	        	 }
	         }
    	}catch (Exception e) {
				// TODO: handle exception
		}
    	return is;
    }
   
    public void saveUplod(HttpServletRequest request,InputStream is,int id,String context) throws Exception{    	    	
    	//
		 String imageFolder =request.getSession().getServletContext().getRealPath(context);
		
		 String filename = id+".jpg";	
		 File f = new File(imageFolder, filename);		   
		// 
		 if(null!=is && 0!=is.available()){//is.available()得知数据流里有多少个字节可以读取
			 FileOutputStream fos = new FileOutputStream(f); 
			 byte b[] = new byte[1024 * 1024];
		     int length = 0;
		     while (-1 != (length = is.read(b))) {//将这个流中的字节缓冲到数组b中，返回的这个数组中的字节个数
		           fos.write(b, 0, length);//从文件中读取数据，byte[]数组相当于一个搬砖的车。
		     }
		     fos.flush(); 
		     //转化图片格式为jpg
		     BufferedImage img = ImageUtil.change2jpg(f);
		     ImageIO.write(img, "jpg", f); 
		     //
		     if(context.equals("Single_middle")){
		    	 ImageUtil.resizeImage(f, 217, 190, f);
		     }
		     if(context.equals("Single_small")){
		    	 ImageUtil.resizeImage(f, 56, 56, f);
		     }		   
		 } 
    }
   
}
