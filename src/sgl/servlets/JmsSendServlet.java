package sgl.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.jms.*;        
//import javax.naming.*;    


@WebServlet("/JmsSendServlet")
public class JmsSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public JmsSendServlet() {
        super();
        
    }

	
    
    
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
	/*	try {
		//Context ctx =  
		}
		
		
			
		catch (JMSException je)
	    {
	       System.out.println("JMS failed with "+je);
	       Exception le = je.getLinkedException();
	       if (le != null)
	       {
	           System.out.println("linked exception "+le);
	       }
	    }
		
	*/

}
	
}
