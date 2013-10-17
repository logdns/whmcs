{include file="$template/pageheader.tpl" title=$LANG.navopenticket}

<script language="javascript">
var currentcheckcontent,lastcheckcontent;
{if $kbsuggestions}
{literal}
function getticketsuggestions() {
    currentcheckcontent = jQuery("#message").val();
    if (currentcheckcontent!=lastcheckcontent && currentcheckcontent!="") {
        jQuery.post("submitticket.php", { action: "getkbarticles", text: currentcheckcontent },
        function(data){
            if (data) {
                jQuery("#searchresults").html(data);
                jQuery("#searchresults").slideDown();
            }
        });
        lastcheckcontent = currentcheckcontent;
	}
    setTimeout('getticketsuggestions();', 3000);
}
getticketsuggestions();
{/literal}
{/if}
</script>

{if $errormessage}
<div class="alert alert-error">
    <p class="bold">{$LANG.clientareaerrors}</p>
    <ul>
        {$errormessage}
    </ul>
</div>
{/if}

<br />

<form name="submitticket" method="post" action="{$smarty.server.PHP_SELF}?step=3" enctype="multipart/form-data" class="center95 form-stacked">

    <fieldset class="control-group">

	    <div class="row">
            <div class="multicol">
                <div class="control-group">
        		    <label class="control-label bold" for="name">{$LANG.supportticketsclientname}</label>
        			<div class="controls">
        			    {if $loggedin}<input class="input-xlarge disabled" type="text" id="name" value="{$clientname}" disabled="disabled" />{else}<input class="input-xlarge" type="text" name="name" id="name" value="{$name}" />{/if}
        			</div>
        		</div>
        	</div>
            <div class="multicol">
                <div class="control-group">
        		    <label class="control-label bold" for="email">{$LANG.supportticketsclientemail}</label>
        			<div class="controls">
        			    {if $loggedin}<input class="input-xlarge disabled" type="text" id="email" value="{$email}" disabled="disabled" />{else}<input class="input-xlarge" type="text" name="email" id="email" value="{$email}" />{/if}
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
        <div class="row">
            <div class="multicol">
                <div class="control-group">
        		    <label class="control-label bold" for="name">{$LANG.supportticketsdepartment}</label>
        			<div class="controls">
        			    <select name="deptid">
                        {foreach from=$departments item=department}
                            <option value="{$department.id}"{if $department.id eq $deptid} selected="selected"{/if}>{$department.name}</option>
                        {/foreach}
                        </select>
        			</div>
        		</div>
    		</div>
{if $relatedservices}
    	     <div class="multicol">
                 <div class="control-group">
        		    <label class="control-label bold" for="relatedservice">{$LANG.relatedservice}</label>
        			<div class="controls">
        			    <select name="relatedservice" id="relatedservice">
                            <option value="">{$LANG.none}</option>
                            {foreach from=$relatedservices item=relatedservice}
                            <option value="{$relatedservice.id}">{$relatedservice.name} ({$relatedservice.status})</option>
                            {/foreach}
                        </select>
        			</div>
        		</div>
    		</div>
{/if}
            <div class="multicol">
        	    <div class="control-group">
        		    <label class="control-label bold" for="priority">{$LANG.supportticketspriority}</label>
        			<div class="controls">
        			    <select name="urgency" id="priority">
                            <option value="High"{if $urgency eq "High"} selected="selected"{/if}>{$LANG.supportticketsticketurgencyhigh}</option>
                            <option value="Medium"{if $urgency eq "Medium" || !$urgency} selected="selected"{/if}>{$LANG.supportticketsticketurgencymedium}</option>
                            <option value="Low"{if $urgency eq "Low"} selected="selected"{/if}>{$LANG.supportticketsticketurgencylow}</option>
                        </select>
        			</div>
        		</div>
    		</div>
        </div>

	    <div class="control-group">
		    <label class="control-label bold" for="message">{$LANG.contactmessage}</label>
			<div class="controls">
			    <textarea name="message" id="message" rows="12" class="fullwidth">{$message}</textarea>
			</div>
		</div>
{foreach key=num item=customfield from=$customfields}
	    <div class="control-group">
		    <label class="control-label bold" for="customfield{$customfield.id}">{$customfield.name}</label>
			<div class="controls">
			    {$customfield.input} {$customfield.description}
			</div>
		</div>
{/foreach}
	    <div class="control-group">
		    <label class="control-label bold" for="attachments">{$LANG.supportticketsticketattachments}:</label>
			<div class="controls">
			    <input type="file" name="attachments[]" style="width:70%;" /><br />
                <div id="fileuploads"></div>
                <a href="#" onclick="extraTicketAttachment();return false"><img src="images/add.gif" align="absmiddle" border="0" /> {$LANG.addmore}</a><br />
                ({$LANG.supportticketsallowedextensions}: {$allowedfiletypes})
			</div>
		</div>

    </fieldset>

<div id="searchresults" class="contentbox" style="display:none;"></div>

{if $capatacha}
<h3>{$LANG.captchatitle}</h3>
<p>{$LANG.captchaverify}</p>
{if $capatacha eq "recaptcha"}
<div align="center">{$recapatchahtml}</div>
{else}
<p align="center"><img src="includes/verifyimage.php" align="middle" /> <input type="text" name="code" class="input-small" maxlength="5" /></p>
{/if}
{/if}

<div class="form-actions" style="padding-left:160px;">
    <input class="btn btn-primary" type="submit" name="save" value="{$LANG.supportticketsticketsubmit}" />
    <input class="btn" type="reset" value="{$LANG.cancel}" />
</div>

</form>