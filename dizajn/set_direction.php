<!DOCTYPE html>
<html>
<body>

<?php
error_reporting(E_ALL);
/*echo "in the function for handling data change<br>";
*/

$data=$_GET["val"];	//get data from URL

switch ($data) {
	case 'front':
		echo "Going front !";
		break;
	
	case 'left':
		echo "Going left !";
		break;

	case 'right':
		echo "Going right !";
		break;

	case 'back':
		echo "Going back !";
		break;

	case 'stop':
		echo "Must stop now !";
		break;

	case 'led':
		echo "Must change LED state !";
		break;

	default:
		# code...
		break;
}

/*ako bude vremena raditi i na tome da se togglea button za led*/

/*echo "direction is: ".$_GET["val"];
echo $data;*/


?>

</body>
</html>
