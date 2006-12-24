<?
	include('log.php');
	include('db.php');
	include('util.php');

	heading("Progress Quest Stats");
?>


<center>
<h1>Stats</h1>

			<style> 
				<? include('pq.css') ?>
			</style> 

<?
	function showstats($caption, $query) {
		print "<table border=1 width=100%>";
		print "<tr><th colspan=2>$caption";
		$result = mysql_query($query) or die(mysql_error());
		$n = 1;
		while ($row = mysql_fetch_row ($result)) {
			$v = htmlspecialchars($row[0]);
			$p = round($row[1] / $row[2]); 
			print "<tr><td>$n. $v<td align=right>$p</tr>";
			$n++;
		}
		print "</table>";
	}

	$filter = '(stigma = 0 AND level < 99 AND level > 0)';

	$result = mysql_query("SELECT COUNT(*), SUM(level), SUM(LEAST(level-1,1)) FROM pqhi WHERE $filter") or die(mysql_error());
	$count = mysql_result($result, 0);
	$slugg = mysql_result($result, 0, 1);
	$elite = mysql_result($result, 0, 2);
	print "Pop. $count<br>($elite level 2 or higher)<br>";
	print "Average Level: " . round($slugg/$count);

	$top = 5;
	$suffix = ",1 FROM pqhi WHERE $filter GROUP BY 1 ORDER BY c DESC LIMIT $top";

	print "<table border=0 style='border-style:none' cellspacing=20><tr><td class=nobo>";
	showstats("Top $top Races by Popularity",       "SELECT race, COUNT(*) AS c $suffix");
	print "<td class=nobo>";
	showstats("Top $top Races by Combined Level",   "SELECT race, SUM(level) AS c $suffix");
	print "<tr><td class=nobo>";
	showstats("Top $top Classes by Popularity", 		"SELECT class, count(*) AS c $suffix");
	print "<td class=nobo>";
	showstats("Top $top Classes by Combined Level", "SELECT class, sum(level) AS c $suffix");
	print "<tr><td class=nobo>";
	showstats("Top $top Avatars by Popularity", 		"SELECT CONCAT(race,' ',class), count(*) AS c $suffix");
	print "<td class=nobo>";
	showstats("Top $top Avatars by Combined Level", "SELECT CONCAT(race,' ',class), sum(level) AS c $suffix");
	print "</table>";

	footer();
?>	


