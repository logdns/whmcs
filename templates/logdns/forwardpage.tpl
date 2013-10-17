<br /><br />

<div class="alert alert-block alert-warn">
    <p>{$message}</p>
</div>

<p class="textcenter"><img src="images/loading.gif" alt="Loading" border="0" /></p>

<br />

<div id="submitfrm" class="textcenter">{$code}</div>

<form method="post" action="{if $invoiceid}viewinvoice.php?id={$invoiceid}{else}clientarea.php{/if}"></form>

<br /><br /><br />

{literal}
<script language="javascript">
setTimeout ( "autoForward()" , 5000 );
function autoForward() {
	var submitForm = $("#submitfrm").find("form");
    submitForm.submit();
}
</script>
{/literal}