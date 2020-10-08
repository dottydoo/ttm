<fieldset id="addtimeentry">
    <table class="table table-bordered table-striped">
        <tr>
            <th colspan="2">{$language->translate('New Entry Details')}</th>
        </tr>

        <tr>
            <td>{$lang.label_project_name}</td>
            <td>

                <select name="project" onchange="getTasksByProject(jQuery(this).val());
                        changecurr();" style="width:300px;">
                    <option value="">---</option>
                    {foreach from=$projects item=p}
                        <option {if $smarty.post.project == $p.id} selected="selected"{/if} data-currencyid="{$p.currency}" value="{$p.id}">{$p.name}</option>
                    {/foreach}
                </select>
                <input type="hidden" name="curriences">
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Task')}</td>
            <td>
                <div style="float:left" id="ajax_taskselect">
                    {include file="ajax_taskselect.tpl"}
                </div>
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Admin')}</td>
            <td>
                <select name="admin">
                    {foreach from=$admins key=aid item=a}
                        <option {if $activeAdmin == $aid} selected {/if} value="{$aid}">{$a}</option>
                    {/foreach}
                </select>
            </td>
        </tr>

        <tr>
            <td>{$language->translate('Hours')}</td>
            <td>
                <input type="text" style="width:50px;" id="ttcHoursCount" name="hours" oninput="canIsave();" value="{if $smarty.post.hours}{$smarty.post.hours}{else}00:00{/if}" />
                <a href="javascript:;" data-html="true" class="info" data-placement="right" data-toggle="tooltip" title="{$language->translate('Hours worked')}"><i class="icon-info-sign"></i></a>
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Hourly Rate')}</td>
            <td>
                <div style="float:left" id="ajax_rateselect">
                    {include file="ajax_rateselect.tpl"}
                </div>
            </td>
        </tr>        
        {if $mileageenabled}
            <tr>
                <td>{$language->translate('Mileage')}</td>
                <td>
                    <input type="text" style="width:50px;" id="ttcMilageCount" name="mileage"  oninput="canIsave();" value="{if $smarty.post.mileage}{$smarty.post.mileage}{else}0.00{/if}" />
                    <a href="javascript:;" class="info" data-html="true" data-placement="right" data-toggle="tooltip" title="{$language->translate('Distance traveled')}"><i class="icon-info-sign"></i></a>
                </td>
            </tr>
        {/if}
        <tr>
            <td>{$language->translate('Description')}</td>
            <td>
                <textarea style="width:400px;" name="description">{$smarty.post.description}</textarea>
            </td>
        </tr>
        {if $fulladmin eq 1}
            <tr>
                <td>{$language->translate('Approve')}</td>
                <td>
                    <select name="approved" style="width:310px">
                        <option selected value="1">{$language->translate('ttcApproveStatus_1')}</option>
                        <option  value="0">{$language->translate('ttcApproveStatus_2')}</option>
                    </select>
                </td>
            </tr>
        {/if}
    </table>
    <input type="hidden" name="do" value="addentry" />
    <input type="submit" id="ttcTESubmit" value="{$language->translate('Submit New Time Entry')}" class="btn btn-success" disabled="disabled" />
</fieldset>
{literal}
    <script>

        function changecurr() {
            var id = jQuery("select[name=project] option:selected").attr("data-currencyid");
            jQuery('input[name=curriences]').attr('value', id);
            jQuery('select[name=task]').trigger('change');
        }

        function canIsave() {
            var arrayTime = jQuery('#ttcHoursCount').val().split(':');

            if ((parseFloat(arrayTime[1]) > 0 || parseFloat(arrayTime[0]) >0) || parseFloat(jQuery('#ttcMilageCount').val()) > 0)
            {
                jQuery('#ttcTESubmit').removeAttr('disabled', 'disabled');
            } else {
                jQuery('#ttcTESubmit').attr('disabled', 'disabled');
            }
        }

        jQuery(document).ready(function () {


        });
    </script>

    <style type="text/css">
        #ttcTESubmit:disabled {
            background-color: #8EC38E!important; 
        }
    </style>
{/literal}