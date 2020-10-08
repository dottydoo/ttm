<form action="" method="post">
    <fieldset>
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('New Task Details')}</th>
            </tr>
            {if $ticket}
                <tr>
                    <td style="width:300px;">{$lang.label_project_ticket}</td>
                    <td>
                        <input type="hidden" name="ticket_id" value="{$ticket.id}" />
                        <a target="_blank" href="supporttickets.php?action=view&id={$ticket.id}">#{$ticket.tid}</a> - {$ticket.title} &nbsp;&nbsp;
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
                    <input type="text" class="width300 padding4" name="taskname" value="{$smarty.post.taskname}" />
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Charge From Prepaid Hours')}</td>
                <td>
                    <select name="prepaid" onchange="loadDefaultRate();" style="width:310px">
                        <option value="">---</option>
                        {foreach from=$prepaidfields key=fid item=f}
                            <option {if $smarty.post.prepaid == $fid} selected="selected"{/if} value="{$fid}">{$f.fieldname}</option>
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
                            <option {if $smarty.post.incident == $fid} selected="selected"{/if} value="{$fid}">{$f}</option>
                        {/foreach}
                    </select>
                    &nbsp;<span id="incidentinfo"></span>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Hourly Rate')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="hourlyrate" value="{$smarty.post.hourlyrate|default:'0.00'}" />&nbsp;<span class="currencycode"></span>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Extra Hourly Rate')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="hourlyrate1" value="{$smarty.post.hourlyrate1|default:'0.00'}" />&nbsp;<span class="currencycode"></span>
                </td>
            </tr>            
            {if $mileageenabled}
                <tr>
                    <td>{$language->translate('Mileage Rate')}</td>
                    <td>
                        <input type="text" class="width300 padding4" name="mileagerate" value="{$smarty.post.mileagerate|default:'0.00'}" />
                        <a href="javascript:;" class="info" data-html="true" data-placement="right" data-toggle="tooltip" title="{$language->translate('tooltip_mileagerate')}"><i class="icon-info-sign"></i></a>
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
            {if $ticket}
                <tr>
                    <td style="width:300px;">{$lang.label_counter_acutomaticaly}</td>
                    <td>
                        <input type="checkbox" name="autostart" value="1" checked/>
                    </td>
                </tr>
                <tr>
                    <td style="width:300px;">{$lang.label_close_automaticaly}</td>
                    <td>
                        <input type="checkbox" name="taskclose" value="1" checked/>
                    </td>
                </tr>
            {/if}
            {if $fulladmin eq 1}
                <tr>
                    <td>{$language->translate('Time Entry')}</td>
                    <td class="timeentries">
                        <div id="1" class="timeentry">
                            <input type="text" class="width50 padding4"  name="timeentry[0]" onchange="validateHhMm(this);" value="00:00" width="48"/>&nbsp;
                            <span class="">hh:mm</span>

                            <input type="date" class="data" name="data[0]" min="2000-01-01" max="2050-12-31" style="width:180px">&nbsp;
                            <span class="">Data</span>&nbsp;

                            <input type="text" class="width300 padding4"  name="description[0]" value="New Time Entry Description"/>&nbsp;


                            <input type="checkbox" class="approve" name="approve[0]" checked>&nbsp;
                            <span class="">{$language->translate('Billable')}</span>&nbsp;
                            <button id="addtime" class="btn btn-info btn-sm glyphicon glyphicon-plus" style="margin-top:2px; height:25px;">
                                {$language->translate('Add Time')}
                            </button>
                        </div>
                    </td>
                </tr>
            {/if}
        </table>
        {if $ticket}
            <input type="hidden" name="fromticket" value="{$ticket.id}"/>&nbsp;
        {/if}
        <input type="hidden" name="do" value="save" />
        <input type="submit" value="{$language->translate('Add Task')}" class="btn btn-success" style="height:34px;" />
        <a class="btn btn-danger" name="ref" href="javascript:cancelTask('tasks');" style="height:34px;">{$language->translate('Cancel')}</a>
    </fieldset>
</form>
{literal}
    <script src="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.js"></script>
    <link href="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.css" rel="stylesheet">
    <script type="text/javascript">
                                var defaultfieldrates = {/literal}{$defaultfieldrates}{literal};
                                var incidentDefaultRate = {/literal}{$incidentDefaultRate}{literal};
                                var currencies = {/literal}{$currencies}{literal};
                                var arraylength = '{/literal}{$timeentrytab|count}{literal}';
                                var incident_used = '0';
                                var i = 0;
                                jQuery('.info').tooltip();
                                jQuery(document).ready(function () {


                                    if (arraylength > 0)
                                    {
                                        jQuery('div#1').find('input[name="timeentry[0]"]').prop('value', '{/literal}{$timeentrytab[0].timeentry}{literal}');
                                        jQuery('div#1').find('input[name="description[0]"]').prop('value', '{/literal}{$timeentrytab[0].description}{literal}');

    {/literal}
    {foreach from=$timeentrytab item=value}
        {literal}

                    if (i == 0)
                    {
                        jQuery('div#1').find('input[name="timeentry[0]"]').prop('value', '{/literal}{$value.timeentry}{literal}');
                        jQuery('div#1').find('input[name="description[0]"]').prop('value', '{/literal}{$value.description}{literal}');
                        jQuery('div#1').find('input[name="data[0]"]').prop('value', '{/literal}{$value.data}{literal}');
                    } else {

                        cloneinputdiv('{/literal}{$value.timeentry}{literal}', '{/literal}{$value.description}{literal}', '{/literal}{$value.data}{literal}', i);
                    }
                    i = i + 1;

        {/literal}
    {/foreach}
    {literal}
            }
            function leadingZero(checkdata) {
                return (checkdata < 10) ? '0' + checkdata : checkdata;
            }


            var currentDate = new Date();
            var currentDataFormat = currentDate.getFullYear() + '-' + leadingZero(currentDate.getMonth() + 1) + "-" + leadingZero(currentDate.getDate());
            jQuery('input.data').attr('value', currentDataFormat);  //'+currentDate.getFullYear()+'-'+(currentDate.getMonth()+1)+'-'+currentDate.getDate()+'

    {/literal}
    {if $ticket}
            jQuery("a[name=ref]").attr('href', "javascript:backTicket('{$ticket.id}');");
            jQuery("select[name=project]").val({$ticket.project_id}).attr("disabled", true);
            jQuery("select[name=status]").val('inprogress');
            loadCurrencyCode(false);
    {else}
            jQuery("select[name=project]").select2();
    {/if}
    {literal}
            refreshIncident();

        });

        jQuery('button#addtime').click(function () {
            i = i + 1;
            var clonedate = jQuery('div#1').find('input[name="data[0]"]').attr('value');
            cloneinputdiv('00:00', 'New Time Entry Description', clonedate, i);
            return false;

        });

        function cloneinputdiv(timeentry, description, setdate, counter) {

            var newRow = jQuery('div#1').clone();
            newRow.find('input[name="timeentry[0]"]').attr('name', 'timeentry[' + counter + ']');
            newRow.find('input[name="timeentry[' + counter + ']"]').prop('value', timeentry);

            newRow.find('div[class="timeentry"]').attr('id', counter);

            newRow.find('input[name="description[0]"]').attr('name', 'description[' + counter + ']');
            newRow.find('input[name="description[' + counter + ']"]').prop('value', description);

            newRow.find('input[name="approve[0]"]').attr('name', 'approve[' + counter + ']');
            newRow.find('input[name="approve[' + counter + ']"]').prop('checked', true);

            newRow.find('input[name="data[0]"]').attr('name', 'data[' + counter + ']');
            newRow.find('input[name="data[' + counter + ']"]').prop('value', setdate);


            newRow.find('button[id="addtime"]').attr('class', 'btn btn-danger btn-lg');
            newRow.find('button[id="addtime"]').attr('style', 'margin-top:2px; height:25px;');
            newRow.find('button[id="addtime"]').html('Delete');
            newRow.find('button[id="addtime"]').attr('id', 'deltime');

            newRow.appendTo(jQuery('td.timeentries'));

            jQuery('button#deltime').click(function () {

                jQuery(this).closest('div.timeentry').remove();
                return false;
            });


        }

        /* validate time */
        function validateHhMm(inputField) {
            
            var isValid  = false;
            
            if(isInteger(inputField.value))
            {
                isValid = true
            }else{
            
                isValid = /^([0-9][0-9]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField.value);
            }
            
            if (isValid) {
                inputField.style.backgroundColor = '#bfa';
                jQuery('input.save').attr("disabled", false);

            } else {
                inputField.style.backgroundColor = '#fba';
                jQuery('input.save').attr("disabled", true);
            }

            return isValid;
        }
        
        /* check if intege */
        function isInteger(x)
        {
             return ($.isNumeric(x)) && (x % 1 === 0);
        }

    </script>
    <style type="text/css">
        i {font-size: 17px!important;line-height: 20px!important;}
    </style>
{/literal}