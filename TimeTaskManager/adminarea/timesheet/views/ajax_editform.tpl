<fieldset id="edittimeentry">
    <table class="table table-bordered table-striped">
        <tr>
            <th colspan="2">{$language->translate('Edit Entry Details')}</th>
        </tr>
        <tr>
            <td>{$language->translate('Date')}</td>
            <td><input style="width:80px;" type="text" name="date" value="{$current.date}" size="12" class="datepick" /></td>
        </tr>
        <tr>
            <td>{$lang.label_project_name}</td>
            <td>{$current.project}</td>
        </tr>
        <tr>
            <td>{$language->translate('Task')}</td>
            <td><a href="addonmodules.php?module=TimeTaskManager&modpage=tasks&modsubpage=edit&tid={$current.task_id}">{$current.task}</a></td>
        </tr>
        <tr>
            <td>{$language->translate('Admin')}</td>
            <td>{$current.admin}</td>
        </tr>

        <tr>
            <td>{$language->translate('Hours')}</td>
            <td>
                <input type="text" style="width:50px;" name="hours" id="ttcHoursCount" oninput="canIsave();" value="{$current.hours}" />
                <a href="javascript:;" class="info" data-html="true" data-placement="right" data-toggle="tooltip" title="{$language->translate('Hours worked')}"><i class="icon-info-sign"></i></a>
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Hourly Rate')}</td>
            <td>
                <select name="hourlyrate" style="width:310px" id = "ttcSelectRates">
                    <option value="">{$language->translate('Normal Rate')} {$nrate}</option>
                    <option value="1" {if $current.extrarate} selected {/if}>{$language->translate('Extra Rate')} {$erate}</option>
                </select>
            </td>
        </tr>        
        {if $mileageenabled}
            <tr>
                <td>{$language->translate('Mileage')}</td>
                <td>
                    <input type="text" style="width:50px;" name="mileage" id="ttcMilageCount" oninput="canIsave();" value="{$current.mileage}" />
                    <a href="javascript:;" class="info" data-html="true" data-placement="right" data-toggle="tooltip" title="{$language->translate('Distance traveled')}"><i class="icon-info-sign"></i></a>
                </td>
            </tr>
        {/if}
        <tr>
            <td>{$language->translate('Description')}</td>
            <td>
                <textarea style="width:400px;" name="description">{$current.description}</textarea>
            </td>
        </tr>
    </table>
    <input type="hidden" name="eid" value="{$current.id}" />
    <input type="hidden" name="do" value="editentry" />
    <input type="submit" value="{$language->translate('Submit')}" class="btn btn-success" id="ttcTESubmit" disabled="disabled"  />
    <input type="cancel" value="{$language->translate('Cancel')}" class="btn btn-danger" onclick="addTimeEntry();
            return false;" style="width:100px; height:34px; padding: 0px;" />
</fieldset>
{literal}
    <script>
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
            canIsave();
        });
    </script>
    <style>
        #ttcTESubmit:disabled {
            background-color: #8EC38E!important; 
            width:75px!important; 
            height:34px; 
            padding: 0px;

        }
    </style>
{/literal}