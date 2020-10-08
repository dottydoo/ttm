<form action="" method="post">
    <fieldset>
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('Edit Task Details')}</th>
            </tr>
            <tr>
                <td>{$language->translate('Task Name')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="taskname" value="{$current.name}" />
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Charge From Prepaid Hours')}</td>
                <td>
                    <select name="prepaid" onchange="loadDefaultRates();" style="width:310px">
                        <option value="">---</option>
                        {foreach from=$prepaidfields key=fid item=f}
                            <option {if $current.prepaid == $fid} selected="selected"{/if} value="{$fid}">{$f.fieldname}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Hourly Rate')}</td>
                <td>
                    {foreach from=$currencies item=curr}
                        {assign var="curr_id" value=$curr.id}
                        <input type="text" class="padding4" style="width:40px;" name="hourlyrates[{$curr_id}]" value="{$current.hourlyrates.$curr_id|default:'0.00'}" />&nbsp;<strong>{$curr.code}</strong><br />
                    {/foreach}
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Extra Hourly Rate')}</td>
                <td>
                    {foreach from=$currencies item=curr}
                        {assign var="curr_id" value=$curr.id}
                        <input type="text" class="padding4" style="width:40px;" name="hourlyrate1[{$curr_id}]" value="{$current.hourlyrate1.$curr_id|default:'0.00'}" />&nbsp;<strong>{$curr.code}</strong><br />
                    {/foreach}
                </td>
            </tr>            
            {if $mileageenabled}
                <tr>
                    <td>{$language->translate('Mileage Rate')}</td>
                    <td>
                        {foreach from=$currencies item=curr}
                            {assign var="curr_id" value=$curr.id}
                            <input type="text" class="padding4" style="width:40px;" name="mileagerates[{$curr_id}]" value="{$current.mileagerates.$curr_id|default:'0.00'}" />&nbsp;<strong>{$curr.code}</strong><br />
                        {/foreach}
                    </td>
                </tr>
                <tr>
                    <td>{$language->translate('Mileage Type')}</td>
                    <td>
                        <select name="mileagetype" style="width:310px">
                            <option {if $current.mileagetype == 'billable'} selected="selected"{/if} value="billable">Billable</option>
                            <option {if $current.mileagetype == 'reference'} selected="selected"{/if} value="reference">Reference</option>
                            <option {if $current.mileagetype == 'internal'} selected="selected"{/if} value="internal">Internal</option>
                        </select>
                        <a href="javascript:;" class="info" data-html="true" data-placement="right" data-toggle="tooltip" title="{$language->translate('tooltip_mileagetype')}"><i class="icon-info-sign"></i></a>
                    </td>
                </tr>
            {/if}
            <tr>
                <td>{$language->translate('Status')}</td>
                <td>
                    <select name="status" style="width:310px">
                        <option {if $current.status == 'pending'} selected="selected"{/if} value="pending">Pending</option>
                        <option {if $current.status == 'inprogress'} selected="selected"{/if} value="inprogress">In Progress</option>
                        <option {if $current.status == 'closed'} selected="selected"{/if} value="closed">Closed</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Urgency')}</td>
                <td>
                    <select name="urgency" style="width:310px">
                        <option {if $current.urgency == 1} selected {/if} value="1">{$language->translate('ttcUrgencyStatus_1')}</option>
                        <option {if $current.urgency == 2} selected {/if} value="2">{$language->translate('ttcUrgencyStatus_2')}</option>
                        <option {if $current.urgency == 3} selected {/if} value="3">{$language->translate('ttcUrgencyStatus_3')}</option>
                        <option {if $current.urgency == 4} selected {/if} value="4">{$language->translate('ttcUrgencyStatus_4')}</option>
                    </select>
                </td>
            </tr>             
            <tr>
                <td>{$language->translate('Description')}</td>
                <td>
                    <textarea style="width:295px" name="taskdescription">{$current.description}</textarea>
                </td>
            </tr>
        </table>
        <input type="hidden" name="tid" value="{$current.id}" />
        <input type="hidden" name="do" value="save" />
        <input type="submit" value="{$language->translate('saveChangesBtn')}" class="btn btn-success" style="height:34px;" />
        <a class="btn btn-danger" href="javascript:cancelTask('predefinedtasks');" style="height:34px;">{$language->translate('Cancel')}</a>
    </fieldset>
</form>
{literal}
    <script type="text/javascript">
        var defaultfieldrates = {/literal}{$defaultfieldrates}{literal};
        jQuery('.info').tooltip();
    </script>
    <style type="text/css">
        i {font-size: 17px!important;line-height: 20px!important;}
    </style>
{/literal}