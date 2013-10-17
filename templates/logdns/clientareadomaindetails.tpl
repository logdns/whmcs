{include file="$template/pageheader.tpl" title=$LANG.managing|cat:' '|cat:$domain}

{if $updatesuccess}
<div class="alert alert-success">
    <p>{$LANG.changessavedsuccessfully}</p>
</div>
{elseif $registrarcustombuttonresult=="success"}
<div class="alert alert-success">
    <p>{$LANG.moduleactionsuccess}</p>
</div>
{elseif $error}
<div class="alert alert-error">
    <p>{$error}</p>
</div>
{elseif $registrarcustombuttonresult}
<div class="alert alert-error">
    <p><strong>{$LANG.moduleactionfailed}:</strong> {$registrarcustombuttonresult}</p>
</div>
{elseif $lockstatus=="unlocked"}
<div class="alert alert-error">
    <p><strong>{$LANG.domaincurrentlyunlocked}</strong> {$LANG.domaincurrentlyunlockedexp}</p>
</div>
{/if}

<div id="tabs">
    <ul class="nav nav-tabs">
        <li class="active" id="tab1nav"><a href="#tab1">{$LANG.information}</a></li>
        <li id="tab2nav"><a href="#tab2">{$LANG.domainsautorenew}</a></li>
        {if $rawstatus == "active"}<li id="tab3nav"><a href="#tab3">{$LANG.domainnameservers}</a></li>{/if}
        {if $lockstatus}{if $tld neq "co.uk" && $tld neq "org.uk" && $tld neq "ltd.uk" && $tld neq "plc.uk" && $tld neq "me.uk"}<li id="tab4nav"><a href="#tab4">{$LANG.domainregistrarlock}</a></li>{/if}{/if}
        {if $releasedomain}<li id="tab5nav"><a href="#tab5">{$LANG.domainrelease}</a></li>{/if}
        {if $addonscount}<li id="tab6nav"><a href="#tab6">{$LANG.clientareahostingaddons}</a></li>{/if}
        {if $managecontacts || $registerns || $dnsmanagement || $emailforwarding || $getepp}<li class="dropdown"><a data-toggle="dropdown" href="#" class="dropdown-toggle">{$LANG.domainmanagementtools}&nbsp;<b class="caret"></b></a>
            <ul class="dropdown-menu">
                {if $managecontacts}<li><a href="clientarea.php?action=domaincontacts&domainid={$domainid}">{$LANG.domaincontactinfo}</a></li>{/if}
                {if $registerns}<li><a href="clientarea.php?action=domainregisterns&domainid={$domainid}">{$LANG.domainregisterns}</a></li>{/if}
                {if $dnsmanagement}<li><a href="clientarea.php?action=domaindns&domainid={$domainid}">{$LANG.clientareadomainmanagedns}</a></li>{/if}
                {if $emailforwarding}<li><a href="clientarea.php?action=domainemailforwarding&domainid={$domainid}">{$LANG.clientareadomainmanageemailfwds}</a></li>{/if}
                {if $getepp}<li class="divider"></li>
                <li><a href="clientarea.php?action=domaingetepp&domainid={$domainid}">{$LANG.domaingeteppcode}</a></li>{/if}
                {if $registrarcustombuttons}<li class="divider"></li>
                {foreach from=$registrarcustombuttons key=label item=command}
                <li><a href="clientarea.php?action=domaindetails&amp;id={$domainid}&amp;modop=custom&amp;a={$command}">{$label}</a></li>
                {/foreach}{/if}
            </ul>
        </li>{/if}
    </ul>
</div>

<div data-toggle="tab" id="tab1" class="tab-content active">

    <div class="row">

        <div class="col30">
            <div class="internalpadding">
                <div class="styled_title"><h2>{$LANG.information}</h2></div>
                <p>{$LANG.domaininfoexp}</p>
                <br />
                <p><input type="button" value="{$LANG.backtodomainslist}" class="btn" onclick="window.location='clientarea.php?action=domains'" /></p>
            </div>
        </div>
        <div class="col70">
            <div class="internalpadding">
            	<div class="row">
                <div class="col2half">
                	<h4><strong>{$LANG.clientareahostingdomain}:</strong></h4> {$domain} <span class="label {$rawstatus}">{$status}</span>
                </div>
            	<div class="col2half">
                	<h4><strong>{$LANG.firstpaymentamount}:</strong></h4> <span>{$firstpaymentamount}</span>
                </div>
                </div>
            	<div class="row">
            	<div class="col2half">
                	<h4><strong>{$LANG.clientareahostingregdate}:</strong></h4> <span>{$registrationdate}</span>
                </div>
				<div class="col2half">
                	<p><h4><strong>{$LANG.recurringamount}:</strong></h4> {$recurringamount} {$LANG.every} {$registrationperiod} {$LANG.orderyears}{if $renew} &nbsp; <a href="cart.php?gid=renewals" class="btn btn-mini">{$LANG.domainsrenewnow}</a>{/if}</p>
                </div>
                </div>
            	<div class="row">
            	<div class="col2half">
                	<p><h4><strong>{$LANG.clientareahostingnextduedate}:</strong></h4> {$nextduedate}</p>
                </div>
            	<div class="col2half">
                	<p><h4><strong>{$LANG.orderpaymentmethod}:</strong></h4> {$paymentmethod}</p>
                </div>
                </div>
                <div class="clear"></div>
                {if $registrarclientarea}<div class="moduleoutput">{$registrarclientarea|replace:'modulebutton':'btn'}</div>{/if}
                <br />
                <br />
                <br />
            </div>
        </div>

    </div>

</div>
<div data-toggle="tab" id="tab2" class="tab-content">

    <div class="row">

        <div class="col30">
            <div class="internalpadding">
                <div class="styled_title"><h2>{$LANG.domainsautorenew}</h2></div>
                <p>{$LANG.domainrenewexp}</p>
            </div>
        </div>
        <div class="col70">
            <div class="internalpadding">
                <h4><strong>{$LANG.domainautorenewstatus}:</strong></h4>
                <div class="internalpadding">
                	<p><strong>{if $autorenew}{$LANG.domainsautorenewenabled}{else}{$LANG.domainsautorenewdisabled}{/if}</strong></p>
                </div>
                <hr />
                <br />
                <div class="internalpadding">
                    <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails" class="form-horizontal">
                    <input type="hidden" name="id" value="{$domainid}">
                    {if $autorenew}
                    <input type="hidden" name="autorenew" value="disable">
                    <p><input type="submit" class="btn btn-large btn-danger" value="{$LANG.domainsautorenewdisable}" /></p>
                    {else}
                    <input type="hidden" name="autorenew" value="enable">
                    <p><input type="submit" class="btn btn-large btn-success" value="{$LANG.domainsautorenewenable}" /></p>
                    {/if}
                    </form>
                </div>
                <br />
                <br />
                <br />
                <br />
            </div>
        </div>

    </div>

</div>
<div data-toggle="tab" id="tab3" class="tab-content">

    <div class="row">

        <div class="col30">
            <div class="internalpadding">
                <div class="styled_title"><h2>{$LANG.domainnameservers}</h2></div>
                <p>{$LANG.domainnsexp}</p>
            </div>
        </div>
        <div class="col70">
            <div class="internalpadding">
                <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails" class="form-horizontal">
                <input type="hidden" name="id" value="{$domainid}" />
                <input type="hidden" name="sub" value="savens" />
                <p><label class="full control-label"><input type="radio" class="radio inline" name="nschoice" value="default" onclick="disableFields('domnsinputs',true)"{if $defaultns} checked{/if} /> {$LANG.nschoicedefault}</label>
                <label class="full control-label"><input type="radio" class="radio inline" name="nschoice" value="custom" onclick="disableFields('domnsinputs','')"{if !$defaultns} checked{/if} /> {$LANG.nschoicecustom}</label></p>
                <br />
                <fieldset class="control-group">
                    <div class="control-group">
                        <label class="control-label" for="ns1">{$LANG.domainnameserver1}</label>
                        <div class="controls">
                            <input class="input-xlarge domnsinputs" id="ns1" name="ns1" type="text" value="{$ns1}" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="ns2">{$LANG.domainnameserver2}</label>
                        <div class="controls">
                            <input class="input-xlarge domnsinputs" id="ns2" name="ns2" type="text" value="{$ns2}" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="ns3">{$LANG.domainnameserver3}</label>
                        <div class="controls">
                            <input class="input-xlarge domnsinputs" id="ns3" name="ns3" type="text" value="{$ns3}" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="ns4">{$LANG.domainnameserver4}</label>
                        <div class="controls">
                            <input class="input-xlarge domnsinputs" id="ns4" name="ns4" type="text" value="{$ns4}" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="ns5">{$LANG.domainnameserver5}</label>
                        <div class="controls">
                            <input class="input-xlarge domnsinputs" id="ns5" name="ns5" type="text" value="{$ns5}" />
                        </div>
                    </div>
                    <div class="internalpadding">
                        <p class="textcenter"><input type="submit" class="btn btn-large btn-primary" value="{$LANG.changenameservers}" /></p>
                    </div>                    
                </fieldset>
                </form>

            </div>
        </div>

    </div>

</div>
<div data-toggle="tab" id="tab4" class="tab-content">

    <div class="row">

        <div class="col30">
            <div class="internalpadding">
                <div class="styled_title"><h2>{$LANG.domainregistrarlock}</h2></div>
                <p>{$LANG.domainlockingexp}</p>
            </div>
        </div>
        <div class="col70">
            <div class="internalpadding">
                <h4><strong>{$LANG.domainreglockstatus}:</strong></h4>
                <p><strong>{if $lockstatus=="locked"}{$LANG.domainsautorenewenabled}{else}{$LANG.domainsautorenewdisabled}{/if}</strong></p>
                <hr />
                <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
                <input type="hidden" name="id" value="{$domainid}" />
                <input type="hidden" name="sub" value="savereglock" />
                {if $lockstatus=="locked"}
                <p><input type="submit" class="btn btn-danger" value="{$LANG.domainreglockdisable}" /></p>
                {else}
                <p><input type="submit" class="btn btn-success" name="reglock" value="{$LANG.domainreglockenable}" /></p>
                {/if}
                </form>
            </div>
        </div>

    </div>

</div>
<div data-toggle="tab" id="tab5" class="tab-content">

    <div class="row">

        <div class="col30">
            <div class="internalpadding">
                <div class="styled_title"><h2>{$LANG.domainrelease}</h2></div>
                <p>{$LANG.domainreleasedescription}</p>
            </div>
        </div>
        <div class="col70">
            <div class="internalpadding">
                {if $releasedomain}
                <p><strong>&nbsp;&raquo;&nbsp;&nbsp;{$LANG.domainrelease}</strong></p>
                <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
                <input type="hidden" name="sub" value="releasedomain">
                <input type="hidden" name="id" value="{$domainid}">
                {$LANG.domainreleasetag}: <input type="text" name="transtag" size="20" />
                <p align="center"><input type="submit" value="{$LANG.domainrelease}" class="buttonwarn" /></p>
                </form>
                {/if}
            </div>
        </div>

    </div>

</div>
<div data-toggle="tab" id="tab6" class="tab-content">

    <div class="row">

        <div class="col30">
            <div class="internalpadding">
                <div class="styled_title"><h2>{$LANG.domainaddons}</h2></div>
                <p>{$LANG.domainaddonsinfo}</p>
            </div>
        </div>
        <div class="col70">
            <div class="internalpadding">
                {if $addons.idprotection}
                <div class="row">
                    <div class="domaddonimg">
                        <img src="images/idprotect.png" />
                    </div>
                    <div class="col70">
                        <strong>{$LANG.domainidprotection}</strong><br />
                        {$LANG.domainaddonsidprotectioninfo}<br />
                        {if $addonstatus.idprotection}
                        <a href="clientarea.php?action=domainaddons&id={$domainid}&disable=idprotect&token={$token}">{$LANG.disable}</a>
                        {else}
                        <a href="clientarea.php?action=domainaddons&id={$domainid}&buy=idprotect&token={$token}">{$LANG.domainaddonsbuynow} {$addonspricing.idprotection}</a>
                        {/if}
                    </div>
                </div>
                <br />
                {/if}
                {if $addons.dnsmanagement}
                <div class="row">
                    <div class="domaddonimg">
                        <img src="images/dnsmanagement.png" />
                    </div>
                    <div class="col70">
                        <strong>{$LANG.domainaddonsdnsmanagement}</strong><br />
                        {$LANG.domainaddonsdnsmanagementinfo}<br />
                        {if $addonstatus.dnsmanagement}
                        <a href="clientarea.php?action=domaindns&domainid={$domainid}">{$LANG.manage}</a> | <a href="clientarea.php?action=domainaddons&id={$domainid}&disable=dnsmanagement&token={$token}">{$LANG.disable}</a>
                        {else}
                        <a href="clientarea.php?action=domainaddons&id={$domainid}&buy=dnsmanagement&token={$token}">{$LANG.domainaddonsbuynow} {$addonspricing.dnsmanagement}</a>
                        {/if}
                    </div>
                </div>
                <br />
                {/if}
                {if $addons.emailforwarding}
                <div class="row">
                    <div class="domaddonimg">
                        <img src="images/emailfwd.png" />
                    </div>
                    <div class="col70">
                        <strong>{$LANG.domainemailforwarding}</strong><br />
                        {$LANG.domainaddonsemailforwardinginfo}<br />
                        {if $addonstatus.emailforwarding}
                        <a href="clientarea.php?action=domainemailforwarding&domainid={$domainid}">{$LANG.manage}</a> | <a href="clientarea.php?action=domainaddons&id={$domainid}&disable=emailfwd&token={$token}">{$LANG.disable}</a>
                        {else}
                        <a href="clientarea.php?action=domainaddons&id={$domainid}&buy=emailfwd&token={$token}">{$LANG.domainaddonsbuynow} {$addonspricing.emailforwarding}</a>
                        {/if}
                    </div>
                </div>
                {/if}
            </div>
        </div>

    </div>

</div>
</div>