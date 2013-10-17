<script type="text/javascript" src="includes/jscript/statesdropdown.js"></script>

{include file="$template/pageheader.tpl" title=$LANG.clientregistertitle desc=$LANG.registerintro}

{if $noregistration}

    <div class="alert alert-error">
        <p>{$LANG.registerdisablednotice}</p>
    </div>

{else}

{if $errormessage}
<div class="alert alert-error">
    <p class="bold">{$LANG.clientareaerrors}</p>
    <ul>
        {$errormessage}
    </ul>
</div>
{/if}

<form class="form-horizontal" method="post" action="{$smarty.server.PHP_SELF}">
<input type="hidden" name="register" value="true" />

<fieldset class="control-group">

<div class="control-group">
<div class="col2half">

    <div class="control-group">
	    <label class="control-label" for="firstname">{$LANG.clientareafirstname}</label>
		<div class="controls">
		    <input type="text" name="firstname" id="firstname" value="{$clientfirstname}"{if in_array('firstname',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="lastname">{$LANG.clientarealastname}</label>
		<div class="controls">
		    <input type="text" name="lastname" id="lastname" value="{$clientlastname}"{if in_array('lastname',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="companyname">{$LANG.clientareacompanyname}</label>
		<div class="controls">
		    <input type="text" name="companyname" id="companyname" value="{$clientcompanyname}"{if in_array('companyname',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="email">{$LANG.clientareaemail}</label>
		<div class="controls">
		    <input type="text" name="email" id="email" value="{$clientemail}"{if in_array('email',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="password">{$LANG.clientareapassword}</label>
		<div class="controls">
		    <input type="password" name="password" id="password" value="{$clientpassword}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="password2">{$LANG.clientareaconfirmpassword}</label>
		<div class="controls">
		    <input type="password" name="password2" id="password2" value="{$clientpassword2}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="passstrength">{$LANG.pwstrength}</label>
		<div class="controls">
            {include file="$template/pwstrength.tpl"}
		</div>
	</div>

</div>
<div class="col2half">

    <div class="control-group">
	    <label class="control-label" for="address1">{$LANG.clientareaaddress1}</label>
		<div class="controls">
		    <input type="text" name="address1" id="address1" value="{$clientaddress1}"{if in_array('address1',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="address2">{$LANG.clientareaaddress2}</label>
		<div class="controls">
		    <input type="text" name="address2" id="address2" value="{$clientaddress2}"{if in_array('address2',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="city">{$LANG.clientareacity}</label>
		<div class="controls">
		    <input type="text" name="city" id="city" value="{$clientcity}"{if in_array('city',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="state">{$LANG.clientareastate}</label>
		<div class="controls">
		    <input type="text" name="state" id="state" value="{$clientstate}"{if in_array('state',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="postcode">{$LANG.clientareapostcode}</label>
		<div class="controls">
		    <input type="text" name="postcode" id="postcode" value="{$clientpostcode}"{if in_array('postcode',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="country">{$LANG.clientareacountry}</label>
		<div class="controls">
		    {$clientcountriesdropdown}
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="phonenumber">{$LANG.clientareaphonenumber}</label>
		<div class="controls">
		    <input type="text" name="phonenumber" id="phonenumber" value="{$clientphonenumber}"{if in_array('phonenumber',$uneditablefields)} disabled="" class="disabled"{/if} />
		</div>
	</div>

</div>
</div>

</fieldset>

<fieldset class="onecol">

{if $currencies}
    <div class="control-group">
	    <label class="control-label" for="currency">{$LANG.choosecurrency}</label>
		<div class="controls" id="currency">
		    <select name="currency">
            {foreach from=$currencies item=curr}
            <option value="{$curr.id}"{if !$smarty.post.currency && $curr.default || $smarty.post.currency eq $curr.id } selected{/if}>{$curr.code}</option>
            {/foreach}
            </select>
		</div>
	</div>
{/if}

{foreach key=num item=customfield from=$customfields}
    <div class="control-group">
	    <label class="control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
		<div class="controls">
		    {$customfield.input} {$customfield.description}
		</div>
	</div>
{/foreach}

{if $securityquestions}
    <div class="control-group">
	    <label class="control-label" for="securityqans">{$LANG.clientareasecurityquestion}</label>
		<div class="controls">
		    <select name="securityqid" id="securityqid">
            {foreach key=num item=question from=$securityquestions}
            	<option value={$question.id}>{$question.question}</option>
            {/foreach}
            </select>
		</div>
	</div>
    <div class="control-group">
	    <label class="control-label" for="securityqans">{$LANG.clientareasecurityanswer}</label>
		<div class="controls">
		    <input type="password" name="securityqans" id="securityqans" />
		</div>
	</div>
{/if}

</fieldset>

{if $capatacha}
<h3>{$LANG.captchatitle}</h3>
<p>{$LANG.captchaverify}</p>
{if $capatacha eq "recaptcha"}
<div align="center">{$recapatchahtml}</div>
{else}
<p align="center"><img src="includes/verifyimage.php" align="middle" /> <input type="text" name="code" size="10" maxlength="5" class="input-small" /></p>
{/if}
{/if}

<br />

{if $accepttos}
<div class="control-group">
    <label id="tosagree"></label>
    <div class="controls">
        <label class="checkbox">
            <input type="checkbox" name="accepttos" id="accepttos" value="on" >
            {$LANG.ordertosagreement} <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a>
        </label>
    </div>
</div>
{/if}

<p align="center"><input class="btn btn-large btn-primary" type="submit" value="{$LANG.clientregistertitle}" /></p>

</form>

{/if}

<br />
<br />