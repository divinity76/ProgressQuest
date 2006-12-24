<?
	include('../log.php');
	include('../db.php');
	include('../util.php');

	mysql_query("
		CREATE TABLE IF NOT EXISTS pqquotes (
      num INTEGER NOT NULL AUTO_INCREMENT,
		  quote TEXT DEFAULT NULL,
			source TEXT DEFAULT NULL,
		  stamp TIMESTAMP DEFAULT NULL, 
      PRIMARY KEY (num) )
		")
		or die(mysql_error());

  if (isset($cmd)) {
    $quote = arg($quote);
		$source = arg($source);
		$loc = "Location: http://progressquest.com/quote-admin.php?list=1";
		if (isset($num))
			$loc = $loc . "&disp=$num";
		$num = arg($num);
		if ($cmd == "add")
  		mysql_query("INSERT INTO pqquotes (quote,source) VALUES ('$quote','$source')") or die(mysql_error());
		if ($cmd == "update")
  		mysql_query("UPDATE pqquotes SET quote='$quote', source='$source' WHERE num=$num") or die(mysql_error());
		if ($cmd == "delete")
  		mysql_query("DELETE FROM pqquotes WHERE num=$num") or die(mysql_error());
		header($loc);
    exit();
  }

	$result = mysql_query("SELECT COUNT(*) FROM pqquotes") or die(mysql_error());
	$count = mysql_result($result, 0);
?>

<h2> PQ Quote Admin</h2>


<a href=/quote-admin.php?list=1>List all <? echo($count) ?></a>



<p>
<form>

<?
  if (isset($num)) 
		$disp = $num;
  if (isset($disp)) {
		$result = mysql_query("SELECT num,quote,source FROM pqquotes WHERE num=$disp") or die(mysql_error());
		if ($row = mysql_fetch_row($result)) {
      echo("<b>Quote $disp</b>");
			quotation($row[1], $row[2]);
			if (isset($num)) {
		  	$quote = $row[1];
		  	$source = $row[2];
				echo("<input type=hidden name=num value=$num>");
			}
		}
  }
?>

<p>
Quote<br>
<textarea name=quote rows=8 cols=80>
<? echo($quote) ?>
</textarea>

<br>
Source<br>
<textarea name=source rows=3 cols=80>
<? echo($source) ?>
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
    echo("<table style='border: solid 1'>");
		$result = mysql_query("SELECT num,quote,source FROM pqquotes ORDER BY num")or die(mysql_error());
		while ($row = mysql_fetch_row($result)) {
  		$num = $row[0];
			$quote = $row[1];
			$source = $row[2];
			if (strlen($quote) > 50)
				$quote = substr($quote,0,47) . "...";
			if (strlen($source) > 50)
				$source = substr($source,0,47) . "...";
	  	$quote = htmlspecialchars($quote);
	  	$source = htmlspecialchars($source);
      echo("<tr><td><a href=/quote-admin.php?num=$num>$num</a><td>$quote<td>$source");
    }
    echo("</table>");
  }
?>
