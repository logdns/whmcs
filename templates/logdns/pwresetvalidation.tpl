{include file="$template/pageheader.tpl" title=$LANG.pwreset}

{if $invalidlink}

  <div class="alert alert-error">
    <p class="textcenter">{$invalidlink}</p>
  </div>
  <br /><br /><br /><br />

{elseif $success}

  <br />
  <div class="alert alert-success">
    <p class="textcenter bold">{$LANG.pwresetvalidationsuccess}</p>
  </div>

  <p class="textcenter">{$LANG.pwresetsuccessdesc|sprintf2:'<a href="clientarea.php">':'</a>'}</p>

  <br /><br /><br /><br />

{else}

{if $errormessage}

  <div class="alert alert-error">
    <p class="textcenter">{$errormessage}</p>
  </div>

{/if}

<form class="form-horizontal" method="post" action="{$smarty.server.PHP_SELF}?action=pwreset">
<input type="hidden" name="key" id="key" value="{$key}" />

<br /><h4>{$LANG.pwresetenternewpw}</h4><br />

  <fieldset class="onecol">

    <div class="control-group">
	    <label class="control-label" for="password">{$LANG.newpassword}</label>
		<div class="controls">
		    <input type="password" name="newpw" id="password" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="confirmpw">{$LANG.confirmnewpassword}</label>
		<div class="controls">
		    <input type="password" name="confirmpw" id="confirmpw" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="passstrength">{$LANG.pwstrength}</label>
		<div class="controls">
            {include file="$template/pwstrength.tpl"}
		</div>
	</div>

  </fieldset>

  <div class="form-actions">
    <input class="btn btn-primary" type="submit" name="submit" value="{$LANG.clientareasavechanges}" />
    <input class="btn" type="reset" value="{$LANG.cancel}" />
  </div>

</form>

{/if}

</div>