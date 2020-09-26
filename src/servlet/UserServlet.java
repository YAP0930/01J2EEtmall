package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDAO;


public class UserServlet extends BaseBackServlet{
	public void list(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
    	int start=0;//��ʼҳ��ʼֵ
    	int count=5;//���ɱ䡿
    	
    	try {//��������в�������start������Ҫ����try��Ĵ�����
    		start=Integer.parseInt(request.getParameter("start"));
		} catch (NumberFormatException e) {
			// TODO: handle exception
		}
    	
    	List<User>users=new UserDAO().list(start,count);
    	
    	int total=new UserDAO().getTotal();//����
    	
    	
    	int last=0;//ĩҳ��ʼֵ
    	if(0==total%count)
    		last=total - count;
    	else
    		last=total - total % count;
 
    	int pre=start-count;//��һҳ��ʼֵ
    	pre=pre>0?pre:0;//�߽紦��
    	int next=start+count;//��һҳ��ʼֵ
    	next=next<last?next:last;//�߽紦��
    	
    	int page=0;//��ҳ��
    	if(0==total%count)
    		page=total / count;
    	else
    		page=total / count+1;
    
    	
    	request.setAttribute("pre", pre);//��pre���ݸ�jsp
    	request.setAttribute("next", next);//��next���ݸ�jsp
    	request.setAttribute("last", last);//��last���ݸ�jsp
    	request.setAttribute("page", page);//��page���ݸ�jsp
    	request.setAttribute("count", count);//��count���ݸ�jsp
    	request.setAttribute("users", users);//��categories���ݸ�jsp
    	request.getRequestDispatcher("/admin/user/userList.jsp").forward(request, response);
    
    }
}
