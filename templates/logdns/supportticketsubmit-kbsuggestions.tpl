<h3>{$LANG.kbsuggestions}</h3>

<p>{$LANG.kbsuggestionsexplanation}</p>

<p>{foreach from=$kbarticles item=kbarticle}
<img src="images/article.gif" align="middle" alt="" /> <a href="knowledgebase.php?action=displayarticle&id={$kbarticle.id}" target="_blank">{$kbarticle.title}</a> - {$kbarticle.article}...<br>
{/foreach}</p>