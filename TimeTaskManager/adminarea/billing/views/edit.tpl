<form action="" method="post">
    <fieldset>
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('Edit Billing Entery Details')}</th>
            </tr>
            <tr>
                <td style="width:300px;">{$language->translate('ID')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="id" disabled value="{$current.id}" />
                </td>
            </tr>
            <tr>
                <td style="width:300px;">{$language->translate('Task')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="task" disabled value="{$current.task}" />
                </td>
            </tr>
            <tr>
                <td style="width:300px;">{$lang.label_project_name}</td>
                <td>
                    <input type="text" class="width300 padding4" name="project" disabled value="#{$current.project_id} {$current.project}" />
                </td>
            </tr>
            <tr>
                <td style="width:300px;">{$lang.label_project_client}</td>
                <td>
                    <input type="text" class="width300 padding4" name="client" disabled value="{$current.client}" />
                </td>
            </tr> 
            <tr>
                <td style="width:300px;">{$language->translate('Admin')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="admin" disabled value="{$current.admin}" />
                </td>
            </tr>
            <tr>
                <td style="width:300px;">{$language->translate('Hours')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="hours" value="{$current.hours}" />
                </td>
            </tr>
            {if $mileageenabled}
                <tr>
                    <td style="width:300px;">{$language->translate('Mileage')}</td>
                    <td>
                        <input type="text" class="width300 padding4" name="mileage" value="{$current.mileage}" />
                    </td>
                </tr>
            {/if}
            <tr>
                <td style="width:300px;">{$language->translate('Hourly Rate')}</td>
                <td>
                    <select name="hourlyrate" style="width:310px" id = "ttcSelectRates" {if !$extraRate || $extraRate == '0.00'} disabled {/if}>
                        <option value="" {if !$extraRate || $extraRate == '0.00'} selected {/if}>{$language->translate('Normal Rate')} {$normalRate}</option>
                        <option value="1" {if $current.extrarate} selected {/if}>{$language->translate('Extra Rate')} {$extraRate}</option>
                    </select>
                </td>
            </tr>
            {if $mileageenabled}            
                <tr>
                    <td style="width:300px;">{$language->translate('Price per Mileage Unit')}</td>
                    <td>
                        <input type="text" class="width300 padding4" name="mileagerate" value="{$current.mileagerate}" />
                        <a href="javascript:;" data-html="true" class="info" data-placement="right" data-toggle="tooltip" title="{$language->translate('tooltip_taskprice')}"><i class="icon-info-sign"></i></a>
                    </td>
                </tr>  
            {/if}
            <tr>
                <td style="width:300px;">{$language->translate('Hours Price')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="hoursTotal" disabled value="{$base_hourlyprice}" />
                </td>
            </tr> 
            <tr>
                <td style="width:300px;">{$language->translate('Mileage Price')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="mileageTotal" disabled value="{$base_mileageprice}" />
                </td>
            </tr>            
            <tr>
                <td style="width:300px;">{$language->translate('Status')}</td>
                <td>
                    <input type="text" class="width300 padding4" name="status" disabled value="{if $current.bi_id}{$language->translate('billingStatusInQueue')}{else}{$language->translate('billingStatusNotQueued')}{/if}" />
                </td>
            </tr>  
            <tr>
                <td style="width:300px;">{$language->translate('Entry Description')}</td>
                <td>
                    <textarea style="width:500px" name="taskdescription">{$current.description}</textarea>
                </td>
            </tr>

        </table>
        <input type="hidden" name="eid" value="{$current.id}" />
        <input type="hidden" name="do" value="save" />
        <input type="submit" value="{$language->translate('saveChangesBtn')}" class="btn btn-success" style="height:34px;" />
        <a class="btn btn-danger" href="javascript:cancelTask('billing');" style="height:34px;">{$language->translate('Cancel')}</a>
    </fieldset>
</form>
{literal}
    <script type="text/javascript">
        jQuery('.info').tooltip();
    </script>
    <style type="text/css">
        i {font-size: 17px!important;line-height: 20px!important;}
    </style>
{/literal}