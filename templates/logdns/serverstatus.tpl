{include file="$template/pageheader.tpl" title=$LANG.networkstatustitle desc=$LANG.networkstatusintro}

<div class="alert alert-block alert-warning">
<p class="textcenter fontsize3">
<a href="{$smarty.server.PHP_SELF}?view=open" class="networkissuesopen">{$opencount} {$LANG.networkissuesstatusopen}</a> &nbsp;&nbsp;&nbsp;&nbsp;
<a href="{$smarty.server.PHP_SELF}?view=scheduled" class="networkissuesscheduled">{$scheduledcount} {$LANG.networkissuesstatusscheduled}</a> &nbsp;&nbsp;&nbsp;&nbsp;
<a href="{$smarty.server.PHP_SELF}?view=resolved" class="networkissuesclosed">{$resolvedcount} {$LANG.networkissuesstatusresolved}</a>
</p>
</div>

{foreach from=$issues item=issue}

{if $issue.clientaffected}<div class="alert-message block-message alert-warning">{/if}

    <h3>{$issue.title} ({$issue.status})</h3>
    <p><strong>{$LANG.networkissuesaffecting} {$issue.type}</strong> - {if $issue.type eq $LANG.networkissuestypeserver}{$issue.server}{else}{$issue.affecting}{/if} | <strong>{$LANG.networkissuespriority}</strong> - {$issue.priority}</span></p>
    <br />
    <blockquote>
    {$issue.description}
    </blockquote>
    <p><strong>{$LANG.networkissuesdate}</strong> - {$issue.startdate}{if $issue.enddate} - {$issue.enddate}{/if}</p>
    <p><strong>{$LANG.networkissueslastupdated}</strong> - {$issue.lastupdate}</p>

{if $issue.clientaffected}</div>{/if}

{foreachelse}

<p class="textcenter"><strong>{$noissuesmsg}</strong></p>

{/foreach}

<div class="pagination">
    <ul>
        <li class="prev{if !$prevpage} disabled{/if}"><a href="{if $prevpage}{$smarty.server.PHP_SELF}?{if $view}view={$view}&amp;{/if}page={$prevpage}{else}javascript:return false;{/if}">&larr; {$LANG.previouspage}</a></li>
        <li class="next{if !$nextpage} disabled{/if}"><a href="{if $nextpage}{$smarty.server.PHP_SELF}?{if $view}view={$view}&amp;{/if}page={$nextpage}{else}javascript:return false;{/if}">{$LANG.nextpage} &rarr;</a></li>
    </ul>
</div>

{if $servers}

{include file="$template/subheader.tpl" title=$LANG.serverstatustitle}

<p>{$LANG.serverstatusheadingtext}</p>

<br />

{literal}
<script>
function getStats(num) {
    jQuery.post('serverstatus.php', 'getstats=1&num='+num, function(data) {
        jQuery("#load"+num).html(data.load);
        jQuery("#uptime"+num).html(data.uptime);
    },'json');
}
function checkPort(num,port) {
    jQuery.post('serverstatus.php', 'ping=1&num='+num+'&port='+port, function(data) {
        jQuery("#port"+port+"_"+num).html(data);
    });
}
</script>
{/literal}

<div class="center80">

<table class="table table-striped table-framed">
    <thead>
        <tr>
            <th>{$LANG.servername}</th>
            <th class="textcenter">HTTP</th>
            <th class="textcenter">FTP</th>
            <th class="textcenter">POP3</th>
            <th class="textcenter">{$LANG.serverstatusphpinfo}</th>
            <th class="textcenter">{$LANG.serverstatusserverload}</th>
            <th class="textcenter">{$LANG.serverstatusuptime}</th>
        </tr>
    </thead>
    <tbody>
{foreach from=$servers key=num item=server}
        <tr>
            <td>{$server.name}</td>
            <td class="textcenter" id="port80_{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /></td>
            <td class="textcenter" id="port21_{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /></td>
            <td class="textcenter" id="port110_{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /></td>
            <td class="textcenter"><a href="{$server.phpinfourl}" target="_blank">{$LANG.serverstatusphpinfo}</a></td>
            <td class="textcenter" id="load{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /></td>
            <td class="textcenter" id="uptime{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /><script> checkPort({$num},80); checkPort({$num},21); checkPort({$num},110); getStats({$num}); </script></td>
        </tr>
{foreachelse}
        <tr>
            <td colspan="7">{$LANG.serverstatusnoservers}</td>
        </tr>
{/foreach}
    </tbody>
</table>

</div>

{/if}

{if $loggedin}<p>{$LANG.networkissuesaffectingyourservers}</p>{/if}

<br />
<p align="right"><img src="images/rssfeed.gif" alt="RSS" align="absmiddle" /> <a href="networkissuesrss.php">{$LANG.announcementsrss}</a></p>
<br />