<?
	include('../log.php');
	include('../db.php');
	include('../util.php');
?>

<html>
<head>
  <title>Progress Quest Admin</title>
	<style> 
		<? include('../pq.css') ?>
	</style> 
</head>
<body bgcolor=#ffffff>
<font color=#404000>
<br>
<i>quamvis progressio</i>

<p>
	<form>
	<input type=text name=query size=80 height=5em value="<? echo(stripslashes($query)) ?>">
	<input type=submit value=Go>
	</form>

<?
	if (isset($query)) {
		$query = stripslashes($query);
		$query2 = htmlspecialchars($query);
		echo("<b>$query2</b><br>");
		$result = mysql_query($query) or die(mysql_error());
		if (is_bool($result)) {
			echo($result ? 'OK' : 'FAILED');
		}
		else {
			print "<table><tr>\n";
			for ($i = 0; $i < mysql_num_fields($result); $i++)
				print "<th>" . mysql_field_name($result,$i) . "\n";
			while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
			    print "\t<tr>\n";
			    foreach ($line as $col_value) {
			        print "\t\t<td>";
				if (0 == strncmp($col_value, "http://", 7))
					print "<a href=$col_value>$col_value</a>";
				else
					print $col_value;
				print "</td>\n";
			    }
			    print "\t</tr>\n";
			}
			print "</table>\n";
		}
	}
?>


</body></html>
