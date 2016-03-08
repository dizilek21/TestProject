<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<HTML>
<%@ page import="javax.jms.JMSException,javax.jms.Queue,javax.jms.QueueConnection,javax.jms.QueueConnectionFactory,javax.jms.QueueReceiver,javax.jms.QueueSession," %>
<%@ page import="javax.jms.Session,javax.jms.Message,javax.jms.TextMessage,javax.naming.Context,javax.naming.InitialContext,javax.naming.NamingException" %>
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
	
<TITLE>Sample JMS Application - Get Message</TITLE>
</HEAD>
<BODY>
<%!
	String status = "";
	int i=0;

	public String getMessage() {
		String textMessage = "";
		QueueConnection queueConnection = null;
		QueueSession queueSession = null;
		QueueReceiver queueReceiver = null;
		try {

			Context context = new InitialContext();
			QueueConnectionFactory qcf = (QueueConnectionFactory) context.lookup("jms/OutgoingQCF");
			Queue queue = (Queue) context.lookup("jms/OutgoingQueue");

			queueConnection = qcf.createQueueConnection();
			queueConnection.start();

			queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			queueReceiver = queueSession.createReceiver(queue);
			Message message = queueReceiver.receiveNoWait();
			if (message == null) {
				status = "No message available from OutgoingQueue";
			} else if (message instanceof TextMessage) {
				i++;
				textMessage = ((TextMessage)message).getText();
				status = "Message " + i + " retrieved from OutgoingQueue";
			} else {
				status = "Message retrieved but not text message.";
			}		

		} catch (Throwable t) {
			t.printStackTrace();
			status =
				"Error occurred while retrieving message: " + t.toString() + "\n";
		} finally {
			try {
			if (queueReceiver != null) {
				queueReceiver.close();
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

		return textMessage;
	}
%>

<%
	String submitParam = request.getParameter("submit");
	String output = "";
	if (submitParam != null) {
		output = getMessage();
	} else {
		status = null;
	}

%>

<H1>Get Message</H1>
<FORM action="GetMessage.jsp" method="post">
	<table border = "0" cellpadding="1" cellspacing="10">	
		<tr>
			<td colspan="2">
				Press the "Get Message" button to retrieve a message from the JMS resources:<BR>
				Queue Connection Factory (jms/OutgoingQCF) and Queue (jms/OutgoingQueue)
			</td>
		</tr>
		<tr>
			<td>
				Message Text:
			</td>
			<td>
				<textarea name="messageText" rows="20" cols="80"><%= output == null ? "" : output %></textarea>
			</td>
		</tr>		
		<tr>
			<td>
				<input type="submit" value="Get Message" name="submit"/>
			</td>
			<td>				
				&nbsp;<%= status == null ? "" : status %>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<A href="./PutMessage.jsp">Put message onto IncomingQueue</A>
			</td>
		</tr>		
	</table> 
</FORM>



</BODY>
</HTML>
