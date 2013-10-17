<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>{$companyname} | {$pagetitle} </title>

    <link href="http://apps.qiniudn.com/whmcs-theme/simple-i/bootstrap.css" rel="stylesheet">
    <link href="http://apps.qiniudn.com/whmcs-theme/simple-i/whmcs.css" rel="stylesheet">

  </head>

  <body class="popupwindow">

<h2>{$LANG.whoisresults} {$domain}</h2>

<div class="popupcontainer">
    {$whois}
    <br />
    <br />
</div>

<p class="textcenter"><input type="button" value="{$LANG.closewindow}" class="btn btn-primary" onclick="window.close()" /></p>

  </body>
</html>