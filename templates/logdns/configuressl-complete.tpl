{if $errormessage}

{include file="$template/pageheader.tpl" title=$LANG.sslconfsslcertificate}

<div class="alert alert-error">
    <p class="bold">{$LANG.clientareaerrors}</p>
    <ul>
        {$errormessage}
    </ul>
</div>

<p><input type="button" value="{$LANG.clientareabacklink}" class="btn" onclick="history.go(-1)" /></p>

{else}

{include file="$template/pageheader.tpl" title=$LANG.sslconfigcomplete}

<p>{$LANG.sslconfigcompletedetails}</p>

<br />

<form method="post" action="clientarea.php?action=productdetails">
<input type="hidden" name="id" value="{$serviceid}" />
<p><input type="submit" value="{$LANG.invoicesbacktoclientarea}" class="btn"/></p>
 </form>

{/if}

<br />
<br />
<br />