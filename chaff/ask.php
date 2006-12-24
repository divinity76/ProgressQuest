<?
	if (isset($message)) {
		mail("lesterbarion@yahoo.com", 
				 "Ask!", 
         $message,
				 "From: asked@bigretard.com") or die("bad");
		header("Location: ask.php?sent=1");
		exit();
	}
?>
<html>

<body>

<? if ($sent): ?>
	Your message was sent, it seems.
<? endif; ?>

<form>
Q: <textarea name=message rows=5 cols=60></textarea>
<p>
<input type=submit value=Send>

</body>
</html>