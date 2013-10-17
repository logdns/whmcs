<div class="halfwidthcontainer">

{include file="$template/pageheader.tpl" title=$LANG.accessdenied}

<p>{$LANG.bannedyourip} {$ip} {$LANG.bannedhasbeenbanned}</p>

<br />

<div class="alert alert-error">
    <ul>
        <li>{$LANG.bannedbanreason}: <strong>{$reason}</strong></li>
    	<li>{$LANG.bannedbanexpires}: {$expires}</li>
    </ul>
</div>

<br />
<br />
<br />
<br />

</div>