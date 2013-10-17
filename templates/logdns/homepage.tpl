{if $condlinks.domainreg || $condlinks.domaintrans || $condlinks.domainown}
<div class="well">
    <div class="styled_title">
        <h1>{$LANG.domaincheckerchoosedomain}</h1>
    </div>
    <p>{$LANG.domaincheckerenterdomain}</p>
    <br />
    <div class="textcenter">
        <form method="post" action="{$systemsslurl}domainchecker.php">
        <input class="bigfield" name="domain" type="text" value="{$LANG.domaincheckerdomainexample}" onfocus="if(this.value=='{$LANG.domaincheckerdomainexample}')this.value=''" onblur="if(this.value=='')this.value='{$LANG.domaincheckerdomainexample}'" />
        {if $captcha}
        <div class="captchainput" align="center">
            <p>{$LANG.captchaverify}</p>
            {if $captcha eq "recaptcha"}
            <p>{$recaptchahtml}</p>
            {else}
            <p><img src="includes/verifyimage.php" align="middle" /> <input type="text" name="code" class="input-small" maxlength="5" /></p>
            {/if}
        </div>
        {/if}
        <div class="internalpadding">{if $condlinks.domainreg}<input type="submit" value="{$LANG.checkavailability}" class="btn btn-primary btn-large" /> {/if}{if $condlinks.domaintrans}<input type="submit" name="transfer" value="{$LANG.domainstransfer}" class="btn btn-success btn-large" />{/if}{if $condlinks.domainown} <input type="submit" name="hosting" value="{$LANG.domaincheckerhostingonly}" class="btn btn-large" />{/if}</div>
        </form>
    </div>
</div>
{/if}

<div class="row">

<div class="col2half">
    <div class="internalpadding">
        <div class="styled_title">
            <h2>{$LANG.navservicesorder}</h2>
        </div>
        <p>{$LANG.clientareahomeorder}<br /><br /></p>
        <form method="post" action="cart.php">
        <p align="center"><input type="submit" value="{$LANG.clientareahomeorderbtn} &raquo;" class="btn" /></p>
        </form>
    </div>
</div>
<div class="col2half">
    <div class="internalpadding">
        <div class="styled_title"><h2>{$LANG.manageyouraccount}</h2></div>
        <p>{$LANG.clientareahomelogin}<br /><br /></p>
        <form method="post" action="clientarea.php">
        <p align="center"><input type="submit" value="{$LANG.clientareahomeloginbtn} &raquo;" class="btn" /></p>
        </form>
    </div>
</div>

</div>

<div class="row">

{if $twitterusername}
<div class="styled_title">
    <h2>{$LANG.twitterlatesttweets}</h2>
</div>
<div id="twitterfeed">
    <p><img src="images/loading.gif"></p>
</div>
{literal}<script language="javascript">
jQuery(document).ready(function(){
  jQuery.post("announcements.php", { action: "twitterfeed", numtweets: 3 },
    function(data){
      jQuery("#twitterfeed").html(data);
    });
});
</script>{/literal}
{elseif $announcements}
<div class="styled_title">
    <h2>{$LANG.latestannouncements}</h2>
</div>
{foreach from=$announcements item=announcement}
<p>{$announcement.date} - <a href="{if $seofriendlyurls}announcements/{$announcement.id}/{$announcement.urlfriendlytitle}.html{else}announcements.php?id={$announcement.id}{/if}"><b>{$announcement.title}</b></a><br />{$announcement.text|strip_tags|truncate:100:"..."}</p>
{/foreach}
{/if}

</div>