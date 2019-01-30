<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html>
<html>
	<head>	
	</head>
	<body>
		<c:url var="home" value="/" />
	      <div id="sitemap" role="navigation">
			  <h2>Home</h2>
			  <ul>
			  	<li>
			      <a href="<c:url value="/newuser" />">New User</a>
			    </li>
			  	<li>
			      <a href="<c:url value="/about-matilda" />">About MATILDA</a>
			    </li>
			  	<li>
			      <a href="<c:url value="/about-us" />">About the Team</a>
			    </li>
			    <li>
			      <a href="/sub-section">Problem Domains</a>
			      <div class="inner">
			        <ul>
			          <li>
			            <a href="/combinatorial-problem">Optimization</a>
			            <div class="inner">
			              <ul>
			              	<li>
			                  <a href="<c:url value="/combinatorial-problem/all" />">All Combinatorial Problems</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/combinatorial-problem/tsp" />">Travelling Salesman Problem</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/combinatorial-problem/graphcoloring" />">Graph Coloring Problem</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/combinatorial-problem/knapsack" />">knapsack problem</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/combinatorial-problem/linear-programming" />">Linear Programming</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/combinatorial-problem/mixed-integer" />">Mixed Integer Programming</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/combinatorial-problem/bb-single" />">Black-Box Single Objective</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/combinatorial-problem/bb-multi" />">Black-Box Multi-Objective</a>
			                </li>
			              </ul>
			            </div>
			          </li>
			          <li>
			            <a href="<c:url value="/sub-section/another" />">Learning & Model FItting</a>
			            <div class="inner">
			              <ul>
			                <li>
			                  <a href="<c:url value="/" />">Regression</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/" />">Classification</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/" />">Anomaly Detection</a>
			                </li>
			                <li>
			                  <a href="<c:url value="/" />">Time Series Forecasting</a>
			                </li>
			              </ul>
			            </div>
			          </li>
			        </ul>
			      </div>
			    </li>
<!-- 			    <li> -->
<!-- 			      <a href="contact-us">Library</a> -->
<!-- 			      <div class="inner"> -->
<!-- 			      	<ul> -->
<!-- 			      		<li><a href="">Algorithms</a></li> -->
<!-- 			      		<li><a href="">Instances</a></li> -->
<!-- 			      		<li><a href="">Papers</a></li> -->
<!-- 			      		<li><a href="">Features</a></li> -->
<!-- 			      	</ul> -->
<!-- 			      </div> -->
<!-- 			    </li> -->
			    <li>
			      <a href="/another">Data Analytics</a>
			      <div class="inner"> 
			      	<ul>
			      		<li><a href="<c:url value="/submission-guidelines" />">Submission Guidelines</a></li>
			      		<li><a href="<c:url value="/submit" />">Submit Data</a></li>
			      		<li><a href="<c:url value="/data-analytics" />">Instance Space Analysis</a></li>
			      	</ul>
			      </div>
			    </li>
				<li><a href="<c:url value="/contact-us" />">Queries and Feedback</a></li>
			  </ul>
			</div>
	</body>
</html>	