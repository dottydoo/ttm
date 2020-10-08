<form action="" method="post">
    <fieldset>
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('New Predefined Task Details')}</th>
            </tr>
            <tr>
                <td>{$language->translate('Task Name')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="taskname" value="{$smarty.post.taskname}" />
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Charge From Prepaid Hours')}</td>
                <td>
                    <select name="prepaid" onchange="loadDefaultRates();" style="width:310px">
                        <option value="">---</option>
                        {foreach from=$prepaidfields key=fid item=f}
                            <option {if $smarty.post.prepaid == $fid} selected="selected"{/if} value="{$fid}">{$f.fieldname}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Hourly Rate')}</td>
                <td>
                    {foreach from=$currencies item=curr}
                        {assign var="curr_id" value=$curr.id}
                        <input type="text" class="padding4" style="width:40px;" name="hourlyrates[{$curr_id}]" value="{$smarty.post.hourlyrates.$curr_id|default:'0.00'}" />&nbsp;<strong>{$curr.code}</strong><br />
                    {/foreach}
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Extra Hourly Rate')}</td>
                <td>
                    {foreach from=$currencies item=curr}
                        {assign var="curr_id" value=$curr.id}
                        <input type="text" class="padding4" style="width:40px;" name="hourlyrate1[{$curr_id}]" value="{$smarty.post.hourlyrate1.$curr_id|default:'0.00'}" />&nbsp;<strong>{$curr.code}</strong><br />
                    {/foreach}
                </td>
            </tr>            

            {if $mileageenabled}
                <tr>
                    <td>{$language->translate('Mileage Rate')}</td>
                    <td>
                        {foreach from=$currencies item=curr}
                            {assign var="curr_id" value=$curr.id}
                            <input type="text" class="padding4" style="width:40px;" name="mileagerates[{$curr_id}]" value="{$smarty.post.mileagerates.$curr_id|default:'0.00'}" />&nbsp;<strong>{$curr.code}</strong><br />
                        {/foreach}
                    </td>
                </tr>
                <tr>
                    <td>{$language->translate('Mileage Type')}</td>
                    <td>
                        <select name="mileagetype" style="width:310px">
                            <option {if $smarty.post.mileagetype == 'billable'} selected="selected"{/if} value="billable">Billable</option>
                            <option {if $smarty.post.mileagetype == 'reference'} selected="selected"{/if} value="reference">Reference</option>
                            <option {if $smarty.post.mileagetype == 'internal'} selected="selected"{/if} value="internal">Internal</option>
                        </select>
                        <a href="javascript:;" data-html="true" class="info" data-placement="right" data-toggle="tooltip" title="{$language->translate('tooltip_mileagetype')}"><i class="icon-info-sign"></i></a>
                    </td>
                </tr>
            {/if}

            <tr>
                <td>{$language->translate('Status')}</td>
                <td>
                    <select name="status" style="width:310px">
                        <option {if $smarty.post.status == 'pending'} selected="selected"{/if} value="pending">Pending</option>
                        <option {if $smarty.post.status == 'inprogress'} selected="selected"{/if} value="inprogress">In Progress</option>
                        <option {if $smarty.post.status == 'closed'} selected="selected"{/if} value="closed">Closed</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Urgency')}</td>
                <td>
                    <select name="urgency" style="width:310px">
                        <option value="1">{$language->translate('ttcUrgencyStatus_1')}</option>
                        <option selected value="2">{$language->translate('ttcUrgencyStatus_2')}</option>
                        <option value="3">{$language->translate('ttcUrgencyStatus_3')}</option>
                        <option value="4">{$language->translate('ttcUrgencyStatus_4')}</option>
                    </select>
                </td>
            </tr>              
            <tr>
                <td>{$language->translate('Description')}</td>
                <td>
                    <textarea style="width:295px" name="taskdescription">{$smarty.post.taskdescription}</textarea>
                </td>
            </tr>
        </table>
        <input type="hidden" name="do" value="save" />
        <input type="submit" value="{$language->translate('Add Predefined Task')}" class="btn btn-success" style="height:34px;" />
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