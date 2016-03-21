package sgl.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Servlet1
 */
@WebServlet("/Servlet1")
public  class Servlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		response.getWriter().println("<BR/BR>");
		response.getWriter().println("hello");
		
		ArrayList<String> parameterNames = new ArrayList<String>();
		Enumeration param = request.getParameterNames();
		while (param.hasMoreElements()) {
	        String parameterName = (String) param.nextElement();
	        response.getWriter().println("parameterName: " + parameterName);
	        response.getWriter().println("<BR/BR>");
	        parameterNames.add(parameterName);
	    }
		
	}
    
//@Override    
public void init(){
	System.out.println("In init method.");
	
}
}


/*@Override
public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException{
	System.out.println("In service method.");
	
}
*/    


