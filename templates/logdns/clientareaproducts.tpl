{include file="$template/pageheader.tpl" title=$LANG.clientareaproducts desc=$LANG.clientareaproductsintro}

<div class="searchbox">
    <form method="post" action="clientarea.php?action=products">
        <div class="input-append">
            <input type="text" name="q" value="{if $q}{$q}{else}{$LANG.searchenterdomain}{/if}" class="input-medium appendedInputButton" onfocus="if(this.value=='{$LANG.searchenterdomain}')this.value=''" /><button type="submit" class="btn btn-info">{$LANG.searchfilter}</button>
        </div>
    </form>
</div>

<div class="resultsbox">
<p>{$numitems} {$LANG.recordsfound}, {$LANG.page} {$pagenumber} {$LANG.pageof} {$totalpages}</p>
</div>

<table class="table table-striped table-framed">
    <thead>
        <tr>
            <th{if $orderby eq "product"} class="headerSort{$sort}"{/if}><a href="clientarea.php?action=products{if $q}&q={$q}{/if}&orderby=product">{$LANG.orderproduct}</a></th>
            <th{if $orderby eq "price"} class="headerSort{$sort}"{/if}><a href="clientarea.php?action=products{if $q}&q={$q}{/if}&orderby=price">{$LANG.orderprice}</a></th>
            <th{if $orderby eq "billingcycle"} class="headerSort{$sort}"{/if}><a href="clientarea.php?action=products{if $q}&q={$q}{/if}&orderby=billingcycle">{$LANG.orderbillingcycle}</a></th>
            <th{if $orderby eq "nextduedate"} class="headerSort{$sort}"{/if}><a href="clientarea.php?action=products{if $q}&q={$q}{/if}&orderby=nextduedate">{$LANG.clientareahostingnextduedate}</a></th>
            <th{if $orderby eq "status"} class="headerSort{$sort}"{/if}><a href="clientarea.php?action=products{if $q}&q={$q}{/if}&orderby=status">{$LANG.clientareastatus}</a></th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
{foreach from=$services item=service}
        <tr>
            <td><strong>{$service.group} - {$service.product}</strong>{if $service.domain}<br /><a href="http://{$service.domain}" target="_blank">{$service.domain}</a>{/if}</td>
            <td>{$service.amount}</td>
            <td>{$service.billingcycle}</td>
            <td>{$service.nextduedate}</td>
            <td><span class="label {$service.rawstatus}">{$service.statustext}</span></td>
            <td>
                <div class="btn-group">
                <a class="btn" href="clientarea.php?action=productdetails&id={$service.id}"> <i class="icon icon-list-alt"></i> {$LANG.clientareaviewdetails}</a>
                {if $service.rawstatus == "active" && ($service.downloads || $service.addons || $service.packagesupgrade || $service.showcancelbutton)}
                <a class="btn dropdown-toggle" href="#" data-toggle="dropdown"><span class="caret"></span></a>
                <ul class="dropdown-menu">
                    {if $service.downloads} <li><a href="clientarea.php?action=productdetails&id={$service.id}#tab3"><i class="icon-download"></i> {$LANG.downloadstitle}</a></li>{/if}
                    {if $service.addons} <li><a href="clientarea.php?action=productdetails&id={$service.id}#tab4"><i class="icon-th-large"></i> {$LANG.clientareahostingaddons}</a></li>{/if}
                    {if $service.packagesupgrade} <li><a href="upgrade.php?type=package&id={$service.id}#tab3"><i class="icon-resize-vertical"></i> {$LANG.upgradedowngradepackage}</a></li>{/if}
                    {if ($service.addons || $service.downloads || $service.packagesupgrade) && $service.showcancelbutton} <li class="divider"></li>{/if}
                    {if $service.showcancelbutton} <li><a href="clientarea.php?action=cancel&id={$service.id}"><i class="icon-off"></i> {$LANG.clientareacancelrequestbutton}</a></li>{/if}
                </ul>
                {/if}
                </div>
            </td>
        </tr>
{foreachelse}
        <tr>
            <td colspan="6" class="textcenter">{$LANG.norecordsfound}</td>
        </tr>
{/foreach}
    </tbody>
</table>

{include file="$template/clientarearecordslimit.tpl" clientareaaction=$clientareaaction}

<div class="pagination">
    <ul>
        <li class="prev{if !$prevpage} disabled{/if}"><a href="{if $prevpage}clientarea.php?action=products{if $q}&q={$q}{/if}&amp;page={$prevpage}{else}javascript:return false;{/if}">&larr; {$LANG.previouspage}</a></li>
        <li class="next{if !$nextpage} disabled{/if}"><a href="{if $nextpage}clientarea.php?action=products{if $q}&q={$q}{/if}&amp;page={$nextpage}{else}javascript:return false;{/if}">{$LANG.nextpage} &rarr;</a></li>
    </ul>
</div>