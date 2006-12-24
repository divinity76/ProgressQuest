<?
	if (0 && $cmd == 'create') {
		echo("Sorry! ProgressQuest.com is down. Try again in a few days... In the meantime, create a character offline.");
		exit();
	}

	include('log.php');
	include('db.php');
	include('util.php');

	if ($cmd == 'create') {
		//header('content-type: text/plain');
		srand((double)microtime()*1000000);
		$passkey = rand(); 
		$name = arg($name);
		$result = mysql_query("SELECT * FROM pqhi WHERE name='$name' and level >= 1") or die(mysql_error());
		if (mysql_num_rows($result) > 0) {
			echo("The character name you have selected is not available. Please choose a different name.");
		} else if (!is_numeric($rev) || $rev < 2) {
			echo("You version of Progress Quest is obsolete. You must download the latest version of Progress Quest before you can create any more online characters. Please visit http://progressquest.com/");
		} else {
			mysql_query("DELETE FROM pqhi WHERE name='$name'") or die(mysql_error());
			mysql_query("INSERT INTO pqhi(name,passkey) VALUES ('$name',$passkey)") or die(mysql_error());
			echo("ok|$passkey");
		}
		exit();
	}
	else if ($cmd == 'brag') {
		$name = arg($name);
		$class = arg($class);
		$race = arg($race);
		$level = intval($level);
		$plot = arg($plot);
		$item = arg($item);
		$spell = arg($spell);
		$stat = arg($stat);
		$motto = arg($motto);
		$ip = mysql_escape_string($REMOTE_ADDR);
		$result = mysql_query("SELECT passkey FROM pqhi WHERE name='$name'") or die(mysql_error());
		$key = mysql_result($result,0,0);
		if ($passkey == ((~$level * 9831) ^ $key)) {
	  		mysql_query("UPDATE pqhi SET class='$class', race='$race', level='$level', item='$item', spell='$spell', stat='$stat', plot='$plot', motto='$motto', ip='$ip' WHERE name='$name'");
      		if (($level > 299) || ($REMOTE_ADDR == '208.180.156.195'))
  	  			mysql_query("UPDATE pqhi SET stigma=1 WHERE name='$name'");
			echo("ok");
		} else {
			echo("forbidden");
		}
		exit();
	}
	
	if (isset($cmd)) {
		echo("'$cmd'?");
		exit();
	}

	if (!is_numeric($min))
		$min = 0;
	if (!is_numeric($max))
		$max = $cheaters ? 100 : 10;
	if (isset($name)) {
		$sname = arg($name);
		$result = mysql_query("SELECT level,stamp,stigma FROM pqhi WHERE level >= 1 AND name='$sname'");
		if ($row = mysql_fetch_row($result)) {
			$l = $row[0];
			$s = $row[1];
			$cheaters = $row[2];
			$filter = $cheaters ? '(stigma > 0)' : '(stigma = 0)';
			$result = mysql_query("SELECT COUNT(*) FROM pqhi WHERE $filter AND (level > $l OR (level = $l AND stamp < '$s'))") or die(mysql_error());
			$min = mysql_result($result, 0);
			$min -= 6;
			$max = 13;
			if ($min < 0) { $max += $min; $min = 0; }
		}
	}

  $title = "Fame";
  if ($cheaters)
    $title = "Infamy";
  $filter = $cheaters ? '(stigma > 0)' : '(stigma = 0)';

  $result = mysql_query("SELECT COUNT(*) FROM pqhi WHERE $filter AND level >= 1") or die(mysql_error());
  $count = mysql_result($result, 0);

?>

<html>
<head>
  <title>Progress Quest Hall of <? echo($title) ?></title>
	<script>
	   function okp(){
        if(event.ctrlKey && event.keyCode == 13)
					alert('From within the *game*, Einstein.');
		}
	</script>
	<style> 
		<? include('pq.css') ?>
	</style> 
</head>
<body bgcolor=#ffffff onKeyPress="okp()">
<center>
<img src=pq.gif>
<font color=#404000>
<br>
<?
	echo("<i>Pop. $count</i>");
?>

<p>
<h1>Hall of <? echo($title) ?></h1>

<table border=1>

<tr><th align=right>Rank<th>Name<th>Race<th>Class<th align=right>Level<th>Prime Stat<th>Plot Stage<th>Prized Item<th>Specialty<th>Motto (Ctrl-M)</tr>
<?
	$result = mysql_query("SELECT name,race,class,level,plot,item,spell,stat,motto,stamp FROM pqhi WHERE $filter AND level >= 1 ORDER BY level DESC, stamp LIMIT $min,$max");
	$name = stripslashes($name);
	$n = $min + 1;
	while ($row = mysql_fetch_row ($result)) {
		$dbname = htmlspecialchars($row[0]);
		$race = htmlspecialchars($row[1]);
		$class = htmlspecialchars($row[2]);
		$level = $row[3];
		$plot = htmlspecialchars($row[4]);
		$item = htmlspecialchars($row[5]);
		$spell = htmlspecialchars($row[6]);
		$stat = htmlspecialchars($row[7]);
		$motto = htmlspecialchars($row[8]);
		$td = ($row[0] == $name) ? "td class=sel" : "td"; 
		echo("<tr class=bob><$td align=right>$n.<$td>$dbname<$td>$race<$td>$class<$td align=right>$level<$td>$stat<$td>$plot<$td>$item<$td>$spell<$td>$motto</tr>");
		$n = $n + 1;
	}
?>
</table>
<?
		//mysql_close($db);

  if ($cheaters) 
     echo("<div align=center><small><a class=dim href=mailto:court-of-appeals@progressquest.com>Were you wrongly accused? Make your case.</a></small></div>");


?>	

<p align=center>

<a href=/hi.php?max=10>Top 10</a> -
<a href=/hi.php?max=100>Top 100</a>
<? 
  if (!$cheaters) {
	  $span = $max;
	  $max = $min + $max;
	  if ($span > 100) $span = 100;
	  if ($span < 10) $span = 10;
	  if ($min > 0) {
	    $from = $min - $span;
	    if ($from < 0)
	      echo("- <a href=/hi.php?max=$span>First $span</a>\n");
	    else
	      echo("- <a href=/hi.php?min=$from&max=$span>Previous $span</a>\n");
	  }
	  if ($max < $count) {
	    $to = $max + $span;
	    if ($to >= $count) {
	      $span = $count - $max;
	      echo("- <a href=/hi.php?min=$max&max=$span>Last $span</a>\n");
	    } else {
	      echo("- <a href=/hi.php?min=$max&max=$span>Next $span</a>\n");
	    }
	  }
  }

  footer();
?>
