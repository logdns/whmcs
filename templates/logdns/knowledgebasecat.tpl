{include file="$template/pageheader.tpl" title=$LANG.knowledgebasetitle}

<p>{$breadcrumbnav}</p>

<br />

<div class="well">
    <div class="textcenter">
        <form method="post" action="knowledgebase.php?action=search" class="form-inline">
        {if $catid}<input type="hidden" name="catid" value="{$catid}" />{/if}
            <fieldset class="control-group">
        	    <input class="bigfield" name="search" type="text" value="{if $searchterm}{$searchterm}{else}{$LANG.kbquestionsearchere}{/if}" onfocus="this.value=(this.value=='{$LANG.kbquestionsearchere}') ? '' : this.value;" onblur="this.value=(this.value=='') ? '{$LANG.kbquestionsearchere}' : this.value;"/>
                <input type="submit" class="btn btn-large btn-primary" value="{$LANG.knowledgebasesearch}" />
        	</fieldset>
        </form>
    </div>
</div>

{if $kbcats}
{include file="$template/subheader.tpl" title=$LANG.knowledgebasecategories}

<div class="control-group">
{foreach name=kbasecats from=$kbcats item=kbcat}
    <div class="col4">
        <div class="internalpadding">
            <img src="images/folder.gif" /> <a href="{if $seofriendlyurls}knowledgebase/{$kbcat.id}/{$kbcat.urlfriendlyname}{else}knowledgebase.php?action=displaycat&amp;catid={$kbcat.id}{/if}" class="fontsize2"><strong>{$kbcat.name}</strong></a> ({$kbcat.numarticles})<br />
            {$kbcat.description}
        </div>
    </div>
	{if ($smarty.foreach.kbasecats.index+1) is div by 4}<div class="clear"></div>
    {/if}
{/foreach}
</div>
<div class="clear"></div>
{/if}{if $kbarticles}
{include file="$template/subheader.tpl" title=$LANG.knowledgebasearticles}

{foreach from=$kbarticles item=kbarticle}
<div class="row">
    <img src="images/article.gif"> <a href="{if $seofriendlyurls}knowledgebase/{$kbarticle.id}/{$kbarticle.urlfriendlytitle}.html{else}knowledgebase.php?action=displayarticle&amp;id={$kbarticle.id}{/if}" class="fontsize2"><strong>{$kbarticle.title}</strong></a><br />
    {$kbarticle.article|truncate:100:"..."}
</div>
{foreachelse}
<br />
<p class="fontsize3 textcenter">{$LANG.knowledgebasenoarticles}</p>
<br /><br /><br />
{/foreach}
{/if}
<div class="clear"></div>

<br />
