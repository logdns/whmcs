{include file="$template/pageheader.tpl" title=$LANG.knowledgebasetitle}

<script language="javascript">
function addBookmark() {ldelim}
    if (window.sidebar) {ldelim}
        window.sidebar.addPanel('{$companyname} - {$kbarticle.title}', location.href,"");
    {rdelim} else if( document.all ) {ldelim}
        window.external.AddFavorite( location.href, '{$companyname} - {$kbarticle.title}');
    {rdelim} else if( window.opera && window.print ) {ldelim}
        return true;
    {rdelim}
{rdelim}
</script>

<p>{$breadcrumbnav}</p>

<br />

<h2>{$kbarticle.title}</h2>

<br />

<blockquote>
<br /><br />
{$kbarticle.text}
<br /><br />
</blockquote>

<form method="post" action="knowledgebase.php?action=displayarticle&amp;id={$kbarticle.id}&amp;useful=vote">
<p>
{if $kbarticle.voted}
<strong>{$LANG.knowledgebaserating}</strong> {$kbarticle.useful} {$LANG.knowledgebaseratingtext} ({$kbarticle.votes} {$LANG.knowledgebasevotes})
{else}
<strong>{$LANG.knowledgebasehelpful}</strong> <select name="vote"><option value="yes">{$LANG.knowledgebaseyes}</option><option value="no">{$LANG.knowledgebaseno}</option></select> <input type="submit" value="{$LANG.knowledgebasevote}" class="btn" />
{/if}
</p>
</form>

<p><img src="images/addtofavouritesicon.gif" align="absmiddle" alt="{$LANG.knowledgebasefavorites}" /> <a href="#" onClick="addBookmark();return false">{$LANG.knowledgebasefavorites}</a> &nbsp;&nbsp; <img src="images/print.gif" align="absmiddle" alt="{$LANG.knowledgebaseprint}" /> <a href="#" onclick="window.print();return false">{$LANG.knowledgebaseprint}</a></p>

{if $kbarticles}

<div class="kbalsoread">{$LANG.knowledgebasealsoread}</div>

{foreach key=num item=kbarticle from=$kbarticles}
<div class="kbarticle">
<img src="images/article.gif" align="middle" alt="" /> <strong><a href="{if $seofriendlyurls}knowledgebase/{$kbarticle.id}/{$kbarticle.urlfriendlytitle}.html{else}knowledgebase.php?action=displayarticle&amp;id={$kbarticle.id}{/if}">{$kbarticle.title}</a></strong> <span class="kbviews">({$LANG.knowledgebaseviews}: {$kbarticle.views})</span>
</div>
{/foreach}

{/if}

<br />