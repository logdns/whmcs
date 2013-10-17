{include file="http://apps.qiniudn.com/whmcs-theme/simple-i/pageheader.tpl" title=$LANG.newsletterunsubscribe}

<br />

<div class="halfwidthcontainer">

    {if $successful}
    <div class="alert alert-success">
        <p class="textcenter bold">{$LANG.unsubscribesuccess}</p>
    </div>
    <p class="textcenter">{$LANG.newsletterremoved}</p>
    {/if}

    {if $errormessage}
    <div class="alert alert-error">
        <p class="textcenter bold">{$LANG.erroroccured}</p>
    </div>
    <p class="textcenter">{$errormessage}</p>
    {/if}

    <p class="textcenter">{$LANG.newsletterresubscribe|sprintf2:'<a href="clientarea.php?action=details">':'</a>'}</p>

</div>

<br /><br /><br /><br />