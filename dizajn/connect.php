<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/custom.css">
	<script src="js/respond.js"></script>
	<script src="jquery/jquery-2.2.4.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	

</head>


<body>
	<div class="container">

	<!-- row 1 -->
	<!-- <header class="row">
		<div class="col-lg-6 col-sm-5">
			<a href="#"><img src="images/elektroboj.png" alt="Bare i placenici"></a>
		</div>
	</header> -->


	<!-- create navigation panel -->
	<div class="navbar navbar-default">
		<ul class="nav navbar-nav">
			<!-- TODO-set same width -->
			<li><a href="aboutproject.html">About project</a></li>
			<li class="active"><a href="connect.html">Connect</a></li>
			<li><a href="team.html">Team</a></li>
			<li><a href="troubleshooting.html">FAQ</a></li>
			<li><a href="contact.html">Contact us</a></li>
			<li><a href="gallery.html">Gallery</a></li>
			<li><a href="127.0.0.1:8081">Camera live stream</a></li>
		</ul>
	</div>


	<div class="row">

		<aside class="col-lg-4 col-sm-5" style="border: 2px solid black; height:500px">

				<!-- left page -->
				<h5>DATA <button onclick="turnOnData()">Turn on DATA !</button></h2>		 
				<div class="css_camera_image" style="border: 2px solid black;">
					<div id="camera_image" align="middle"></div> 
				</div>

				<p></p>

				<div class="css_camera_image" style="border: 2px solid black;">
					<div id="sonar_image" align="middle" ></div> 
				</div>


		</aside>
		

		<aside class="col-lg-8 col-sm-7" style="border: 2px solid black; height:500px">
			
			<!-- right page -->
			<h1>ROBOT CONTROL</h1>

		<div class="row" style="border: 2px solid black;">
	        <div class="col-md-10 .col-xs-12 "><!-- reguliranje širine -->
	        <!-- md-reguliranje desktop screen-a, xs-reguliranje mobile screena -->

<div id="direction" align="middle" ></div> 
				

				<div class="row"><!-- first row -->
					<div class="col-md-4 text-center">
	                	<!-- empty div -->
	                </div>
					<div class="col-md-4 text-center">
	                    <button onclick="myFunction_gofront('front')" type="button" class="btn btn-success btn-lg">
	                    	<span class="glyphicon glyphicon-arrow-up" aria-hidden="true" id="my_button_1"></span>
	                    </button>
	                    <br><br><br>
	                </div>
	                <div class="col-md-4 text-right">
	                	<button onclick="myFunction_gofront('led')" type="button" class="btn btn-info btn-lg" id="my_button">LED</button>
	                </div>
				</div>

	            <div class="row"><!-- second row -->
	                <div class="col-md-4 text-right">
	                    <button onclick="myFunction_gofront('left')" type="button" class="btn btn-success btn-lg">
	                    	<span class="glyphicon glyphicon-arrow-left" aria-hidden="true" id="my_button_horizontal"></span>
	                    </button>
	                </div>
	                <div class="col-md-4 text-center">
	                	<!-- empty div -->
	                </div>
	                <div class="col-md-4 text-left">
	                    <button onclick="myFunction_gofront('right')" type="button" class="btn btn-success btn-lg">
	                    	<span class="glyphicon glyphicon-arrow-right" aria-hidden="true" id="my_button_horizontal"></span>
	                    </button>
	                    <br><br><br>
	                </div>
	            </div>



	            <div class="row"><!-- third row -->
					<div class="col-md-4 text-center">
	                	<!-- empty div -->
	                </div>
					<div class="col-md-4 text-center">
	                    <button onclick="myFunction_gofront('back')" type="button" class="btn btn-success btn-lg">
	                    	<span class="glyphicon glyphicon-arrow-down" aria-hidden="true" id="my_button_1"></span>
	                    </button>
	                </div>
	                <div class="col-md-4 text-right">
	                	<button onclick="myFunction_gofront('stop')" type="button" class="btn btn-danger btn-lg" id="my_button">STOP</button>
	                </div>
				</div>

				

	        </div>
   		 </div>



		
		</aside>

	<div class="row">
		<br>
		<br>
		<br>
		<br>
		<br>	
	</div>

	<div class="container">
	  <div class="row">
	  <hr>
	    <div class="col-lg-12">
	      <div class="col-md-8">
	        <a href="#">Terms of Service</a> | <a href="#">Privacy</a>    
	      </div>
	      <div class="col-md-4">
	        <p class="muted pull-right"><strong>© 2016 Bare i Plaćenici.</strong> All rights reserved</p>
	        <br><br>
	      </div>
	    </div>
	  </div>
	</div>

	</div><!-- end of main div -->

	<script>

			function turnOnData() {
				var myVar1 = setInterval(timer_3, 1000);
				var myVar2 = setInterval(timer_2, 1500);
			}


			function timer_3() {
				var xhttp = new XMLHttpRequest();
				 xhttp.onreadystatechange = function() {
					    if (xhttp.readyState == 4 && xhttp.status == 200) {		
					      	document.getElementById("camera_image").innerHTML = xhttp.responseText;
					    }
				  };
				xhttp.open("GET", "get_camera.php", true);
				 xhttp.send();
			}

			function timer_2() {
				var xhttp = new XMLHttpRequest();
				 xhttp.onreadystatechange = function() {
					    if (xhttp.readyState == 4 && xhttp.status == 200) {		
					      	document.getElementById("sonar_image").innerHTML = xhttp.responseText;
					    }
				  };
				xhttp.open("GET", "get_sonar.php", true);
				 xhttp.send();
			}

			function myFunction_gofront(data) {
			   document.getElementById("direction").innerHTML = "going front";

			   var xhttp = new XMLHttpRequest();
			   xhttp.onreadystatechange = function() {
				    if (xhttp.readyState == 4 && xhttp.status == 200) {
				      	document.getElementById("direction").innerHTML = xhttp.responseText;
				    }
			  };

			  xhttp.open("GET", "set_direction.php?val="+data, true);
			  xhttp.send();
			}



	</script>

	</div> <!-- end of container -->

</body>
</html>
