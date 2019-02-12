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
  <link rel="stylesheet" href="<c:url value="/resources/css/matilda.css" /> ">
  <script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script>
</head>
<body>
	
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	  <%@include file="authheader.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		<h2> What is MATILDA?</h2>
		<p><b>MATILDA</b> – Melbourne Algorithm & Test Instance Library with Data 
		Analytics – is research platform developed via the project “Stress-testing algorithms: 
		generating new test instances to elicit insights”. The project has been funded by the 
		Australian Research Council under the Australian Laureate Fellowship scheme awarded to 
		Professor Kate Smith-Miles (2014-2019). The project aims to develop powerful new methodologies 
		and tools to reveal the strengths and weaknesses of algorithms, and new test instance 
		generation methods to support such analysis. The methodology has been applied to a wide 
		variety of “algorithmic science” fields including: combinatorial optimisation, continuous 
		black-box optimisation, machine learning, time series forecasting, software testing, and 
		several other fields. </p> 
		
		<h2>What is the significance of our research?</h2>
		<p>For many classes of problems there are numerous algorithms that have been developed. 
		However, the No Free Lunch Theorems suggest that we should not expect one algorithm to outperform 
		all others across all possible instances of the problem. Different algorithms employ different 
		underlying mechanisms that may exploit certain properties of the data instance, failing to provide 
		good solutions if the instance does not possess such properties that make the algorithm particularly 
		well suited. It is typically an open question of which algorithm will be the best for solving a 
		given instance of the problem. Thus, if we want to select the most suitable algorithm for a given 
		instance of a problem, it is crucial to understand the strengths and weaknesses of algorithms. 
		New methodologies to support researchers are needed. The toolkit available in MATILDA not only 
		supports insights in the quest for selecting the right algorithm for the right problem; it 
		also helps avoid tedious trial-and-error testing or, even worse, a deployment disaster when 
		an unreliable algorithm is chosen.</p>
		
		<h2>Research Outcomes</h2>
		
		<p>MATILDA contains new methodologies and tools to facilitate:</p>
		<ul>
			<li>visualisations of the instance space for a problem
				<ul>
					<li>showing the location of benchmark test instances across the instance space</li>
					<li>showing the strengths (“footprints”) and weaknesses of algorithms across the instance space</li>
					<li>summarising the properties of the instances that an algorithm finds easy or hard</li>
				</ul>
			</li>
			<li>objective (unbiased) metrics of algorithmic power in comparison to state-of-the-art algorithms</li>
			<li>synthetic generation of new test instances at specific locations in the instance space (e.g. real-world-like instances, or instances with controllable properties)</li>
			<li>automated algorithm selection tools to assist deployment of the best algorithm for a given instance.</li>
		</ul>
		<p>The available problem classes currently include:</p>
		<ol>
			<li>Optimisation
				<ul>
					<li>Combinatorial Optimisation Problems (Graph Colouring, Travelling Salesman Problem, Knapsack Problem, Linear Programming, Mixed Integer Programming, Black-Box Single Objective, Black-Box Multi-Objective, Hamiltonian Cycle Problem, )</li>
					<li>Mixed-Integer Programming</li>
					<li>Continuous Black-Box Optimisation (Single Objective, Multi-Objective)</li>
				</ul>
			</li>
			<li>Learning and Model FItting
			<ul>
				<li>Machine Learning (Classification, Regression, Clustering</li>
				<li>Time Series Forecasting</li>
			</ul>
			</li>
		</ol>
		
		<p>If you have additional problems you would like to make available in MATILDA, please 
		contact us (matilda-team@unimelb.edu.au)</p>
		
		<h2>USING MATILDA</h2>
		<p>The engine behind this website is powered by MATILDA research outcomes and facilitates users to:</p>
		<ul>
			<li><a href="#">Download benchmark datasets for various problems</a></li>
			<li><a href="#">Upload their algorithm performance metrics and visualize strength and weaknesses across our constructed instance space</a></li>
			<li><a href="#">Download performance visualisation graphs and objective metrics</a></li>
			<li><a href="#">Download other researcher's solutions</a></li>
		</ul> 
		<h2>Research Publications</h2>
		<p>The methodology used by MATILDA for visualizing and understanding the strengths and 
		weaknesses of different algorithms has been originally described in a series of three 
		papers focusing on graph colouring:</p>
		<ul>
			<li>Smith-Miles, K. A., and Lopes, L. B., “Measuring Instance Difficulty for Combinatorial 
			Optimization Problems”, Computers & Operations Research, vol. 39, no. 5, pp. 875-889, 2012.</li>
			<li>Smith-Miles, K. A., Baatar, D., Wreford, B. and Lewis, R., “Towards Objective Measures 
			of Algorithm Performance across Instance Space”, Computers & Operations Research, 
			vol. 45, pp. 12-24, 2014.</li>
			<li>Smith-Miles, K. A. and Bowly, S., "Generating New Test Instances by Evolving in 
			Instance Space", Computers & Operations Research, vol. 63, pp. 102-113, 2015.</li>
		</ul>
		<p>Additional publications from the MATILDA team have applied this methodology to a wide 
		variety of other problem domains, including:</p>
		<ul>
			<li>Guimares, C., Aleti, Al, Grunske, L. and Smith-Miles, K., "Mapping the Effectiveness 
			of Automated Test Suite Generation Techniques", IEEE Transactions on Reliability, vol. 
			67, no. 3, pp. 771-785, 2018.</li>
		    <li>​Muñoz, M. A., Villanova, L., Baatar, D. and Smith-Miles, K. A., "Instance Spaces for 
		    Machine Learning Classification", Machine Learning, vol. 107, no. 1, pp. 109-147, 2018.</li>
		    <li>Kang, Y., Hyndman, R. and Smith-Miles, K., "Visualising Forecasting Algorithm Performance 
		    using Time Series Instance Spaces", International Journal of Forecasting, vol. 33, no. 2, pp. 345-358, 2017.</li>
		    <li>​Muñoz, M. A. and Smith-Miles, K. A., "Performance analysis of continuous black-box optimization 
		    algorithms via footprints in instance space", Evolutionary Computation, vol. 25. no. 4, pp. 529-554, 2017.</li>
		    <li>Smith-Miles, K. and Tan, T. “Measuring Algorithm Footprints in Instance Space”, in Proceedings 
		    of the 2012 IEEE Congress on Evolutionary Computation, pp. 3446-3453, 2012. </li>
		    <li>Smith-Miles, K. A., and Lopes, L. B., “Generalising Algorithm Performance in Instance Space: 
		    A timetabling case study”, Selected papers of the 5th International Conference on Learning and 
		    Intelligent Optimization, Lecture Notes in Computer Science, vol. 6683, pp. 524-539, Springer, 2011. </li>
		    <li>Smith-Miles, K. A., van Hemert, J., Lim, Y., “Understanding TSP Difficulty by Learning 
		    from Evolved Instances”, Selected papers of the 4th International Conference on Learning and 
		    Intelligent Optimization, Lecture Notes in Computer Science, vol. 6073, pp. 266-280, 2010.</li>
		    <li>Lopes, L. B. and Smith-Miles, K. A., “Pitfalls in Instance Generation for Udine Timetabling”, 
		    Selected papers of the 4th International Conference on Learning and Intelligent Optimization, Lecture 
		    Notes in Computer Science, vol. 6073, pp. 299-302, 2010.</li>
		    <li>Smith-Miles, K. A., James, R. J. W., Giffin, J. W. and Tu, Y., “A Knowledge Discovery Approach 
		    to Understanding Relationships between Scheduling Problem Structure and Heuristic Performance”, 
		    Selected papers of the 3rd International Conference on Learning and Intelligent Optimization, 
		    Lecture Notes in Computer Science, vol. 5851, pp. 89-103, 2009.</li>
	    </ul>
        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>