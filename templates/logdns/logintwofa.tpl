<div class="halfwidthcontainer">

{include file="$template/pageheader.tpl" title=$LANG.twofactorauth}

{if $newbackupcode}
<div class="alert alert-success textcenter">
    <p>{$LANG.twofabackupcodereset}</p>
</div>
{elseif $incorrect}
<div class="alert alert-error textcenter">
    <p>{$LANG.twofa2ndfactorincorrect}</p>
</div>
{elseif $error}
<div class="alert alert-error textcenter">
    <p>{$error}</p>
</div>
{else}
<div class="alert alert-warning textcenter">
    <p>{$LANG.twofa2ndfactorreq}</p>
</div>
{/if}

<form method="post" action="{$systemsslurl}dologin.php" class="form-stacked" id="frmlogin">

{if $newbackupcode}

<input type="hidden" name="newbackupcode" value="1" />
<h2 align="center">{$LANG.twofanewbackupcodeis}</h2>
<div class="alert alert-warning textcenter twofabackupcode">
    <p>{$newbackupcode}</p>
</div>
<p align="center">{$LANG.twofabackupcodeexpl}</p>
<br />
<p align="center"><input type="submit" value="{$LANG.continue} &raquo;" class="btn" /></p>

{elseif $backupcode}

<br />

<input type="hidden" name="backupcode" value="1" />
<p align="center"><input type="text" name="code" size="25" /> <input type="submit" value="Login &raquo;" class="btn" /></p>
<p align="center"></p>

{else}

<br />

{$challenge}

{/if}

<br />

{if !$newbackupcode}
<div class="alert alert-block alert-info textcenter">
{if $backupcode}
{$LANG.twofabackupcodelogin}
{else}
{$LANG.twofacantaccess2ndfactor} <a href="clientarea.php?backupcode=1">{$LANG.twofaloginusingbackupcode}</a></p>
{/if}
</div>
{/if}

</form>

<script type="text/javascript">
$("#frmlogin input:text:visible:first").focus();
</script>

<br /><br /><br /><br />

</div>