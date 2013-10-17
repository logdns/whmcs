{include file="$template/pageheader.tpl" title=$LANG.accessdenied}

<p>{$LANG.downloadproductrequired}</p>

<div class="alert alert-block alert-info">
<p class="textcenter"><strong>{if $pid}{$prodname}{else}{$addonname}{/if}</strong></p>
</div>

{if $pid}<p class="textcenter"><a href="cart.php?a=add&pid={$pid}">{$LANG.ordernowbutton} &raquo;</a></p>{/if}
{if $aid}<p class="textcenter"><a href="cart.php?gid=addons">{$LANG.ordernowbutton} &raquo;</a></p>{/if}

<br />
<br />
<br />