<?
	mysql_connect('localhost','eric','placenta') or die("Unable to connect");
	mysql_select_db("eric") 
		or die("Unable to select db");
	mysql_query("
		CREATE TABLE IF NOT EXISTS pq6hi (
		  name char(30) NOT NULL,
		  passkey int(11) NOT NULL,
		  race char(30) default NULL,
		  class char(30) default NULL,
		  level int(11) default NULL,
		  plot char(30) default NULL,
		  item char(50) default NULL,
		  spell char(30) default NULL,
			stat char(10) default NULL,
			motto char(50) default NULL,
		  stamp timestamp default NULL )
		")
		or die(mysql_error());

	if ($cmd == 'blah') {
		//$result = mysql_query("UPDATE pq6hi SET plot='Backward ass', item='Nothing', spell='Nada'") or die(mysql_error());
		exit();
	}
	if ($cmd == 'create') {
		header('content-type: text/plain');
		srand((double)microtime()*1000000);
		$passkey = rand(); 
		$name = mysql_escape_string($name);
		$result = mysql_query("SELECT * FROM pq6hi WHERE name='$name' and level >= 1") or die(mysql_error());
		if (mysql_num_rows($result) > 0) {
			echo("taken|The character name you have selected is not available. Please choose a different name.");
		} else {
			mysql_query("DELETE FROM pq6hi WHERE name='$name'") or die(mysql_error());
			mysql_query("INSERT INTO pq6hi(name,passkey) VALUES ('$name',$passkey)") or die(mysql_error());
			echo("ok|$passkey");
		}
		exit();
	}
	else if ($cmd == 'brag') {
		$name = mysql_escape_string($name);
		$class = mysql_escape_string($class);
		$race = mysql_escape_string($race);
		$level = intval($level);
		$plot = mysql_escape_string($plot);
		$item = mysql_escape_string($item);
		$spell = mysql_escape_string($spell);
		$stat = mysql_escape_string($stat);
		$motto = mysql_escape_string($motto);
		$result = mysql_query("SELECT passkey FROM pq6hi WHERE name='$name'") or die(mysql_error());
		$key = mysql_result($result,0,0);
		if ($passkey == (~$level * 9831) ^ $key) {
	  	mysql_query("UPDATE pq6hi SET class='$class', race='$race', level='$level', item='$item', spell='$spell', stat='$stat', plot='$plot', motto='$motto' WHERE name='$name'");
			echo("ok");
		} else {
			echo("forbidden");
		}
		exit();
	}
	else if (isset($query) && $passwd == 'livers') {
		$query = stripslashes($query);
		$query2 = htmlspecialchars($query);
		echo("<h3>$query2</h3>");
		$result = mysql_query($query) or die(mysql_error());
		print "<table>\n";
		while ($line = mysql_fetch_array($result, MYSQL_ASSOC)) {
		    print "\t<tr>\n";
		    foreach ($line as $col_value) {
		        print "\t\t<td>$col_value</td>\n";
		    }
		    print "\t</tr>\n";
		}
		print "</table>\n";
	}
	
	if (isset($cmd)) {
		echo("'$cmd'?");
		exit();
	}

	$result = mysql_query('SELECT name,race,class,level,plot,item,spell,stat,motto FROM pq6hi WHERE level >= 1 ORDER BY -level LIMIT 100');
?>

<html>
<head>
  <title>Progress Quest Hall of Fame</title>
	<script>
	   function okp(){
        if(event.ctrlKey && event.keyCode == 13)
					alert('From within the *game*, Einstein.');
		}
	</script>
</head>
<body bgcolor=#ffffff onKeyPress="okp()">
<center>
<img src=pq.gif>
<font color=#404000>
<br>
<i>quamvis progressio</i>

<p>
<h1>Hall of Fame</h1>
<style> 
	th { padding: 3px; border-style: solid; background-color: #ddddff; color: black; font: 8pt verdana; text-align: left; }
	td { padding: 3px; border-style: solid; color: black; font: 8pt verdana; }
</style> 
<table border=1>

<? 
	if ($admin == 'chickens') {
		echo("<form><input type=text name=query size=80><input type=hidden name=passwd value=livers><input type=submit value=SQL></form>");
		exit();
	}
?>

<tr><th align=right>Rank<th>Name<th>Race<th>Class<th align=right>Level<th>Prime Stat<th>Plot Stage<th>Most Prized Item<th>Specialty<th>Motto (Ctrl-M)</tr>
<?
	$n = 1;
	while ($row = mysql_fetch_row ($result)) {
		$name = htmlspecialchars($row[0]);
		$race = htmlspecialchars($row[1]);
		$class = htmlspecialchars($row[2]);
		$level = $row[3];
		$plot = htmlspecialchars($row[4]);
		$item = htmlspecialchars($row[5]);
		$spell = htmlspecialchars($row[6]);
		$stat = htmlspecialchars($row[7]);
		$motto = htmlspecialchars($row[8]);
		echo("<tr><td align=right>$n.<td>$name<td>$race<td>$class<td align=right>$level<td>$stat<td>$plot<td>$item<td>$spell<td>$motto</tr>");
		$n = $n + 1;
	}
?>
</table>
<?
		//mysql_close($db);
?>	

<p align=left>
<a href=/pq6.html>&larr; Regress</a>
</body></html>
