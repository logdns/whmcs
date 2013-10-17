{include file="$template/pageheader.tpl" title=$LANG.domainemailforwarding}

<div class="alert alert-block alert-info">
    <p>{$LANG.domainname}: <strong>{$domain}</strong</p>
</div>

<p>{$LANG.domainemailforwardingdesc}</p>

<br />

{if $error}
<div class="alert alert-error textcenter">
    {$error}
</div>
{/if}

{if $external}

<br /><br />
<div class="textcenter">
{$code}
</div>
<br /><br /><br /><br />

{else}

<form method="post" action="{$smarty.server.PHP_SELF}?action=domainemailforwarding">
<input type="hidden" name="sub" value="save" />
<input type="hidden" name="domainid" value="{$domainid}" />

<div class="center80">
<table class="table table-striped table-framed">
    <thead>
        <tr>
            <th class="textcenter">{$LANG.domainemailforwardingprefix}</th>
            <th></th>
            <th class="textcenter">{$LANG.domainemailforwardingforwardto}</th>
        </tr>
    </thead>
    <tbody>
{foreach key=num item=emailforwarder from=$emailforwarders}
        <tr>
            <td class="textcenter"><input type="text" name="emailforwarderprefix[{$num}]" value="{$emailforwarder.prefix}" size="15" /></td>
            <td class="textcenter">@{$domain} => </td>
            <td class="textcenter"><input type="text" name="emailforwarderforwardto[{$num}]" value="{$emailforwarder.forwardto}" size="35" /></td>
        </tr>
{/foreach}
        <tr>
            <td class="textcenter"><input type="text" name="emailforwarderprefixnew" size="15" /></td>
            <td class="textcenter">@{$domain} => </td>
            <td class="textcenter"><input type="text" name="emailforwarderforwardtonew" size="35" /></td>
        </tr>
    </tbody>
</table>
</div>

<p align="center"><input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-primary" /></p>

</form>

{/if}

<form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
<input type="hidden" name="id" value="{$domainid}" />
<p><input type="submit" value="{$LANG.clientareabacklink}" class="btn" /></p>
</form>