<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Classification output J48</title>
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
	
	
	//2. ****************************
 	//build decision tree classifier
 	String[] options = new String[1];
 	options[0] = "-U";            // unpruned tree
 	J48 tree = new J48();         // new instance of tree
 	tree.setOptions(options);     // set the options
 	tree.buildClassifier(data);   // build classifier
	
 	int numAttributes=data.numAttributes();
 	double [] targetvals=new double[numAttributes];
 	//3. Obtain values of selected attributes 
 	Enumeration attributes=data.enumerateAttributes();
 	
 	boolean invalidSelection=false;
 	
 	int currAttrIndex=0;
 	while(attributes.hasMoreElements())
	{
		Attribute currAttribute=(Attribute)attributes.nextElement();
		String selValue=request.getParameter(currAttribute.name());
		if(selValue.equals("-1"))
			invalidSelection=true;
		else
			targetvals[currAttrIndex]=Double.parseDouble(selValue);
		
		
 	%>
 	<%= selValue %> 	
 	<% 
 		currAttrIndex++;
 	} 
 	
 	Instance target=new Instance(1,targetvals);
 	data.add(target);
 	if(invalidSelection)
 	{
 		
 	}
 	else
 	{ 		
 		double clsLabel = tree.classifyInstance(data.lastInstance());
 		data.lastInstance().setClassValue(clsLabel);
 	}
 	%>
 	
<%= data.lastInstance() %> 

</body>
</html>