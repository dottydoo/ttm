<form action="" method="post">
    <fieldset>
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('Edit Task Details')}</th>
            </tr>
            {if $ticketback eq 1}
                <input type="hidden" name="ticket_back" value="true" />
            {/if}
            {if $ticket}
                <tr>
                    <td style="width:300px;">{$lang.label_project_ticket}</td>
                    <td>
                        <input type="hidden" name="ticket_id" value="{$ticket.id}" />
                        <a target="_blank" href="supporttickets.php?action=view&id={$ticket.id}">#{$ticket.tid}</a> - {$ticket.title}
                    </td>
                </tr>
            {/if}
            <tr>
                <td style="width:300px;">{$lang.label_project_name}</td>
                <td>
                    <select name="project" onchange="loadCurrencyCode(true);
                            refreshIncident();" style="width:310px">
                        <option value="">---</option>
                        {foreach from=$projects item=p}
                            {assign var="cid" value=$p.client_id}
                            <option {foreach from=$clientshours.$cid key=fid item=hours}data-hours{$fid}="{$hours}" {/foreach} {foreach from=$clientsincidents.$cid key=fid item=incidents}data-incidents{$fid}="{$incidents}" {/foreach} data-currencyid="{$p.currency}" {if $current.project_id == $p.id} selected="selected"{/if} value="{$p.id}">#{$p.id} {$p.name}</option>
                        {/foreach}
                    </select>
                </td>
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
                    <select name="prepaid" onchange="loadDefaultRate();" style="width:310px">
                        <option value="">---</option>
                        {foreach from=$prepaidfields key=fid item=f}
                            <option {if $current.prepaid == $fid} selected="selected"{/if} value="{$fid}">{$f.fieldname}</option>
                        {/foreach}
                    </select>
                    &nbsp;<span id="hoursinfo"></span>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Charge From Prepaid Incidents')}</td>
                <td>
                    <select name="incident" onchange="refreshIncident();" style="width:310px">
                        <option value="">---</option>
                        {foreach from=$incidentfields key=fid item=f}
                            <option {if $current.incident == $fid} selected="selected"{/if} value="{$fid}">{$f}</option>
                        {/foreach}
                    </select>
                    &nbsp;<span id="incidentinfo"></span>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Hourly Rate')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="hourlyrate" value="{$current.hourlyrate}" />&nbsp;<span class="currencycode"></span>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Extra Hourly Rate')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="hourlyrate1" value="{$current.hourlyrate1}" />&nbsp;<span class="currencycode"></span>
                </td>
            </tr>            
            {if $mileageenabled}
                <tr>
                    <td>{$language->translate('Mileage Rate')}</td>
                    <td>
                        <input type="text" class="width300 padding4" name="mileagerate" value="{$current.mileagerate}" />
                        <a href="javascript:;" data-html="true" class="info" data-placement="right" data-toggle="tooltip" title="{$language->translate('tooltip_mileagerate')}"><i class="icon-info-sign"></i></a>
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
                        <a href="javascript:;" data-html="true" class="info" data-placement="right" data-toggle="tooltip" title="{$language->translate('tooltip_mileagetype')}"><i class="icon-info-sign"></i></a>
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
                        <option {if ($current.urgency == 2) || (!$current.urgency)} selected {/if} value="2">{$language->translate('ttcUrgencyStatus_2')}</option>
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
            {if $ticket}
                <tr>
                    <td style="width:300px;">{$lang.label_counter_acutomaticaly}</td>
                    <td>
                        <input type="checkbox" name="autostart" value="1" {if $current.autocountticket eq '1'}checked{/if}/>
                    </td>
                </tr>
                <tr>
                    <td style="width:300px;">{$lang.label_close_automaticaly}</td>
                    <td>
                        <input type="checkbox" name="taskclose" value="1" {if $current.autoclosetask eq '1'}checked{/if}/>
                    </td>
                </tr>
            {/if}
        </table>
        <input type="hidden" name="tid" value="{$current.id}" />
        <input type="hidden" name="do" value="save" />
        <input type="submit" value="Save Changes" class="btn btn-success" style="height:34px;" />
        <a class="btn btn-danger" name="ref" href="javascript:cancelTask('tasks');" style="height:34px;">{$language->translate('Cancel')}</a>
    </fieldset>
</form>
{literal}
    <script src="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.js"></script>
    <link href="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.css" rel="stylesheet">
    <script type="text/javascript">
                        var defaultfieldrates = {/literal}{$defaultfieldrates}{literal};
                        var currencies = {/literal}{$currencies}{literal};
                        var incident_used = '{/literal}{$current.incident_used}{literal}';
                        jQuery('.info').tooltip();
                        jQuery(document).ready(function () {
    {/literal}

    {if $ticket && $ticketback eq 1}
            jQuery("a[name=ref]").attr('href', "javascript:backTicket('{$ticket.id}');");
    {/if}
    {if $ticket}

            jQuery("select[name=project]").val({$ticket.project_id}).attr("disabled", true);
            jQuery("select[name=project] option").not(":selected").remove();
    {else}
            jQuery("select[name=project]").select2();
    {/if}
    {literal}
            loadCurrencyCode(false);
            refreshIncident();
        });
    </script>
    <style type="text/css">
        i {font-size: 17px!important;line-height: 20px!important;}
    </style>
{/literal}