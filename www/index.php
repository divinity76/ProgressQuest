<?
$try = 1;
if (!$try): 
	include('util.php'); 
	heading();
?>
<p align=center>
<table border=0 width=60%><tr><td colspan=2>
Well, it seems the site is partially down. 
We've gotten swamped.
Perhaps you can 
<b>download it</b>

<a href=http://briefcase.yahoo.com/bc/grumdrig/lst?.dir=/Progress+Quest>
HERE
</a>,

<a href=http://briefcase.yahoo.com/bc/lesterbarion/lst?.dir=/Progress+Quest>
HERE
</a>,

<a href=http://briefcase.yahoo.com/bc/progressquest/lst?.dir=/Progress+Quest>
HERE
</a>,

or
<a href=http://briefcase.yahoo.com/bc/efredricksen/lst?.dir=/Progress+Quest>
HERE
</a>.

<p>
Those downloads are likely to be mighty slow (Yahoo Briefcase is only so generous).
Luckily for you, several kind PQ fans have offered to host the download. Try one of
these:
<ul>
<li> <a href=http://market.swcombine.com/pq.zip>http://market.swcombine.com/pq.zip</a> 
			(the <a href=http://www.swcombine.com/>Star Wars Combine Simulation</a>
<li> <a href=http://modeseven.d2g.com/pq.zip>http://modeseven.d2g.com/pq.zip</a>
</ul>

<p>
You'll have to stick with single-player mode for the time being. 
Check back soon; we're working hard on getting site back up.
<tr><td colspan=2 align=right>
- <a href=mailto:grumdrig@progressquest.com>grumdrig@progressquest.com</a>

<tr height=1em><td height=1em><td>
<tr>
<td valign=center>
<center>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="business" value="grumdrig@progressquest.com">
<input type="hidden" name="item_name" value="Progress Quest Donation">
<input type="image" src="http://images.paypal.com/images/x-click-butcc-donate.gif" border="0" name="submit" alt="Support PQ til it hurts!">
</form></center>
<td>
In the meantime here's your chance to donate to the cause...
A thousand thanks to those who already have!  
If you'd rather donate bandwidth, which also rules, kindly
<a href=mailto:gobblemybandwidth@progressquest.com>send me a URL</a> I can post here. 
</table>

		<p align=center>
		<a href=/>Home</a> -
		<a href=/pq.html>Info</a> -
		Hall of Fame/Infamy -
		<a href=http://cafepress.com/pqm>Store</a> -
		Stats -
		Forum



<?
	exit();

endif;



	include('util.php'); 

	heading();

	include('db.php');
	$result = mysql_query("SELECT quote,source FROM pqquotes ORDER BY RAND() LIMIT 1") 
		or die(mysql_error());
 	$row = mysql_fetch_row($result);
	quotation($row[0], $row[1]);
	print "<table width=60% border=0><tr><td align=right><div align=right><a class=dim href=testimonials.php><small>more testimonials...</small></a></table>";

/*
	quotation(
		"The site died, but has returned. Please have patience if it dies again. We're working on it!", 
		"Grumdrig");
	print "<table width=60% border=0><tr><td align=right><div align=right><a class=dim href=testimonials.php><small>more testimonials...</small></a></table>";
*/

	footer(); 
	include('log.php'); 
?>