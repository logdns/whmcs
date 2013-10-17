{include file="$template/pageheader.tpl" title=$LANG.domaindnsmanagement}

<div class="alert alert-block alert-info">
    <p>{$LANG.domainname}: <strong>{$domain}</strong></p>
</div>

<p>{$LANG.domaindnsmanagementdesc}</p>

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

<form class="form-horizontal" method="post" action="{$smarty.server.PHP_SELF}?action=domaindns">
<input type="hidden" name="sub" value="save" />
<input type="hidden" name="domainid" value="{$domainid}" />

<div class="center80">
<table class="table table-striped table-framed">
    <thead>
        <tr>
            <th class="textcenter">{$LANG.domaindnshostname}</th>
            <th class="textcenter">{$LANG.domaindnsrecordtype}</th>
            <th class="textcenter">{$LANG.domaindnsaddress}</th>
            <th class="textcenter">{$LANG.domaindnspriority}</th>
        </tr>
    </thead>
    <tbody>
{foreach from=$dnsrecords item=dnsrecord}
        <tr>
            <td><input type="hidden" name="dnsrecid[]" value="{$dnsrecord.recid}" /><input type="text" name="dnsrecordhost[]" value="{$dnsrecord.hostname}" size="10" class="input-small" /></td>
            <td><select name="dnsrecordtype[]">
<option value="A"{if $dnsrecord.type eq "A"} selected="selected"{/if}>A (Address)</option>
<option value="AAAA"{if $dnsrecord.type eq "AAAA"} selected="selected"{/if}>AAAA (Address)</option>
<option value="MXE"{if $dnsrecord.type eq "MXE"} selected="selected"{/if}>MXE (Mail Easy)</option>
<option value="MX"{if $dnsrecord.type eq "MX"} selected="selected"{/if}>MX (Mail)</option>
<option value="CNAME"{if $dnsrecord.type eq "CNAME"} selected="selected"{/if}>CNAME (Alias)</option>
<option value="TXT"{if $dnsrecord.type eq "TXT"} selected="selected"{/if}>SPF (txt)</option>
<option value="URL"{if $dnsrecord.type eq "URL"} selected="selected"{/if}>URL Redirect</option>
<option value="FRAME"{if $dnsrecord.type eq "FRAME"} selected="selected"{/if}>URL Frame</option>
</select></td>
            <td><input type="text" name="dnsrecordaddress[]" value="{$dnsrecord.address}" size="40" /></td>
            <td>{if $dnsrecord.type eq "MX"}<input type="text" name="dnsrecordpriority[]" value="{$dnsrecord.priority}" size="2" class="input-small" />*{else}<input type="hidden" name="dnsrecordpriority[]" value="N/A" />{$LANG.domainregnotavailable}{/if}</td>
        </tr>
{/foreach}
        <tr>
            <td><input type="text" name="dnsrecordhost[]" size="10" class="input-small" /></td>
            <td><select name="dnsrecordtype[]">
<option value="A">A (Address)</option>
<option value="AAAA">AAAA (Address)</option>
<option value="MXE">MXE (Mail Easy)</option>
<option value="MX">MX (Mail)</option>
<option value="CNAME">CNAME (Alias)</option>
<option value="TXT">SPF (txt)</option>
<option value="URL">URL Redirect</option>
<option value="FRAME">URL Frame</option>
</select></td>
            <td><input type="text" name="dnsrecordaddress[]" size="40" /></td>
            <td><input type="text" name="dnsrecordpriority[]" size="2" class="input-small" />*</td>
        </tr>
    </tbody>
</table>
</div>

<p align="center">* {$LANG.domaindnsmxonly}</p>

<p align="center"><input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-primary" /></p>

</form>

{/if}

<form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
<input type="hidden" name="id" value="{$domainid}" />
<p><input type="submit" value="{$LANG.clientareabacklink}" class="btn" /></p>
</form>