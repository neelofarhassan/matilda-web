<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html>
<html>
	<head>
		<style>
			.column {
				  float: left;
				  width: 33.33%;
				  padding: 5px;
				}
				
				/* Clear floats after image containers */
				.row::after {
				  content: "";
				  clear: both;
				  display: table;
				}
				.matilda_footer { 
				padding-top: 0rem !important; 
				padding-bottom: 0rem !important 
				}
				.matilda_quiklinks{
				padding-top: 0rem !important; 
				padding-bottom: 0rem !important 
				}
		</style>
	</head>
	<body>
	    <footer class="cta" style="padding-top: 0rem !important; padding-bottom: 0rem !important ">
	      <c:url var="home" value="/" />
	      <ul class="quicklinks" style="padding-top: 0rem !important; padding-bottom: 0rem !important ">
	        <li style="color:white;">Usage rights: Data images are licensed under a Creative Commons Attribution-NonCommercial (CC BY NC) 3.0 Australia licence. Copyright: © University of Melbourne 2018.</li>
	        <li><a href="/terms-of-use"><svg class='icon' role='img'><use href="#icon-check-circle"/></svg>Terms of use</a></li>
	        <li><a href="mailto:"><svg class="icon" role="img"><use href="#icon-mail"/></svg>Contact us</a></li>
	      </ul>
	    </footer>
    </body>
</html>    