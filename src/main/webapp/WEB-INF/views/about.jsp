<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <meta content="IE=edge" http-equiv="X-UA-Compatible" />
  <title> Matilda </title>
  	<%@include file="/includes.jsp" %>
</head>
<body>
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	  <%@include file="authheader.jsp" %> 
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		<header id="centeralign_header">
        	<h1>Meet Our Team</h1>
        </header>
		
		<div style="padding-left: .5rem;">
			<h1 class="central_heading">Core Team</h1>
			<ul class="simple-listing simple-listing--four">
				<li class="simple-listing__item">
					<div class"simple-listing__link">
						<div class="listing_image" style="background-image: url( <c:url value="/resources/images/Webp.net-resizeimage.jpg" /> );"></div>
					    <h3 class="simple-listing__heading">Professor Kate Smith-Miles</h3>
					    <h3>Project Lead</h3>
					    <p class="simple-listing__excerpt">
					        Kate Smith-Miles is an ARC Australian Laureate Fellow, and Professor in the School of Mathematics and Statistics, 
					        The University of Melbourne. Her areas of interest are Algorithm Performance Analysis, Machine Learning 
					        and Pattern Recognition, Mathematical Modelling and Optimisation. <a class="no_underline detail" href="https://findanexpert.unimelb.edu.au/display/person811703" rel="">Find out more ></a></p>
				    </div>
				</li>
			
			  	<li class="simple-listing__item">
				  	<div class="simple-listing__link">
						<div class="listing_image" style="background-image: url( <c:url value="/resources/images/andres.jpg" /> );"></div>
					    <h3 class="simple-listing__heading">Dr Mario Andres Munoz Acosta</h3>
					    <h3>Research Fellow</h3>
					    <p class="simple-listing__excerpt">
					        Mario Andres received his Ph.D. degree in Engineering from The University of Melbourne and currently working as a Research 
					        Fellow at the School of Mathematics and Statistics, The University of Melbourne. 
					        <a class="no_underline detail" href="https://findanexpert.unimelb.edu.au/display/person638622" rel="">Find out more ></a></p>
				    </div>
				</li>
			
			  	<li class="simple-listing__item">
			    	<div class="simple-listing__link">
						<div class="listing_image" style="background-image: url( <c:url value="/resources/images/asghar.jpg" /> );"></div>
			      		<h3 class="simple-listing__heading">DR Asghar Moeini Korbekandi</h3>
			      		<h3>Research Fellow</h3>
			      		<p class="simple-listing__excerpt">
			        		Asghar Moeini completed his Ph.D. in operations research at Flinders University of Adelaide and Currently, 
			        		is a Research Fellow at the School of Mathematics and Statistics, The University of Melbourne. 
			        		<a class="no_underline detail" href="https://findanexpert.unimelb.edu.au/display/person812898" rel="">Find out more ></a></p>
			    	</div>
				</li>
			
			  	<li class="simple-listing__item">
			    	<div class="simple-listing__link" >
						<div class="listing_image" style="background-image: url( <c:url value="/resources/images/seevandi.jpg" /> );"></div>
				        <h3 class="simple-listing__heading">Dr Sevvandi Kandanaarachchi</h3>
				        <h3>Research Fellow</h3>
				        <p class="simple-listing__excerpt">
				          Sevvandi did her PhD in Geometric Analysis, which is a branch of Pure Mathematics at Monash. She is currently working on anomaly 
				          detection and related research areas.
				          <a class="no_underline detail" href="https://research.monash.edu/en/persons/sevvandi-kandanaarachchi" rel="">Find out more ></a></p>
			    	</div>
				</li>
			 
				<li class="simple-listing__item">
				    <div class="simple-listing__link">
						<div class="listing_image" style="background-image: url( <c:url value="/resources/images/baatar.jpeg" /> );"></div>
				      	<h3 class="simple-listing__heading">Dr Davaatseren Baatar</h3>
				      	<h3>Research Fellow</h3>
				      	<p class="simple-listing__excerpt">
				        	Dr Davaatseren works in the School of Mathematical Sciences at Monash University as a Research Fellow. His areas of interest
				        	are Optimisation and Mixed integer programming and their applications in real world problems.
				        	<a class="no_underline detail" href="https://research.monash.edu/en/persons/davaatseren-baatar" rel="">Find out more ></a></p>
				    </div>
				</li>
			
				<li class="simple-listing__item">
				    <div class="simple-listing__link">
						<div class="listing_image" style="background-image: url( <c:url value="/resources/images/jeffery.jpg" /> );"></div>
				        <h3 class="simple-listing__heading">Jeffrey Christiansen</h3>
				        <h3>Research Assistant</h3>
				        <p class="simple-listing__excerpt">
				          ***Kindly provide bio***
				          <a class="no_underline detail" href="https://sites.rmit.edu.au/rmitopt/tag/jeffrey-christiansen/" rel="">Find out more ></a></p>
				    </div>
				</li>
			
			  	<li class="simple-listing__item">
			    	<div class="simple-listing__link">
						<div class="listing_image" style="background-image: url( <c:url value="/resources/images/yan.jpeg" /> );"></div>
			      		<h3 class="simple-listing__heading">Tao Yan</h3>
			      		<h3>Research Assistant</h3>
			      		<p class="simple-listing__excerpt">
			        		Tao Yan is an experienced Quantitative Analyst with a demonstrated history of working in the gambling &amp; casinos industry. He is 
			        		skilled in Mathematical Modeling and Statistical Data Analysis.
			        		<a class="no_underline detail" href="https://www.linkedin.com/in/tao-yan-249732122/?locale=zh_CN" rel="">Find out more ></a></p>
			    	</div>
				</li>
			
			  	<li class="simple-listing__item">
			    	<div class="simple-listing__link">
						<div class="listing_image" style="background-image: url( <c:url value="/resources/images/neelofar2.jpg" /> );"></div>
			      		<h3 class="simple-listing__heading">Dr Neelofar</h3>
			      		<h3>Systems Specialist &amp; Web Developer</h3>
			      		<p class="simple-listing__excerpt">
			        		Neelofar completed her Ph.D in Engineering at the University of Melbourne and currently working as Systems Specialist and 
			        		Web Developer at the School of Mathematics and Statistics, The University of Melbourne.  
			        		<a class="no_underline detail" href="https://findanexpert.unimelb.edu.au/display/person746453" rel="">Find out more ></a></p>
			    	</div>
				</li>
		 	</ul>
	 
			<div class="ct-listing__selected-children_feature-listing-4" id="ct-listing-2786709">
				<h1 class="central_heading">Collaborators</h1>
				<ul class="simple-listing simple-listing--four">
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="http://www.dbai.tuwien.ac.at/staff/musliu/" rel="">
					      <h3 class="simple-listing__heading">Dr. Nysret Musliu </h3>
					      <h3>Vienna University of Technology, Austria</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.cardiff.ac.uk/people/view/98657-lewis-rhyd" rel="">
					      <h3 class="simple-listing__heading">Dr Rhyd Lewis</h3>
					      <h3>Cardiff University, Wales</h3>
					      </p>
					    </a>
					</li>
					 <li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.linkedin.com/in/janovanhemert/?originalSubdomain=au" rel="">
					      <h3 class="simple-listing__heading">Jano van Hemert</h3>
					      <h3>University of Edinburgh, Scotland</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://people.eng.unimelb.edu.au/mkirley/" rel="">
					      <h3 class="simple-listing__heading">Michael Kirley</h3>
					      <h3>The University of Melbourne, Australia</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://robjhyndman.com/" rel="">
					      <h3 class="simple-listing__heading">Professor Rob J Hyndman</h3>
					      <h3>Monash University, Australia</h3>
					      </p>
					    </a>
					</li>
					 <li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.linkedin.com/in/laura-villanova-ab57284a/?originalSubdomain=at" rel="">
					      <h3 class="simple-listing__heading">Laura Villanova</h3>
					      <h3>Graz, Styria, Austria</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.researchgate.net/profile/Ana_Lorena" rel="">
					      <h3 class="simple-listing__heading">Ana Carolina Lorena</h3>
					      <h3>Universidade Federal de São Paulo, Brazil</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://yanfei.site/" rel="">
					      <h3 class="simple-listing__heading">Yanfei Kang</h3>
					      <h3>Beihang University, China</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.linkedin.com/in/laura-villanova-ab57284a/?originalSubdomain=at" rel="">
					      <h3 class="simple-listing__heading">HANS D. MITTELMANN</h3>
					      <h3>Arizona State University, Unites States</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="http://users.monash.edu.au/~aldeidaa/" rel="">
					      <h3 class="simple-listing__heading">Aldeida Aleti</h3>
					      <h3>Monash University, Australia</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.informatik.hu-berlin.de/de/Members/lars-grunske" rel="">
					      <h3 class="simple-listing__heading">Professor Lars Grunske</h3>
					      <h3>Humboldt University, Berlin</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.linkedin.com/in/leo-lopes/" rel="">
					      <h3 class="simple-listing__heading">Leo Lopes</h3>
					      <h3>Think Big Analytics, Melbourne, Australia</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://researchprofile.canterbury.ac.nz/Researcher.aspx?researcherid=85265" rel="">
					      <h3 class="simple-listing__heading">Dr Ross Jonathan William James</h3>
					      <h3>University of Canterbury, New zealand</h3>
					      </p>
					    </a>
					</li>
				</ul>
			</div>

			<div class="ct-listing__selected-children_feature-listing-4" id="ct-listing-2786709"">
				<h1 class="central_heading">Students</h1>
				<ul class="simple-listing simple-listing--four" >
					  <li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.linkedin.com/in/simonbowly/?originalSubdomain=au" rel="">
					      <h3 class="simple-listing__heading">Simon Bowly</h3>
					      <h3>The University of Melbourne, Australia</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.linkedin.com/in/tttan/" rel="">
					      <h3 class="simple-listing__heading">Thomas Tan</h3>
					      <h3>Monash University, Australia</h3>
					      </p>
					    </a>
					</li>
					 <li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.linkedin.com/in/samuel-fairchild-0899b3122/?originalSubdomain=au" rel="">
					      <h3 class="simple-listing__heading">Samuel Fairchild </h3>
					      <h3>Monash University, Australia</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.linkedin.com/in/estefania-yap-6b9691144/?originalSubdomain=au" rel="">
					      <h3 class="simple-listing__heading">Estefania Yap</h3>
					      <h3>The University of Melbourne, Australia</h3>
					      </p>
					    </a>
					</li>
					<li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://robjhyndman.com/" rel="">
					      <h3 class="simple-listing__heading">Priyanga Dilini Talagala </h3>
					      <h3>Monash University, Australia</h3>
					      </p>
					    </a>
					</li>
					 <li class="simple-listing__item">
					    <a class="simple-listing__link" href="https://www.researchgate.net/profile/Carlos_Eduardo_De_Jesus_Guimaraes_Oliveira" rel="">
					      <h3 class="simple-listing__heading">Carlos Eduardo De Jesus Guimaraes Oliveira</h3>
					      <h3>Monash University, Australia</h3>
					      </p>
					    </a>
					</li>
					</ul>
			</div>
		</div>
        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>