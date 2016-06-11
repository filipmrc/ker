<!DOCTYPE html>
<html>
<body>

<?php
error_reporting(E_ALL);

$rand=$_GET['t'];
//echo $rand;
//echo "maminjoo";
//$number=5;
//$number++;
//echo '<img src="data/images/proba'.$number.'.jpg">';
//echo '<p>maminjooo</p>';
//echo exec ('pwd');
//echo exec ('fswebcam /images/camera.jpg');
//header("Cache-Control: no-cache, no-store, must-revalidate");	//http 1.1
//echo '<br>';
$file=file_get_contents('image_info.txt', true);
//echo $file;
//echo "<br>";
$a="images/sensors/";
$b=$a.$file.".jpg";

//echo $b;
//echo '<br>';
$c="\"".$b."\"";
//echo $c;


//echo '<br>';
$d='<img src='.$c.'  style="height:220px; max-width: 100%;" >';
echo "$d";
#echo '<img src=$b>';
 
?>

</body>
</html>
