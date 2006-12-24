<?
	mysql_connect('localhost','progressquest','placenta') or die("Unable to connect");
	mysql_select_db("progressquest") 
		or die("Unable to select db");

	mysql_query("
		CREATE TABLE IF NOT EXISTS pqhi (
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
		  stamp timestamp default NULL,
      stigma tinyint default 0 )
		")
		or die(mysql_error());

?>