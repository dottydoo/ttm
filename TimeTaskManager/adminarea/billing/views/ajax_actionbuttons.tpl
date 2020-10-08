<div id="ajaxbuttons{$eid}">
    {if $invoiceId && !$invoice && !$queue}
        <a class="mgactionbutton btn btn-mini btn-primary label" style="width: 85px;" href="invoices.php?action=edit&id={$invoiceId}">{$language->translate('View Invoice')}</a>    
    {else}      
        {if $queue}<a onclick="addToQueue({$eid})" class="mgactionbutton2 btn btn-mini btn-info label" href="javascript:;">{$language->translate('Add to Queue')}</a>{/if}
        {if $invoice}<a onclick="confirmInvoice({$eid})" class="mgactionbutton2 btn btn-mini btn-danger label" href="javascript:;">{$language->translate('Invoice Now')}</a>{/if}
        {if $queue || $invoice || $showEdit}<a class="mgactionbutton btn btn-mini btn-primary label" href="javascript:editBilling({$eid});">{$language->translate('Edit')}</a>{/if}
    {if !$queue && !$invoice && !$showEdit}{$language->translate('No Actions Available')}{/if}
{/if}
</div>