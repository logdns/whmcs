{include file="$template/pageheader.tpl" title=$LANG.contacttitle desc=$LANG.contactheader}

{if $sent}

<br />

<div class="alert alert-success textcenter">
    <p><strong>{$LANG.contactsent}</strong></p>
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

<form method="post" action="contact.php?action=send" class="form-stacked center95">

    <fieldset class="control-group">

	    <div class="row">
            <div class="multicol">
                <div class="control-group">
        		    <label class="control-label bold" for="name">{$LANG.supportticketsclientname}</label>
        			<div class="controls">
        			    <input class="input-xlarge" type="text" name="name" id="name" value="{$name}" />
        			</div>
        		</div>
        	</div>
            <div class="multicol">
                <div class="control-group">
        		    <label class="control-label bold" for="email">{$LANG.supportticketsclientemail}</label>
        			<div class="controls">
        			    <input class="input-xlarge" type="text" name="email" id="email" value="{$email}" />
        			</div>
        		</div>
        	</div>
        </div>

        <div class="row">
    	    <div class="control-group">
    		    <label class="control-label bold" for="subject">{$LANG.supportticketsticketsubject}</label>
    			<div class="controls">
    			    <input class="input-xlarge" type="text" name="subject" id="subject" value="{$subject}" style="width:80%;" />
    			</div>
    		</div>
		</div>

        <div class="control-group">
		    <label class="control-label bold" for="message">{$LANG.contactmessage}</label>
			<div class="controls">
			    <textarea name="message" id="message" rows="12" class="fullwidth">{$message}</textarea>
			</div>
		</div>

    </fieldset>

{if $capatacha}
<p><strong>&nbsp;&raquo;&nbsp;{$LANG.captchatitle}</strong></p>
<p>{$LANG.captchaverify}</p>
{if $capatacha eq "recaptcha"}
<div align="center">{$recapatchahtml}</div>
{else}
<p align="center"><img src="includes/verifyimage.php" align="middle" /> <input type="text" class="input-small" name="code" size="10" maxlength="5" /></p>
{/if}
{/if}

    <p align="center"><input type="submit" value="{$LANG.contactsend}" class="btn btn-primary" /></p>

</form>

{/if}

<br />
<br />
<br />