<ul>
{foreach from=$tweets item=tweet key=num}
{if $num < $numtweets}
  <li><b>{$tweet.date}</b> - {$tweet.tweet}</li>
{/if}
{/foreach}
</ul>
<p><a href="http://twitter.com/{$twitterusername}" target="_blank"><img src="templates/{$template}/img/twitterfollow.png" alt="{$LANG.twitterfollow}" /></a></p>