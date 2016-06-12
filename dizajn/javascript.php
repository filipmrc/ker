<!DOCTYPE html>
<html>
<head>
</head>
<body>

<img src="images/proba.jpg" alt="Processing output" style="width:304px;height:228px;">

<button onclick="myFunction_gofront()">GO FRONT</button>
<button onclick="myFunction_goback()">GO BACK</button> 
<button onclick="turnOnSonar()">Turn on sonar !</button> 
<button onclick="turnOnCamera()">Turn on camera !</button> 

<h1>Camera output:</h1>
<!--<img src="images/camera.jpg" alt="Camera output" style="width:304px;height:228px;">-->
<div id="camera_image"></div> 

<p id="direction"><br></p> 
<p id="time"></p> 
<p id="image"></p> 

<script>

var myVar = setInterval(timer_1, 1000);

function turnOnSonar() {
	var myVar = setInterval(timer_2, 3000);
}

function turnOnCamera() {
	var myVar = setInterval(timer_3, 4000);
}

function myFunction_gofront() {
   document.getElementById("direction").innerHTML = "going front";

   var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
	    if (xhttp.readyState == 4 && xhttp.status == 200) {
	      	document.getElementById("direction").innerHTML = xhttp.responseText;
	    }
  };
  xhttp.open("GET", "set_direction.php?val=1", true);
  xhttp.send();
}

function myFunction_goback() {
  document.getElementById("direction").innerHTML = "going back";

  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
	    if (xhttp.readyState == 4 && xhttp.status == 200) {
	      	document.getElementById("direction").innerHTML = xhttp.responseText;
	    }
  };
  xhttp.open("GET", "set_direction.php?val=0", true);
  xhttp.send();

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

function timer_2() {
	var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
		    if (xhttp.readyState == 4 && xhttp.status == 200) {
		      	document.getElementById("image").innerHTML = xhttp.responseText;
		    }
	  };
	  xhttp.open("GET", "get_image.php", true);
	  xhttp.send();
}

function timer_3() {
	//var el = document.getElementById('camera_image');
	//el.parentNode.removeChild(el);
//document.getElementById("camera_image").remove();
	var xhttp = new XMLHttpRequest();

	 xhttp.onreadystatechange = function() {
		   //var myURL="get_camera.php";

		    if (xhttp.readyState == 4 && xhttp.status == 200) {
			
		      	document.getElementById("camera_image").innerHTML = xhttp.responseText;
		    }
	  };
	xhttp.open("GET", "get_camera.php", true);
	//xhttp.setRequestHeader('Cache-Control', 'no-cache');
	  //xhttp.open("GET", myURL, true);
	  xhttp.send();
}



</script>



</body>
</html> 

