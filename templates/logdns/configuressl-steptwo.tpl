{include file="$template/pageheader.tpl" title=$LANG.sslconfsslcertificate}

{if $errormessage}
<div class="alert alert-error">
    <p class="bold">{$LANG.clientareaerrors}</p>
    <ul>
        {$errormessage}
    </ul>
</div>
{/if}

{include file="$template/subheader.tpl" title=$LANG.sslcertinfo}

<div class="row">
<div class="col2half">
    <p><h4>{$LANG.sslcerttype}:</h4> {$certtype}</p>
</div>
<div class="col2half">
    <p><h4>{$LANG.sslorderdate}:</h4> {$date}</p>
</div>
{if $domain}<div class="col2half">
    <p><h4>{$LANG.domainname}:</h4> {$domain}</p>
</div>{/if}
<div class="col2half">
    <p><h4>{$LANG.orderprice}:</h4> {$price}</p>
</div>
<div class="col2half">
    <p><h4>{$LANG.sslstatus}:</h4> {$status}</p>
</div>
{foreach from=$displaydata key=displaydataname item=displaydatavalue}
<div class="col2half">
    <p><h4>{$displaydataname}:</h4> {$displaydatavalue}</p>
</div>
{/foreach}
</div>

<form class="form-horizontal" method="post" action="{$smarty.server.PHP_SELF}?cert={$cert}&step=3">

{include file="$template/subheader.tpl" title=$LANG.sslcertapproveremail}

<p>{$LANG.sslcertapproveremaildetails}</p>
<fieldset>

    <div class="control-group">
	    <label class="full control-label bold" for="servertype">{$LANG.sslcertapproveremail}</label>
		<div class="controls">
            {foreach from=$approveremails item=approveremail key=num}
            <div class="col2half">
            <label class="full control-label"><input type="radio" class="radio inline" name="approveremail" value="{$approveremail}"{if $num eq 0} checked{/if} /> <span>{$approveremail}</span></label>
            </div>
            {/foreach}
		</div>
	</div>

</fieldset>

<p class="textcenter"><input type="submit" value="{$LANG.ordercontinuebutton}" class="btn btn-primary" /></p>

</form>

<br />
<br />
<br />