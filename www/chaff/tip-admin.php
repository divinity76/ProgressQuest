<?
	include('log.phpi');

	mysql_connect('localhost','progressquest','placenta') or die("Unable to connect");
	mysql_select_db("progressquest") 
		or die("Unable to select db");
	mysql_query("
		CREATE TABLE IF NOT EXISTS pqtips (
      num INTEGER NOT NULL AUTO_INCREMENT,
		  tip TEXT DEFAULT NULL,
		  stamp TIMESTAMP DEFAULT NULL, 
      PRIMARY KEY (num) )
		")
		or die(mysql_error());

	function arg($parm) {
		return mysql_escape_string(stripslashes($parm));
	}

  if (isset($cmd)) {
    $tip = arg($tip);
		$num = arg($num);
		if ($cmd == "add" && $tip != '')
  		mysql_query("INSERT INTO pqtips (tip) VALUES ('$tip')") or die(mysql_error());
		if ($cmd == "update")
  		mysql_query("UPDATE pqtips SET tip = '$tip' WHERE num = $num") or die(mysql_error());
		if ($cmd == "delete")
  		mysql_query("DELETE FROM pqtips WHERE num = $num") or die(mysql_error());
    header("Location: http://progressquest.com/tip-admin.php?list=1");
    exit();
  }

	$result = mysql_query("SELECT COUNT(*) FROM pqtips") or die(mysql_error());
	$count = mysql_result($result, 0);
?>

<h2> PQ Tip Admin</h2>


<a href=/tip-admin.php?list=1>List all <? echo($count) ?></a>



<p>
<form>

<?
  if (isset($num)) {
		$result = mysql_query("SELECT num,tip FROM pqtips WHERE num=$num") or die(mysql_error());
		while ($row = mysql_fetch_row($result)) {
	  	$tip = $row[1];
      echo("<h3>Tip $num</h3> <font color=blue>$tip</font>");
    }
		echo("<input type=hidden name=num value=$num>");
  }
?>

<p>
<textarea name=tip rows=10 cols=50>
<? echo($tip) ?>
</textarea>

<br>
<input type=submit name=cmd value=add>

<? if (isset($num)): ?>
	<input type=submit name=cmd value=update>
	<input type=submit name=cmd value=delete>
<? endif; ?>

</form>
<p>

<?
	if ($list) {
    echo("<table>");
		$result = mysql_query("SELECT num,tip FROM pqtips ORDER BY num")or die(mysql_error());
		while ($row = mysql_fetch_row($result)) {
  		$num = $row[0];
			$tip = $row[1];
			if (strlen($tip) > 30)
				$tip = substr($tip,0,27) . "...";
	  	$tip = htmlspecialchars($tip);
      echo("<tr><td><a href=/tip-admin.php?num=$num>$num</a><td>$tip");
    }
    echo("</table>");
  }
?>
