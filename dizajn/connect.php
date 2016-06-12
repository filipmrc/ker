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


	
	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">

	  <div class="navbar-header">
	    <a class="navbar-brand" href="https://www.estudent.hr/category/natjecanja/elektroboj/" target="newwindow">Elektroboj 2016</a>
	    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
	      <span class="icon-bar"></span>
	      <span class="icon-bar"></span>
	      <span class="icon-bar"></span>
	    </button>
	  </div>

	  <div class="navbar-collapse collapse">
	    <ul class="nav navbar-nav">
	        <li><a href="aboutproject.html">About project</a></li>
	        <li class="active"><a href="connect.php">Connect</a></li>
			<li><a href="team.html">Team</a></li>
			<li><a href="troubleshooting.html">FAQ</a></li>
			<li><a href="contact.html">Contact us</a></li>
			<li><a href="gallery.html">Gallery</a></li>
			<li><a href="127.0.0.1:8081" target="newwindow">Camera live stream</a></li>
	    </ul>
	    </div>

	  </div>
    </div>
	

	<br><br><br><br>



	<div class="row">
		<!-- extremely small devices, small devices, medium devices, large devices -->
		<aside class="col-lg-4 col-sm-5 col-xs-5" >

				<!-- left page -->
				<!-- <h5>DATA <button onclick="turnOnData()">Turn on DATA !</button></h2> -->

				<div class="css_camera_image">
					<div id="camera_image" align="middle"></div> 
				</div>

				<p></p>

				<div class="css_camera_image">
					<div id="sonar_image" align="middle" ></div> 
				</div>


		</aside>
		
		<!-- style="border: 2px solid black;" -->
		<aside class="col-lg-8 col-sm-7 col-xs-7" >


		<div class="row" >
	        <div class="col-md-10 .col-xs-12 "><!-- reguliranje širine -->
	        <!-- md-reguliranje desktop screen-a, xs-reguliranje mobile screena -->


				

				<div class="row"><!-- first row -->
					<div class="col-md-4 col-xs-4 text-center">
	                	<button onclick="turnOnData()" id="my_button_stop_led" type="button" class="btn btn-info">DATA</button>
	                </div>
					<div class="col-md-4 col-xs-4 text-center">
	                    <button onclick="myFunction_gofront('front')" type="button" class="btn btn-success btn-lg">
	                    	<span class="glyphicon glyphicon-arrow-up" aria-hidden="true" id="my_button_1"></span>
	                    </button>
	                    
	                </div>
	                <div class="col-md-4 col-xs-4 text-right">
	                	<button onclick="myFunction_gofront('led')" type="button" class="btn btn-info btn-lg" id="my_button_stop_led">LED</button>
	                </div>
				</div>
				<br>

	            <div class="row"><!-- second row -->
	                <div class="col-md-4 col-xs-4 text-right">
	                    <button onclick="myFunction_gofront('left')" type="button" class="btn btn-success btn-lg">
	                    	<span class="glyphicon glyphicon-arrow-left" aria-hidden="true" id="my_button_horizontal"></span>
	                    </button>
	                </div>
	                <div class="col-md-4 col-xs-4 text-center">
	                	<span id="direction" align="middle" ></span> 
	                </div>
	                <div class="col-md-4 col-xs-4 text-left">
	                    <button onclick="myFunction_gofront('right')" type="button" class="btn btn-success btn-lg">
	                    	<span class="glyphicon glyphicon-arrow-right" aria-hidden="true" id="my_button_horizontal"></span>
	                    </button>
	                    
	                </div>

	            </div>
				<br>


	            <div class="row"><!-- third row -->
					<div class="col-md-4 col-xs-4 text-center">
	                	<span id="time"></span>
	                </div>
					<div class="col-md-4 col-xs-4 text-center">
	                    <button onclick="myFunction_gofront('back')" type="button" class="btn btn-success btn-lg">
	                    	<span class="glyphicon glyphicon-arrow-down" aria-hidden="true" id="my_button_1"></span>
	                    </button>
	                </div>
	                <div class="col-md-4 col-xs-4 text-right">
	                	<button onclick="myFunction_gofront('stop')" type="button" class="btn btn-danger btn-lg" id="my_button_stop_led">STOP</button>
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

	<div class="container" id="footer">
	  <div class="row">
	  <hr>
	    <div class="col-lg-12">
	      <div class="col-md-8 col-xs-5">
	        <a href="#">Terms of Service</a> | <a href="#">Privacy</a>    
	      </div>
	      <div class="col-md-4 col-xs-7">
	        <p class="muted pull-right"><strong>© 2016 Bare i Plaćenici.</strong> All rights reserved</p>
	        <br><br>
	      </div>
	    </div>
	  </div>
	</div>

	</div><!-- end of main div -->

	<script>
			var myVar = setInterval(timer_1, 1000);

			function turnOnData() {
				var myVar1 = setInterval(timer_3, 1000);
				var myVar2 = setInterval(timer_2, 1500);
			}

			function timer_1() {
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
				    if (xhttp.readyState == 4 && xhttp.status == 200) {
				      	document.getElementById("time").innerHTML = xhttp.responseText;
				    }
				};
				xhttp.open("GET", "ajax_info.php", true);
				xhttp.send();
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

	<script src="js/jquery.bootstrap-autohidingnavbar.js"></script>

	<script>
      $("div.navbar-fixed-top").autoHidingNavbar();
    </script>

	</div> <!-- end of container -->

</body>
</html>
