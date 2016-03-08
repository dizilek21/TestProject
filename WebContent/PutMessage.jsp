<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<HTML>
<%@ page import="javax.jms.JMSException,javax.jms.Queue,javax.jms.QueueConnection,javax.jms.QueueConnectionFactory,javax.jms.QueueSender,javax.jms.QueueSession," %>
<%@ page import="javax.jms.Session,javax.jms.TextMessage,javax.naming.Context,javax.naming.InitialContext,javax.naming.NamingException" %>
<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="theme/Master.css" rel="stylesheet"
	type="text/css">
	
<!--  
Article : How to test WebSphere JMS Applications when disconnected from WebSphere MQ
Author : Annette C. Green 
Company: IBM Corporation
-->	
	
<TITLE>Sample JMS Application - Put Message</TITLE>
</HEAD>
<BODY>
<%!
	int i=0;
	
	public String putMessage(String message) {
		String status = null;
		QueueConnection queueConnection = null;
		QueueSession queueSession = null;
		QueueSender queueSender = null;
		try {

			Context context = new InitialContext();
			QueueConnectionFactory qcf = (QueueConnectionFactory) context.lookup("jms/IncomingQCF");
			Queue queue = (Queue) context.lookup("jms/IncomingQueue");

			queueConnection = qcf.createQueueConnection();
			queueConnection.start();

			queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			queueSender = queueSession.createSender(queue);
			TextMessage textMessage = queueSession.createTextMessage(message);
			queueSender.send(textMessage);
			i++;
			
			status = "Message " + i + " was sent successfully.";

		} catch (Throwable t) {
			t.printStackTrace();
			status =  "Error occurred while trying to send message : " + t.toString() + "\n";
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

		return status;
	}
%>

<%

String messageText = request.getParameter("messageText");
String output = null;

if (messageText != null) {
	output = putMessage(messageText);
}

%>

<H1>Put Message</H1>
<FORM action="PutMessage.jsp" method="post">
	<table border = "0" cellpadding="1" cellspacing="10">
		<tr>
			<td colspan="2">
			Press the "Put Message" button to send a message to JMS resources:<BR>
			Queue Connection Factory (jms/IncomingQCF) and Queue (jms/IncomingQueue) 
			</td>
		</tr>
		<tr>
			<td>
				Message Text:
			</td>
			<td>
				<textarea name="messageText" rows="20" cols="60"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="Put Message">				
			</td>
			<td >
				
				&nbsp;<%= output == null ? "" : output %>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<A href="./GetMessage.jsp">Retrieve message from OutgoingQueue</A>
			</td>
		</tr>		
	</table> 
</FORM>

</BODY>
</HTML>
