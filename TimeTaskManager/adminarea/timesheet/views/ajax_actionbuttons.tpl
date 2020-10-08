{if $invoiceId}
    <a class="mgactionbutton btn btn-mini btn-primary label" style="width: 85px;" href="invoices.php?action=edit&id={$invoiceId}">{$language->translate('View Invoice')}</a>    
{else}    
    <a onclick="editTimeEntry({$eid})" class="mgactionbutton btn btn-mini btn-info label" href="javascript:;" >{$language->translate('Edit')}</a>
    <a onclick="deleteTimeEntry({$eid})" class="mgactionbutton btn btn-mini btn-danger label" href="javascript:;" >{$language->translate('Delete')}</a>
    {if $fulladmin eq '1'}
        {if $approv eq '0' }
            <a class="mgactionbutton btn  btn-mini btn-success label" href="javascript:approveTimeEntry({$eid},'{$fromdate}');">{$language->translate('Accept')}</a>
        {else}
            <a class="mgactionbutton btn  btn-warning  label" href="javascript:unapproveTimeEntry({$eid},'{$fromdate}');">{$language->translate('Unapprove')}</a>
        {/if}
    {/if}
{/if}
