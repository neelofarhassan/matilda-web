<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <meta content="IE=edge" http-equiv="X-UA-Compatible" />
  <title> Matilda </title>
  <link rel="stylesheet" href="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.css">
  <link rel="stylesheet" href="/resources/css/matilda.css">
  <script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script>
 <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script>
jQuery(document).ready(function(){
// run on DOM ready
// grab target from URL hash (i.e. www.example.com/page-a.html#target-name)
 
//var target = window.location.hash;
var target = "<%= request.getAttribute("anchor")%>"
if(!target.length){
	target = '#combinatorial_problem';
}
 // only try to scroll to offset if target has been set in location hash
 var offset = 20;
if ( target != '' ){
    var $target = jQuery(target); 
    jQuery('html, body').stop().animate({
    'scrollTop': $target.offset().top - offset}, // set offset value here i.e. 50
    900, 
    'swing',function () {
    window.location.hash = target ;
    });
}
});
</script>

<style>
img{
     
    float: left;
    vertical-align: top;
    margin: 7px 7px 7px 7px; 
}

</style>

</head>
<body>
	
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	   <%@include file="authheader.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		
		<h1 id="all">Combinatorial Optimization Problems</h1>
      	<div id="tsp">
	       <h2 style="text-align: center">Travelling Salesman Problem</h2>
	    	<p><img src="${home}resources/images/tsp.jpeg" alt="TSP" align="right" width="200" height="200" border="0" style="Margin:0 0 20px 20px;">
	        The traveling salesman problem (TSP) is an algorithmic problem tasked with finding the 
	        shortest route between a set of points and locations that must be visited. In the problem 
	        statement, the points are the cities a salesperson might visit. The salesman‘s goal is to 
	        keep both the travel costs and the distance traveled as low as possible.</p> 
	        <p>Focused on 
	        optimization, TSP is often used in computer science to find the most efficient route 
	        for data to travel between various nodes. Applications include identifying network or 
	        hardware optimization methods.</p>
	        <h2>Downloads</h2>
	        <ol><li><a href="http://users.monash.edu.au/~ksmiles/matilda/graphs.zip">Evolved graphs </a> from Smith-Miles, K. A. and Bowly, S., "Generating New Test Instances by Evolving in Instance Space", Computers & Operations Research, vol. 63, pp. 102-113, 2015.</li>
				<li><a href="http://users.monash.edu.au/~ksmiles/matilda/tsp.zip">Evolved TSP </a> instances from Smith-Miles, K. and van Hemert, J. Discovering the suitability of optimisation algorithms by learning from evolved instances, Ann Math Artif Intell, pp. 61-87, 2011.</li>
			</ol>	
		</div>
		
		<div id="graphcoloring">
	       <h2 style="text-align: center">Graph Coloring Problem</h2>
	    	<p><img src="${home}resources/images/graphcoloring.png" alt="graph coloring" align="right" width="200" height="200" border="0" style="Margin:0 0 20px 20px;">
	        In graph theory, graph coloring is a special case of graph labeling; it is an assignment 
	        of labels traditionally called "colors" to elements of a graph subject to certain 
	        constraints. In its simplest form, it is a way of coloring the vertices of a graph 
	        such that no two adjacent vertices share the same color; this is called a vertex 
	        coloring. Similarly, an edge coloring assigns a color to each edge so that no two 
	        adjacent edges share the same color, and a face coloring of a planar graph assigns 
	        a color to each face or region so that no two faces that share a boundary have 
	        the same color.</p>

			<p>Vertex coloring is the starting point of the subject, and other coloring problems 
			can be transformed into a vertex version. For example, an edge coloring of a graph 
			is just a vertex coloring of its line graph, and a face coloring of a plane graph 
			is just a vertex coloring of its dual. However, non-vertex coloring problems are 
			often stated and studied as is. That is partly for perspective, and partly because 
			some problems are best studied in non-vertex form, as for instance is edge coloring.</p>
	        <h2>Downloads</h2>
	        <ol><li><a href="http://users.monash.edu.au/~ksmiles/matilda/graphs.zip">Evolved graphs </a> from Smith-Miles, K. A. and Bowly, S., "Generating New Test Instances by Evolving in Instance Space", Computers & Operations Research, vol. 63, pp. 102-113, 2015.</li>
				<li><a href="http://users.monash.edu.au/~ksmiles/matilda/tsp.zip">Evolved TSP </a> instances from Smith-Miles, K. and van Hemert, J. Discovering the suitability of optimisation algorithms by learning from evolved instances, Ann Math Artif Intell, pp. 61-87, 2011.</li>
			</ol>	
		</div>
		
		<div id="knapsack">
	       <h2 style="text-align: center">Knapsack Problem</h2>
	    	<p><img src="${home}resources/images/knapsack.png" alt="graph coloring" align="right" width="200" height="200" border="0" style="Margin:0 0 20px 20px;">
	        The knapsack problem or rucksack problem is a problem in combinatorial optimization: 
	        Given a set of items, each with a weight and a value, determine the number of each item 
	        to include in a collection so that the total weight is less than or equal to a given 
	        limit and the total value is as large as possible. It derives its name from the problem 
	        faced by someone who is constrained by a fixed-size knapsack and must fill it with the 
	        most valuable items.</p>

			<p>The problem often arises in resource allocation where there are financial constraints 
			and is studied in fields such as combinatorics, computer science, complexity theory, 
			cryptography, applied mathematics, and daily fantasy sports.</p>

			<p>The knapsack problem has been studied for more than a century, with early works dating 
			as far back as 1897.[1] The name "knapsack problem" dates back to the early works of mathematician 
			Tobias Dantzig (1884–1956),[2] and refers to the commonplace problem of packing the most valuable 
			or useful items without overloading the luggage.</p>
	        <h2>Downloads</h2>
	        <ol><li><a href="http://users.monash.edu.au/~ksmiles/matilda/graphs.zip">Evolved graphs </a> from Smith-Miles, K. A. and Bowly, S., "Generating New Test Instances by Evolving in Instance Space", Computers & Operations Research, vol. 63, pp. 102-113, 2015.</li>
				<li><a href="http://users.monash.edu.au/~ksmiles/matilda/tsp.zip">Evolved TSP </a> instances from Smith-Miles, K. and van Hemert, J. Discovering the suitability of optimisation algorithms by learning from evolved instances, Ann Math Artif Intell, pp. 61-87, 2011.</li>
			</ol>	
		</div>
		
      </div>
    </div>
  </div>
</body>
</html>