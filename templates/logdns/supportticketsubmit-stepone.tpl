{include file="$template/pageheader.tpl" title=$LANG.navopenticket}

<p>{$LANG.supportticketsheader}</p>

<br />

<div class="row">
    <div class="center80">
    {foreach from=$departments item=department}
        <div class="col2half">
            <div class="contentpadded">
                <p><div class="fontsize2"><img src="images/emails.gif" /> &nbsp;<strong><a href="{$smarty.server.PHP_SELF}?step=2&amp;deptid={$department.id}">{$department.name}</a></strong></div></p>
    			{if $department.description}<p>{$department.description}</p>{/if}
            </div>
        </div>
    {foreachelse}
    <div class="alert alert-block alert-info textcenter">
        {$LANG.nosupportdepartments}
    </div>
    {/foreach}
    </div>
</div>

<br />
<br />
<br />