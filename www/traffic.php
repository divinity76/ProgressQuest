<?

include('db.php');
include('util.php');

mysql_query("
CREATE TABLE IF NOT EXISTS pqsummary (
		day CHAR(8) NOT NULL,
		brags INTEGER,
		posts INTEGER,
		dls INTEGER,
		PRIMARY KEY(day))
") or die(mysql_error());

$posts = array();
$brags = array();
$dls = array();
$result = mysql_query("SELECT day,posts,brags,dls FROM pqsummary");
while ($row = mysql_fetch_row ($result)) {
	$posts[$row[0]] = $row[1];
	$brags[$row[0]] = $row[2];
	$dls[$row[0]] = $row[3];
}

// create the image
if (!isset($width))
	$width = 300;
if (!isset($height))
	$height = 100;
$margin = 12;

if (!isset($thickness))
	$thickness=2;
if (!isset($gap))
	$gap=$thickness;


$gif = ImageCreate($width,$height + $margin);
$bg = ImageColorAllocate($gif,225,225,255);
$tx = ImageColorAllocate($gif,0,220,92);
$black = ImageColorAllocate($gif,0,0,0);
$white = ImageColorAllocate($gif,255,255,255);
$red = ImageColorAllocate($gif,255,128,92);

ImageFilledRectangle($gif,0,0,$width,$height,$bg);
ImageFilledRectangle($gif,0,$height,$width,$height+50,$white);

$bcolor = ImageColorAllocate($gif,255,0,0);
$pcolor = ImageColorAllocate($gif,0,255,0);
$dcolor = ImageColorAllocate($gif,0,0,255);

//$bmax = 50000;
//$dmax = 10000;
//$pmax = 500;

$y=3;
if ($bmax) {
	ImageString($gif,2,5,$y,"player activity / $bmax", $bcolor);
	$y += 12;
}
if ($dmax) {
	ImageString($gif,2,5,$y,"downloads / $dmax", $dcolor);
	$y += 12;
}
if ($pmax) {
	ImageString($gif,2,5,$y,"forum activity / $pmax", $pcolor);
	$y += 12;
}

$bscale = $bmax / $width;
$pscale = $pmax / $width;
$dscale = $dmax / $width;

$x = 0;
$mstore = 0;
$day = strtotime("20020129");
$oneday = strtotime("0000-00-01");
$today = strtotime(date("Ymd"));
while ($x < $width) {
	$d = date("Ymd",$day);
	if ($day < $today && !isset($posts[$d])) {
		$result = mysql_query("SELECT COUNT(*) FROM access_log WHERE uri = '/pq.zip/' AND time='$d'") or die(mysql_error());
		$ds = mysql_result($result,0,0);
  	$dls[$d] = $ds;

		$result = mysql_query("SELECT COUNT(*) FROM access_log WHERE INSTR(uri,'cmd=brag') > 0 AND time='$d'") or die(mysql_error());
		$bs = mysql_result($result,0,0);
  	$brags[$d] = $bs;

		$d2 = date("Y-m-d", $day);
		$result = mysql_query("SELECT COUNT(*) FROM posts WHERE post_time='$d2'") or die(mysql_error());
		$ps = mysql_result($result,0,0);
  	$posts[$d] = $ps;
	
		mysql_query("INSERT INTO pqsummary SET day='$d',posts=$ps,brags=$bs,dls=$ds") or die(mysql_error());
	}

	$m = date("F",$day);
	if ($mstore && ($m != $mstore)) {
		ImageFilledRectangle($gif, $x, $height+2, $x, $height+$margin, $black);
		ImageString($gif, 2, $x + 5, $height, $m, $black);
	}
	$mstore = $m;

	if ($bmax) {
		ImageFilledRectangle($gif, $x, $height-$brags[$d]*$height/$bmax, $x+$thickness-1, $height-1, $bcolor);
		$x+=$thickness;
	}
	if ($pmax) {
		ImageFilledRectangle($gif, $x, $height-$posts[$d]*$height/$pmax, $x+$thickness-1, $height-1, $pcolor);
		$x+=$thickness;
	}
	if ($dmax) {
		ImageFilledRectangle($gif, $x, $height-$dls[$d]*$height/$dmax, $x+$thickness-1, $height-1, $dcolor);
		$x+=$thickness;
	}
	$x += $gap;

	$d++;
	$day = strtotime($d);
}
 
// send the image
header("content-type: image/png");
ImagePng($gif);

?>