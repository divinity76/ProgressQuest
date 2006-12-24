<?
	$domain = 'progressquest'; 
	mysql_connect('localhost',$domain,'placenta') or die(mysql_error());
	mysql_select_db($domain) or die(mysql_error());
	mysql_query("
		CREATE TABLE IF NOT EXISTS access_log (
			time TIMESTAMP,
			ip CHAR(15),
			uri VARCHAR(100),
			user_agent VARCHAR(50),
			uid INTEGER DEFAULT 0,
			referer VARCHAR(250)
		)") or die(mysql_error());
	
	if (!is_numeric($uid)) {
		$uid = rand();
		setcookie('uid', $uid, mktime(1,1,1,1,1,2030));
	}

	$ip = mysql_escape_string($REMOTE_ADDR);
	$uri = mysql_escape_string($REQUEST_URI); 
	$user_agent = mysql_escape_string($HTTP_USER_AGENT); 
	$referer = mysql_escape_string($HTTP_REFERER); 

	mysql_query("INSERT INTO access_log 
		(ip,uri,user_agent,uid,referer) VALUES
		('$ip','$uri','$user_agent',$uid,'$referer')") or die(mysql_error());
?>