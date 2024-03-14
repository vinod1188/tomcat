<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Contact lenses - input page</title>
<%@ page import="weka.core.*" %>
<%@ page import=" weka.classifiers.trees.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
</head>
<body>
<%
	
	//1. load arff training set from arff file
	String fileName=getServletContext().getRealPath("contact-lenses.arff"); 
	File f=new File(fileName);
	InputStream in = new FileInputStream(f);
	InputStreamReader isreader=new InputStreamReader(in);
		
	Instances data = new Instances(isreader);
	isreader.close();
	// setting class attribute
	data.setClassIndex(data.numAttributes() - 1);

	

 	%>
 	<h1> Enter attribute values to find the best lenses type:</h1>
 	<form method="post"  action="ClassifyServlet">
 	<%
 	//3. loop through attributes and put options in the form
 	
 	Enumeration attributes=data.enumerateAttributes();
 	
 	while(attributes.hasMoreElements())
	{
		Attribute currAttribute=(Attribute)attributes.nextElement();
 	%>
 	<%= currAttribute.name() %><select name="<%= currAttribute.name() %>" >
 	
 	<option value="-1"></option>
 	
 	<% Enumeration attrVals= currAttribute.enumerateValues();
 		int i=0;
 		while(attrVals.hasMoreElements())
		{
			String attrVal=(String)attrVals.nextElement();
 		%>
 		<option value="<%= i %>"><%= attrVal %></option>
 		
 		<%
 			i++;
 		} %>
 	</select> <br>
 	<%} %>
 	
 	<%= data.classAttribute().name() %>
 	<input type="submit" value = "CLASIFY">
 	
 	</form> 
</body>
</html>