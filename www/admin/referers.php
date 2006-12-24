<?
	include('../log.php');
	include('../db.php');
	include('../util.php');
?>



<html>
<head>
  <title>Progress Quest Referers</title>
	<style> 
		<? include('../pq.css') ?>
	</style> 
</head>
<body bgcolor=#ffffff>
<font color=#404000>
<br>
<i>PQ Referers</i>

<p>
<?
if (!isset($host)) {
	print "<b>Hosts</b>";
	$query = <<<EOD
		select 
			count(*) as count,
			left(substring(referer,8),instr(substring(referer,8),'/')-1) as referer 
		from access_log 
		where instr(referer,'progressquest.com')<=0 
		group by referer 
		order by count desc
EOD;
} else {
	print "<b>$host</b> (<a href=referers.php>list all hosts</a>)<p>";
	$query = <<<EOD
		select 
			count(*) as count, 
			referer
		from access_log 
		where left(substring(referer,8),instr(substring(referer,8),'/')-1) = '$host' 
		group by referer 
		order by referer
EOD;
}

$query2 = htmlspecialchars($query);
$result = mysql_query($query) or die(mysql_error());

print "<table><tr>\n";
for ($i = 0; $i < mysql_num_fields($result); $i++)
	print "<th>" . mysql_field_name($result,$i) . "\n";
while ($row = mysql_fetch_row($result)) {
	$count = $row[0];
	$referer = $row[1];
  print "<tr><td>$count<td>";
	if (0 == strncmp($referer, "http://", 7))
		print "<a href=$referer>$referer</a>";
	else if (!isset($host)) 
		print "<a href=referers.php?host=$referer>$referer</a>";
	else
		print $referer;
}
print "</table>\n";

?>


</body></html>
