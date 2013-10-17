<div class="halfwidthcontainer">

{include file="$template/pageheader.tpl" title=$LANG.login}

{if $incorrect}
<div class="alert alert-error textcenter">
    <p>{$LANG.loginincorrect}</p>
</div>
{/if}

<form method="post" action="{$systemsslurl}dologin.php" class="form-stacked">

<div class="logincontainer">

    <fieldset class="control-group">

	    <div class="control-group">
		    <label class="control-label" for="username">{$LANG.loginemail}:</label>
			<div class="controls">
			    <input class="input-xlarge" name="username" id="username" type="text" />
			</div>
		</div>

		<div class="control-group">
		    <label class="control-label" for="password">{$LANG.loginpassword}:</label>
			<div class="controls">
			    <input class="input-xlarge" name="password" id="password" type="password"/>
			</div>
		</div>

        <div align="center">
		  <div class="loginbtn"><input type="submit" class="btn btn-primary btn-large" value="{$LANG.loginbutton}" /></div>
          <div class="rememberme"><input type="checkbox" name="rememberme"{if $rememberme} checked="checked"{/if} /> <strong>{$LANG.loginrememberme}</strong></div>
          <br />
          <br />
          <p><a href="pwreset.php">{$LANG.loginforgotteninstructions}</a></p>
        </div>

	</fieldset>

</div>

</form>

<script type="text/javascript">
$("#username").focus();
</script>

</div>