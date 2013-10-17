{literal}
<script language="javascript">
function usedefaultwhois(id) {
	jQuery("."+id.substr(0,id.length-1)+"customwhois").attr("disabled", true);
	jQuery("."+id.substr(0,id.length-1)+"defaultwhois").attr("disabled", false);
	jQuery('#'+id.substr(0,id.length-1)+'1').attr("checked", "checked");
}
function usecustomwhois(id) {
	jQuery("."+id.substr(0,id.length-1)+"customwhois").attr("disabled", false);
	jQuery("."+id.substr(0,id.length-1)+"defaultwhois").attr("disabled", true);
	jQuery('#'+id.substr(0,id.length-1)+'2').attr("checked", "checked");
}
</script>
{/literal}

{include file="$template/pageheader.tpl" title=$LANG.domaincontactinfo}

<div class="alert alert-block alert-info">
    <p>{$LANG.domainname}: <strong>{$domain}</strong></p>
</div>

{if $successful}
<div class="alert alert-success">
    <p>{$LANG.changessavedsuccessfully}</p>
</div>
{/if}

{if $error}
    <div class="alert alert-error">
        <p class="bold textcenter">{$error}</p>
    </div>
{/if}

<form method="post" action="{$smarty.server.PHP_SELF}?action=domaincontacts" class="form-horizontal">

<input type="hidden" name="sub" value="save" />
<input type="hidden" name="domainid" value="{$domainid}" />

{foreach from=$contactdetails name=contactdetails key=contactdetail item=values}

<h3><a name="{$contactdetail}"></a>{$contactdetail}{if $smarty.foreach.contactdetails.first}{foreach from=$contactdetails name=contactsx key=contactdetailx item=valuesx}{if !$smarty.foreach.contactsx.first} - <a href="clientarea.php?action=domaincontacts&domainid={$domainid}#{$contactdetailx}">{$LANG.jumpto} {$contactdetailx}</a>{/if}{/foreach}{else} - <a href="clientarea.php?action=domaincontacts&domainid={$domainid}#">{$LANG.top}</a>{/if}</h3>

<p><label class="full control-label"><input type="radio" class="radio inline" name="wc[{$contactdetail}]" id="{$contactdetail}1" value="contact" onclick="usedefaultwhois(id)"{if $defaultns} checked{/if} /> {$LANG.domaincontactusexisting}</label></p>

<fieldset class="onecol" id="{$contactdetail}defaultwhois">

    <div class="control-group">
	    <label class="control-label" for="{$contactdetail}3">{$LANG.domaincontactchoose}</label>
		<div class="controls">
		    <select class="{$contactdetail}defaultwhois" name="sel[{$contactdetail}]" id="{$contactdetail}3" onclick="usedefaultwhois(id)">
            <option value="u{$clientsdetails.userid}">{$LANG.domaincontactprimary}</option>
            {foreach key=num item=contact from=$contacts}
            <option value="c{$contact.id}">{$contact.name}</option>
            {/foreach}
          </select>
		</div>
	</div>

</fieldset>

<p><label class="full control-label"><input type="radio" class="radio inline" name="wc[{$contactdetail}]" id="{$contactdetail}2" value="custom" onclick="usecustomwhois(id)"{if !$defaultns} checked{/if} /> {$LANG.domaincontactusecustom}</label></p>

<fieldset class="onecol" id="{$contactdetail}defaultwhois">

{foreach key=name item=value from=$values}
    <div class="control-group">
	    <label class="control-label" for="{$contactdetail}3">{$name}</label>
		<div class="controls">
		    <input type="text" name="contactdetails[{$contactdetail}][{$name}]" value="{$value}" size="30" class="{$contactdetail}customwhois" />
		</div>
	</div>
{/foreach}

</fieldset>

{/foreach}

<p class="textcenter"><input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-primary" /></p>

</form>

<form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
<input type="hidden" name="id" value="{$domainid}" />
<p><input type="submit" value="{$LANG.clientareabacklink}" class="btn" /></p>
</form>