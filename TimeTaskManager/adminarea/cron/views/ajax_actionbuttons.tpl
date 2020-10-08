<div id="ajaxbuttons{$eid}">
    {if $queue}<a onclick="addToQueue({$eid})" class="mgactionbutton2 btn btn-mini btn-info label" href="javascript:;">{$language->translate('Add to Queue')}</a>{/if}
    {if $invoice}<a onclick="invoiceNow({$eid})" class="mgactionbutton2 btn btn-mini btn-danger label" href="javascript:;">{$language->translate('Invoice Now')}</a>{/if}
{if !$queue && !$invoice}{$language->translate('No Actions Available')}{/if}
</div>