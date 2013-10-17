{include file="$template/pageheader.tpl" title=$LANG.announcementstitle}

{foreach key=num item=announcement from=$announcements}

<h2><a href="{if $seofriendlyurls}announcements/{$announcement.id}/{$announcement.urlfriendlytitle}.html{else}{$smarty.server.PHP_SELF}?id={$announcement.id}{/if}">{$announcement.title}</a></h2>
<p><strong>{$announcement.timestamp|date_format:"%A, %B %e, %Y"}</strong></p>

<br />

<p>{$announcement.text|strip_tags|truncate:400:"..."}</p>

{if strlen($announcement.text)>400}<p><a href="{if $seofriendlyurls}announcements/{$announcement.id}/{$announcement.urlfriendlytitle}.html{else}{$smarty.server.PHP_SELF}?id={$announcement.id}{/if}">{$LANG.more} &raquo;</a></p>{/if}

<br />

{if $facebookrecommend}
{literal}
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
{/literal}
<div class="fb-like" data-href="{$systemurl}{if $seofriendlyurls}announcements/{$announcement.id}/{$announcement.urlfriendlytitle}.html{else}announcements.php?id={$announcement.id}{/if}" data-send="true" data-width="450" data-show-faces="true" data-action="recommend"></div>
{/if}
<br /><br />
{foreachelse}
<p align="center"><strong>{$LANG.announcementsnone}</strong></p>
{/foreach}

<br />

{if $prevpage || $nextpage}

<div style="float: left; width: 200px;">
{if $prevpage}<a href="announcements.php?page={$prevpage}">{/if}&laquo; {$LANG.previouspage}{if $prevpage}</a>{/if}
</div>

<div style="float: right; width: 200px; text-align: right;">
{if $nextpage}<a href="announcements.php?page={$nextpage}">{/if}{$LANG.nextpage} &raquo;{if $nextpage}</a>{/if}
</div>

{/if}

<br />

<p align="right"><img src="images/rssfeed.gif" alt="RSS" align="absmiddle" /> <a href="announcementsrss.php">{$LANG.announcementsrss}</a></p>

<br />