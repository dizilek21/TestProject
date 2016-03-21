package sgl.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.jms.*;        
import javax.naming.*;    


@WebServlet("/JmsSendServlet")
public class JmsSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public JmsSendServlet() {
        super();
        
    }

	
    
    
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("In DoGet..");
		QueueConnection queueConnection = null;
		QueueSession queueSession = null;
		QueueSender queueSender = null;
		String message = "";
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("before message..");
		message = request.getParameter(message);
		System.out.println("after message..");
		System.out.println("message is: " + message);	
		try {
				Context ctx = new InitialContext();  
				QueueConnectionFactory qcf = (QueueConnectionFactory) ctx.lookup("jms/QCF1");
				Queue queue = (Queue) ctx.lookup("jms/Q1");

				queueConnection = qcf.createQueueConnection();
				queueConnection.start();

				queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
				queueSender = queueSession.createSender(queue);
				TextMessage textMessage = queueSession.createTextMessage(message);
				queueSender.send(textMessage);
			
		}	catch (Throwable t) {
					t.printStackTrace();
					response.getWriter().println("Error occurred while trying to send message : " + t.toString() + "\n");
			
			/*catch (JMSException je){
					    
					       System.out.println("JMS failed with "+je);
					       Exception le = je.getLinkedException();
					       if (le != null)
					       {
					           System.out.println("linked exception "+le);
					       }*/
		} finally {
					try {
					if (queueSender != null) {
						queueSender.close();
					}
					if (queueSession != null) {
						queueSession.close();
					}
					if (queueConnection != null) {
						queueConnection.close();
					}
					} catch (Throwable t) {
					}
				}
	}

	
	
	
	
	
}
			
			

	    
		
	



