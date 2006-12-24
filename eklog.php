<?php

###########################################################################
# configuration
###########################################################################

# main script path & script URL
$script_path = '/usr/home/uhomeu2/elton99/php-bin/eklog';
$script_url  = 'http://elton99.uhome.net/php-bin/eklog/eklog.php';

# last-visit, count & log data files
$vst_file = "$script_path/visit.txt";
$cnt_file = "$script_path/count.txt";
$log_file = "$script_path/log.txt";

###########################################################################

# IP addresses to be excluded in access log (can exclude a whole sub-net)
# white IPs have access to all statistics
# black IPs have no access to any data
# e.g. $white_ip_list = array('xxx.xxx.xxx.xxx', 'yyy.yyy.yyy');
$white_ip_list = array();
$black_ip_list = array();

# length of time (minutes) before consecutive hits from an IP are counted
# use 0 to disable anti-reload feature
$anti_reload_period = 60;

###########################################################################

# count visible?
$visible_count = 1;

# show count digits as
# 0 - text
# 1 - images
$digit_type = 1;

# absolute number of digits to display
# (used when $digit_length >= count_digit_length)
$digit_length = 0;

# number of zeroes to prefix the count
# (used when $digit_length < count_digit_length)
$digit_pad = 1;

# show digits in what language?
# (used when showing digits as text)
$arabic_count  = 1;
$chinese_count = 0;
$roman_count   = 0;

if ($arabic_count) {
  $bold      = 0;
  $italic    = 0;
  $cnt_color = '#ff0000';
  $cnt_face  = 'Comic Sans MS';
  $cnt_size  = '+1';
} elseif ($chinese_count) {
  $bold      = 1;
  $italic    = 0;
  $cnt_color = '#ff0000';
  $cnt_face  = '';
  $cnt_size  = '+1';
} elseif ($roman_count) {
  $bold      = 0;
  $italic    = 0;
  $cnt_color = '#ff0000';
  $cnt_face  = 'Comic Sans MS';
  $cnt_size  = '+1';
}

# digit images directory name & file extension
# directory can use absolute or relative path
# absolute paths start with "http://", "https://" or "/"
# all other paths are considered relative (to main script directory)
# (used when showing digits as images)
$img_dir = 'digit';
$img_ext = 'gif';

# individual digit image width & height
$img_width  = 16;
$img_height = 21;

# digit images text alignment
# e.g. absmiddle, top, middle, bottom
$img_align = 'absmiddle';

###########################################################################

# statistics visible?
$visible_stat = 1;

# statistics page window name
# use empty string for same window (as count page)
$stat_frame = '_blank';

# statistics summary visible?
# statistics detail visible?
$summary_stat = 1;
$detail_stat  = 1;

# statistics background colours
$back_col_type = 'yellow';
$back_col_head = 'lightblue';
$back_col_body = 'lightcyan';

###########################################################################
# main programme
###########################################################################

$agent_stat = array();

# create initial data files during first run
if (! file_exists($vst_file)) {
  $vst_fp = fopen($vst_file, 'w') or die("Can't open $vst_file\n");
  flock($vst_fp, 2);
  fwrite($vst_fp, '0.0.0.0|0');
  fclose($vst_fp);
}

if (! file_exists($cnt_file)) {
  $cnt_fp = fopen($cnt_file, 'w') or die("Can't open $cnt_file\n");
  flock($cnt_fp, 2);
  fwrite($cnt_fp, '0');
  fclose($cnt_fp);
}

# run script
if (getenv('QUERY_STRING') == '') {
  takeLog();                                     # take log
} elseif (strtolower(getenv('QUERY_STRING')) == 'stat') {
  viewStat();                                    # view statistics
} else {
  # exit when script is called with invalid parameter
  print '[parameter invalid]';
}

###########################################################################
# functions
###########################################################################

function takeLog() {
  global $script_url, $vst_file, $cnt_file, $log_file;
  global $visible_count;
  global $digit_type, $digit_length, $digit_pad;
  global $arabic_count, $chinese_count, $roman_count;
  global $bold, $italic, $cnt_color, $cnt_face, $cnt_size;
  global $img_dir, $img_ext, $img_width, $img_height, $img_align;
  global $visible_stat, $stat_frame;

  # do access log
  if (handleListedIP() || isReload()) {          # no logging needed
    $cnt_fp = fopen($cnt_file, 'r') or die("Can't open $cnt_file\n");
    $cnt = fread($cnt_fp, filesize($cnt_file));
    $cnt = chop($cnt);
    fclose($cnt_fp);
  } else {                                       # logging needed
    # process last-visit data
    $vst_fp = fopen($vst_file, 'w') or die("Can't open $vst_file\n");
    flock($vst_fp, 2);
    $tm = time();
    fwrite($vst_fp, getenv('REMOTE_ADDR')."|$tm");
    fclose($vst_fp);

    # process count data
    $cnt_fp = fopen($cnt_file, 'r+') or die("Can't open $cnt_file\n");
    flock($cnt_fp, 2);
    $cnt = fread($cnt_fp, filesize($cnt_file));
    $cnt = chop($cnt);
    $cnt++;
    rewind($cnt_fp);
    fwrite($cnt_fp, $cnt);
    ftruncate($cnt_fp, ftell($cnt_fp));
    fclose($cnt_fp);

    # process log data
    $log_fp = fopen($log_file, 'a') or die("Can't open $log_file\n");
    flock($log_fp, 2);

    $aTime   = localtime($tm, 1);
    $iY      = $aTime['tm_year']+1900;
    $iM      = $aTime['tm_mon']+1;
    $iM      = ($iM>=10?$iM:"0$iM");
    $iD      = $aTime['tm_mday'];
    $iD      = ($iD>=10?$iD:"0$iD");
    $iHH     = $aTime['tm_hour'];
    $iHH     = ($iHH>=10?$iHH:"0$iHH");
    $iMM     = $aTime['tm_min'];
    $iMM     = ($iMM>=10?$iMM:"0$iMM");
    $iSS     = $aTime['tm_sec'];
    $iSS     = ($iSS>=10?$iSS:"0$iSS");
    $logTime = "$iY-$iM-$iD $iHH:$iMM:$iSS";

    if (gethostbyaddr(getenv('REMOTE_ADDR'))) {
      $logHost = gethostbyaddr(getenv('REMOTE_ADDR'));
    } else {
      $logHost = '[Unknown]';
    }

    if (getenv('HTTP_USER_AGENT')) {
      $logAgent = getenv('HTTP_USER_AGENT');
    } else {
      $logAgent = '[Unknown]';
    }

    fwrite($log_fp, "$logTime|$logHost|$logAgent\n");
    fclose($log_fp);
  }

  # show output
  $html_out = '';

  if ($visible_count) {
    # pad zero(es) to the count
    # (used when showing text digits in Arabic or image digits)
    if (($digit_type == 0) && $arabic_count || ($digit_type == 1)) {
      if ($digit_length >= strlen($cnt)) { $digit_pad = $digit_length - strlen($cnt); }
      for ($i=0; $i<$digit_pad; $i++) { $cnt = '0' . $cnt; }
    }

    if ($digit_type == 0) {
      if (! $arabic_count) {
        if ($chinese_count) {
          $cnt = arabic2chinese($cnt);
        } elseif ($roman_count) {
          $cnt = arabic2roman($cnt);
        }
      }
    } elseif ($digit_type == 1) {
      # check if relative path is used for digit images directory
      if (! preg_match('@^(http://|https://|/)@', $img_dir)) {
        $img_url = preg_replace('@(.*)/.*@', '\\1', $script_url);
        $img_dir = "$img_url/$img_dir";
      }
    }

    if ($visible_stat) {
      if ($stat_frame) {
        # show statistics page in given window
        $html_out .= "<a href=\"${script_url}?stat\" target=\"${stat_frame}\">";
      } else {
        # show statistics page in same window
        $html_out .= "<a href=\"${script_url}?stat\">";
      }
    }
    if ($digit_type == 0) {
      # show count as text
      if ($cnt_color || $cnt_face || $cnt_size) { $html_out .= '<font'; }
      if ($cnt_color) { $html_out .= " color=\"$cnt_color\""; }
      if ($cnt_face)  { $html_out .= " face=\"$cnt_face\""; }
      if ($cnt_size)  { $html_out .= " size=\"$cnt_size\""; }
      if ($cnt_color || $cnt_face || $cnt_size) { $html_out .= '>'; }
      if ($bold)   { $html_out .= '<b>'; }
      if ($italic) { $html_out .= '<i>'; }
      $html_out .= $cnt;
      if ($italic) { $html_out .= '</i>'; }
      if ($bold)   { $html_out .= '</b>'; }
      if ($cnt_color || $cnt_face || $cnt_size) { $html_out .= '</font>'; }
    } elseif ($digit_type == 1) {
      # show count as image
      for ($i=0; $i<strlen($cnt); $i++) {
        $html_out .= "<img src=\"$img_dir/$cnt[$i].$img_ext\"";
        if ($img_width && $img_height) { $html_out .= " width=$img_width height=$img_height"; }
        if ($img_align) { $html_out .= " align=$img_align"; }
        $html_out .= ' border=0>';
      }
    }
    if ($visible_stat) { $html_out .= '</a>'; }
  }

  print $html_out;
}

function viewStat() {
  global $cnt_file, $log_file;
  global $visible_stat;
  global $summary_stat, $detail_stat;
  global $back_col_type, $back_col_head, $back_col_body;
  global $agent_stat;

  # user-defined sort function
  function doSort ($a, $b) {
    global $agent_stat;

    if ($agent_stat[$a] > $agent_stat[$b]) {
      return(-1);
    } elseif ($agent_stat[$a] < $agent_stat[$b]) {
      return(1);
    } else {
      if ($a > $b) {
        return(-1);
      } elseif ($a < $b) {
        return(1);
      } else {
        return(0);
      }
    }
  }

  # handle listed ip
  handleListedIP();

  # return if no stat or stat invisible
  if ((! file_exists($log_file)) || !$visible_stat || !$summary_stat && !$detail_stat) {
    print '[statistics not available]';
    return(0);
  }

  # get count file data
  $cnt_fp = fopen($cnt_file, 'r') or die("Can't open $cnt_file\n");
  $cnt_no = fread($cnt_fp, filesize($cnt_file));
  $cnt_no = chop($cnt_no);
  fclose($cnt_fp);

  # get log file data
  $log_fp = fopen($log_file, 'r') or die("Can't open $log_file\n");
  for ($log_no=0; ! feof($log_fp); $log_no++) {
    $tmp            = preg_split('/\|/', fgets($log_fp, 256));
    $time[$log_no]  = $tmp[0];
    $host[$log_no]  = $tmp[1];
    $agent[$log_no] = chop($tmp[2]);

    if ($agent[$log_no]) { $agent_stat[$agent[$log_no]]++; }
  }
  $log_no--;
  fclose($log_fp);

  # get count offset
  $off_no = $cnt_no - $log_no;

  # output stat report
  print "<HTML>\n\n";
  print "<HEAD><TITLE>Statistics</TITLE></HEAD>\n\n";
  print "<BODY>\n";

  if ($summary_stat) {
    print "<TABLE BGCOLOR=$back_col_type BORDER=1 CELLPADDING=4 CELLSPACING=2 WIDTH=\"100%\">\n";
    print "<TR><TH><BIG>Log Summary</BIG></TH></TR>\n";
    print "</TABLE>\n";
    print "<BR>\n";
    print "<TABLE ALIGN=CENTER BGCOLOR=$back_col_body BORDER=1 CELLPADDING=2 CELLSPACING=2>\n";
    print "<TR BGCOLOR=$back_col_head>\n";
    print "<TH ALIGN=LEFT>Agent</TH>\n";
    print "<TH>Count</TH>\n";
    print "</TR>\n";

    $agent_stat_keys = array_keys($agent_stat);
    usort($agent_stat_keys, "doSort");
    foreach ($agent_stat_keys as $key) {
      print "<TR>\n";
      print "<TD>$key</TD>\n";
      print "<TD ALIGN=CENTER>$agent_stat[$key]</TD>\n";
      print "</TR>\n";
    }

    print "<TR BGCOLOR=$back_col_head>\n";
    print "<TH ALIGN=LEFT>Total</TH>\n";
    print "<TH>$log_no</TH>\n";
    print "</TR>\n";
    print "</TABLE>\n\n";
  }

  if ($summary_stat && $detail_stat) { print "<BR><BR><BR>\n\n"; }

  if ($detail_stat) {
    print "<TABLE BGCOLOR=$back_col_type BORDER=1 CELLPADDING=4 CELLSPACING=2 WIDTH=\"100%\">\n";
    print "<TR><TH><BIG>Log Detail</BIG></TH></TR>\n";
    print "</TABLE>\n";
    print "<BR>\n";
    print "<TABLE ALIGN=CENTER BGCOLOR=$back_col_body BORDER=1 CELLPADDING=2 CELLSPACING=2>\n";
    print "<TR BGCOLOR=$back_col_head>\n";
    print "<TD>&nbsp;</TD>\n";
    print "<TH ALIGN=LEFT>Time</TH>\n";
    print "<TH ALIGN=LEFT>Host</TH>\n";
    print "<TH ALIGN=LEFT>Agent</TH>\n";
    print "</TR>\n";
    for ($i=0; $i<$log_no; $i++) {
      print  "<TR>\n";
      printf("<TD ALIGN=RIGHT BGCOLOR=$back_col_head>%d</TD>\n", $i+1+$off_no);
      print  "<TD>$time[$i]</TD>\n";
      print  "<TD>$host[$i]</TD>\n";
      print  "<TD>$agent[$i]</TD>\n";
      print  "</TR>\n";
    }
    print "</TABLE>\n";
  }

  print "</BODY>\n\n";
  print "</HTML>\n";
}

function handleListedIP() {
  global $white_ip_list, $black_ip_list;
  global $visible_count, $visible_stat, $summary_stat, $detail_stat;

  $this_ip = getenv('REMOTE_ADDR') . '.';

  foreach ($white_ip_list as $ip) {
    if (preg_match("/^$ip\./", $this_ip)) {
      # override default for white-listed ip
      $visible_count = 1;
      $visible_stat  = 1;
      $summary_stat  = 1;
      $detail_stat   = 1;

      return(1);
    }
  }

  foreach ($black_ip_list as $ip) {
    if (preg_match("/^$ip\./", $this_ip)) {
      # override default for black-listed ip
      $visible_count = 0;
      $visible_stat  = 0;
      $summary_stat  = 0;
      $detail_stat   = 0;

      return(2);
    }
  }

  return(0);
}

function isReload() {
  global $vst_file;
  global $anti_reload_period;

  $vst_fp = fopen($vst_file, 'r') or die("Can't open $vst_file\n");
  $vst = preg_split('/\|/', fread($vst_fp, filesize($vst_file)));
  $ip_last = $vst[0];
  $tm_last = chop($vst[1]);
  fclose($vst_fp);

  $tm_now   = time();
  $min_diff = ($tm_now-$tm_last)/60;

  # return true if current IP is the same as last IP and within anti-reload
  # period
  if ((getenv('REMOTE_ADDR')==$ip_last)&&($min_diff<=$anti_reload_period)) {
    return(1);
  } else {
    return(0);
  }
}

function arabic2chinese($in) {
  $d  = '零';
  $mm = array('','萬','億','兆');

  # return 0 if input is all 0
  if (! intval($in)) { return($d); }

  # construct chinese characters, in groups of 4 digits from the right
  for ($i=0,$s='',$out=''; $i<strlen($in); $i+=4) {
    if (($i+4) <= strlen($in)) {
      $s = substr($in,-($i+4),4);
    } elseif (($i+3) == strlen($in)) {
      $s = substr($in,-($i+3),3);
    } elseif (($i+2) == strlen($in)) {
      $s = substr($in,-($i+2),2);
    } else {
      $s = substr($in,-($i+1),1);
    }

    if (intval($s)) {
      # append 0 between groups if it's not first loop, and either rightmost
      # digit of current group or leftmost digit of previous group is 0, and
      # digits of previous group are not all 0's
      $j = (($i)&&((substr($s,-1,1)=='0')||(substr($in,-$i,1)=='0'))&&intval(substr($in,-$i))?$d:'');

      # append current group, with corresponding multiple
      $out = chineseQuadruple($s) . $mm[$i/4] . $j . $out;
    }
  }

  return($out);
}

function chineseQuadruple($in) {
  $d = array('零','一','二','三','四','五','六','七','八','九');
  $m = array('千','百','十','');

  # return 0 if input is all 0
  if (! intval($in)) { return($d[0]); }

  for ($i=-strlen($in),$out=''; $i<=-1; $i++) {
    if (substr($in,$i,1)) {
      # append current digit (1-9), with corresponding multiple
      $out .= $d[substr($in,$i,1)] . $m[$i+count($m)];
    } else {
      # break loop if all remaining digits are 0's
      if (! intval(substr($in,$i))) { break; }

      # append 0 if previous digit is not 0 or null
      if (substr($in,$i-1,1)) { $out .= $d[0]; }
    }
  }

  return($out);
}

function arabic2roman($in) {
  $r1   = array('I','II','III','IV','V','VI','VII','VIII','IX');
  $r10  = array('X','XX','XXX','XL','L','LX','LXX','LXXX','XC');
  $r100 = array('C','CC','CCC','CD','D','DC','DCC','DCCC','CM');

  # get arabic digits
  $a1    = $in%10;
  $in    = ($in-$a1)/10;
  $a10   = $in%10;
  $in    = ($in-$a10)/10;
  $a100  = $in%10;
  $a1000 = ($in-$a100)/10;

  # construct roman numerals
  for ($i=0,$out=''; $i<$a1000; $i++) { $out .= 'M'; }
  if ($a100) { $out .= $r100[$a100-1]; }
  if ($a10)  { $out .= $r10[$a10-1]; }
  if ($a1)   { $out .= $r1[$a1-1]; }

  return($out);
}

?>
