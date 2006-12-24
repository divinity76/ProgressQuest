<?
	function arg($parm) {
		return mysql_escape_string(stripslashes($parm));
	}

	function heading($title="Progress Quest") {
?>
		<html>
		<head>
			<title><? echo($title) ?></title>
		</head>
		<body bgcolor=#ffffff alink=blue vlink=black>
		<p align=center>
		<img src=/pq.gif>
		<font color=#404000>
		<br>
		<i>progressus imprimis</i>
<?
	}

	function footer() {
?>
		<p align=center>
		<a href=/>Home</a> -
		<a href=/pq.html>Info</a> -
		<a href=/dl>Download</a> -
		<a href=/hi.php>Hall of Fame</a>/<a href=/hi.php?cheaters=1>Infamy</a> -
		<a href=http://cafepress.com/pqm>Store</a> -
		<a href=/stats.php>Stats</a> -
		<a href=/bb>Forum</a>

			<style><!--
				a.dim:anchor, a.dim:visited { color: #808080 }
		  --></style>

		<p align=center>
		<small>
		<font color=#808080>
		&copy;2002 <a class=dim href=mailto:grumdrig@progressquest.com>grumdrig@progressquest.com</a>
		</font></small>
		</body></html>
<?
	}

	function quotation($quote,$source) {
?>
			<p align=center>
			<table width=60%>
			<tr height=3em><td>
			<tr><td>
			<div style='padding: 1em; background-color: #f5f5ff; border: solid 1 #707090'>
			<i>
			<small>
			<? echo($quote) ?></i>
			<div align=right>
  			-<? echo($source) ?>
			</div>
			</small>
			</div>
			<tr height=3em><td>
			</table>
<?
	}
?>