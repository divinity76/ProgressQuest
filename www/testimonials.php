<? 
	include('log.php'); 
	include('util.php'); 

	heading();

	print "<h1 align=center>Player Testimonials</h1>";
	
	$result = mysql_query("SELECT quote,source FROM pqquotes ORDER BY num DESC") 
		or die(mysql_error());
	while($row = mysql_fetch_row($result))
		quotation($row[0], $row[1]);
	footer(); 
?>