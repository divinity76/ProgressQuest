<?
	include('db.php');
	include('util.php');

$posts = array();
$brags = array();
$dls = array();
$result = mysql_query("SELECT day,posts,brags,dls FROM pqsummary");
while ($row = mysql_fetch_row ($result)) {
	$posts[$row[0]] = $row[1];
	$brags[$row[0]] = $row[2];
	$dls[$row[0]] = $row[3];
}

$bcolor = ImageColorAllocate($gif,255,0,0);
$pcolor = ImageColorAllocate($gif,0,255,0);
$dcolor = ImageColorAllocate($gif,0,0,255);

$n = 0;
$m = 0;
$day = strtotime("20020129");
$oneday = strtotime("+1 day");
$today = strtotime(date("Ymd"));
while ($day < $today) {
	$d = date("Ymd",$day);
	if (!isset($posts[$d])) {
		$result = mysql_query("SELECT COUNT(*) FROM access_log WHERE uri = '/pq.zip/' AND stamp='$d'") or die(mysql_error());
		$ds = $mysql_result($result,0,0);
  	$dls[$d] = $ds;

		$result = mysql_query("SELECT COUNT(*) FROM access_log WHERE INSTR(uri,'cmd=brag') > 0 AND stamp='$d'") or die(mysql_error());
		$bs = $mysql_result($result,0,0);
  	$brags[$d] = $bs;

		$d2 = date("Y-m-d", $day);
		$result = mysql_query("SELECT COUNT(*) FROM posts WHERE post_time='$d2'") or die(mysql_error());
		$ps = $mysql_result($result,0,0);
  	$posts[$d] = $ps;
	
		mysql_query("INSERT INTO pqsummary SET day='$d',posts=$ps,brags=$bs,dls=$ds") or die(mysql_error());
	}

	if ($m && ($m != $row[2])) {
		ImageFilledRectangle($gif, $n * $w,$height+2,$n*$w,$height+$margin,$black);
		ImageString($gif,2,$n*$w + 5,$height,$row[2],$black);
	}

	ImageFilledRectangle($gif, $x, $height-$brags[$d]/$bscaler, $x, $height-1, $bcolor);
	$x++;
	ImageFilledRectangle($gif, $x, $height-$posts[$d]/$pscaler, $x, $height-1, $pcolor);
	$x++;
	ImageFilledRectangle($gif, $x, $height-$dls[$d]/$dscaler, $x, $height-1, $dcolor);
	$x++;
	$x++;
	
	$m = $row[2];
	$n += 1;
}
 



                        


// create the image
$width = 300;
$height = 100;
$scaler = 100;
$pscaler = 10;

$margin = 12;
$gif = ImageCreate($width,$height + $margin);
$bg = ImageColorAllocate($gif,225,225,255);
$tx = ImageColorAllocate($gif,0,220,92);
$black = ImageColorAllocate($gif,0,0,0);
$white = ImageColorAllocate($gif,255,255,255);
$red = ImageColorAllocate($gif,255,128,92);
ImageFilledRectangle($gif,0,0,$width,$height,$bg);
ImageFilledRectangle($gif,0,$height,$width,$height+50,$white);
ImageString($gif,2,140,3,"daily player activity",$tx);
ImageString($gif,2,140,15,"daily forum activity (x10)",$red);

$w = 4;
$limit = $width / $w;

$posts = array();
$result = mysql_query("SELECT COUNT(*), CONCAT(SUBSTRING(post_time,1,4),SUBSTRING(post_time,6,2),SUBSTRING(post_time,9,2)) AS t FROM posts GROUP BY t ORDER BY t LIMIT $limit");
while ($row = mysql_fetch_row ($result)) {
	$posts[$row[1]] = $row[0];
}

$result = mysql_query("SELECT COUNT(*), SUBSTRING(time,1,8) AS t, MONTHNAME(time) FROM access_log WHERE INSTR(uri,'cmd=brag') > 0 GROUP BY t ORDER BY t LIMIT $limit");
$count = mysql_num_rows($result);
$n = 0;
$m = 0;
while ($row = mysql_fetch_row ($result)) {
	if ($n == $count-1)
		$tx = ImageColorAllocate($gif,162,220,180);
	ImageFilledRectangle($gif, $n * $w,$height-$row[0]/$scaler,$n*$w+$w-2,$height,$tx);
	if (isset($posts[$row[1]])) {
		ImageFilledRectangle($gif, $n * $w,$height-$posts[$row[1]]/$pscaler,$n*$w+1,$height,$red);
	}
	if ($m && ($m != $row[2])) {
		ImageFilledRectangle($gif, $n * $w,$height+2,$n*$w,$height+$margin,$black);
		ImageString($gif,2,$n*$w + 5,$height,$row[2],$black);
	}
	$m = $row[2];
	$n += 1;
}
 
// send the image
header("content-type: image/png");
ImagePng($gif);

?>