{include file="$template/pageheader.tpl" title=$LANG.sslconfsslcertificate}

{if !$status}

<p>{$LANG.sslinvalidlink}</p>

<br />

<p><input type="button" value="{$LANG.clientareabacklink}" class="btn" onclick="history.go(-1)" /></p>

{else}

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

{if $status eq "Awaiting Configuration"}

<form method="post" action="{$smarty.server.PHP_SELF}?cert={$cert}&step=2">

{include file="$template/subheader.tpl" title=$LANG.sslserverinfo}

<p>{$LANG.sslserverinfodetails}</p>

<fieldset class="onecol">

    <div class="control-group">
	    <label class="control-label" for="servertype">{$LANG.sslservertype}</label>
		<div class="controls">
		    <select name="servertype" id="servertype">
            <option value="" selected>{$LANG.pleasechooseone}</option>
            {foreach from=$webservertypes key=webservertypeid item=webservertype}<option value="{$webservertypeid}"{if $servertype eq $webservertypeid} selected{/if}>{$webservertype}</option>{/foreach}
            </select>
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="csr">{$LANG.sslcsr}</label>
		<div class="controls">
		    <textarea name="csr" id="csr" rows="7" style="width:90%">-----BEGIN CERTIFICATE REQUEST-----

-----END CERTIFICATE REQUEST-----</textarea>
		</div>
	</div>

</fieldset>

{foreach from=$additionalfields key=heading item=fields}
<p><b>{$heading}</b></p>
<table width="100%" cellspacing="1" cellpadding="0" class="frame"><tr><td>
<table width="100%" cellpadding="2">
{foreach from=$fields item=vals}
<tr><td width="120" class="fieldarea">{$vals.name}</td><td>{$vals.input} {$vals.description}</td></tr>
{/foreach}
</table>
</td></tr></table>
{/foreach}

{include file="$template/subheader.tpl" title=$LANG.ssladmininfo}

<p>{$LANG.ssladmininfodetails}</p>

<fieldset class="onecol">

    <div class="control-group">
	    <label class="control-label" for="firstname">{$LANG.clientareafirstname}</label>
		<div class="controls">
		    <input type="text" name="firstname" id="firstname" value="{$firstname}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="lastname">{$LANG.clientarealastname}</label>
		<div class="controls">
		    <input type="text" name="lastname" id="lastname" value="{$lastname}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="orgname">{$LANG.organizationname}</label>
		<div class="controls">
		    <input type="text" name="orgname" id="orgname" value="{$orgname}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="jobtitle">{$LANG.jobtitle}</label>
		<div class="controls">
		    <input type="text" name="jobtitle" id="jobtitle" value="{$jobtitle}" /> &nbsp; {$LANG.jobtitlereqforcompany}
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="email">{$LANG.clientareaemail}</label>
		<div class="controls">
		    <input type="text" name="email" id="email" value="{$email}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="address1">{$LANG.clientareaaddress1}</label>
		<div class="controls">
		    <input type="text" name="address1" id="address1" value="{$address1}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="address2">{$LANG.clientareaaddress2}</label>
		<div class="controls">
		    <input type="text" name="address2" id="address2" value="{$address2}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="city">{$LANG.clientareacity}</label>
		<div class="controls">
		    <input type="text" name="city" id="city" value="{$city}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="state">{$LANG.clientareastate}</label>
		<div class="controls">
		    <input type="text" name="state" id="state" value="{$state}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="postcode">{$LANG.clientareapostcode}</label>
		<div class="controls">
		    <input type="text" name="postcode" id="postcode" value="{$postcode}" />
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="country">{$LANG.clientareacountry}</label>
		<div class="controls">
		    {$countriesdropdown}
		</div>
	</div>

    <div class="control-group">
	    <label class="control-label" for="phonenumber">{$LANG.clientareaphonenumber}</label>
		<div class="controls">
		    <input type="text" name="phonenumber" id="phonenumber" value="{$phonenumber}" />
		</div>
	</div>

</fieldset>

<p align="center"><input type="submit" value="{$LANG.ordercontinuebutton}" class="btn btn-primary" /></p>

</form>

{else}

<form method="post" action="clientarea.php?action=productdetails">
<input type="hidden" name="id" value="{$serviceid}" />
<p><input type="submit" value="{$LANG.invoicesbacktoclientarea}" class="btn" /></p>
 </form>

{/if}{/if}

<br />
<br />
<br />