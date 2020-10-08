<form action="" method="post">
    <fieldset>
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('Edit Project Details')}</th>
            </tr>

            <tr>
                <td>{$lang.label_project_client}</td>
                <td>
                    <input style="width:300px;" type="text" name="client" value="{$current.client_id}" data-option="{$currentclientselected}" />
                </td>
            </tr>
            <tr>
                <td>{$lang.label_project_name}</td>
                <td>
                    <input type="text" style="width:300px;" name="projectname" value="{$current.name}" />
                </td>
            </tr>
            <tr>
                <td>{$lang.label_project_description}</td>
                <td>
                    <textarea style="width:300px;" name="projectdescription">{$current.description}</textarea>
                </td>
            </tr>
            <tr>
                {foreach from=$clientHours  key=hkey item=hvalue }    
                <tr>
                    <td>{$hvalue.fieldname}</td>
                    <td>
                        <input type="text" style="width:300px;" name="ttcCustomHStatus_{$hkey}" value="{$hvalue.value}" />
                    </td>
                </tr>
            {/foreach}
            {foreach from=$incidentHours key=ikey item=ivalue } 
                <tr>
                    <td>{$ivalue.fieldname}</td>
                    <td>
                        <input type="text" style="width:300px;" name="ttcIncidentHours_{$ikey}" value="{$ivalue.value|default:'0'}" />
                    </td>
                </tr>                
            {/foreach}   
            <tr>
                <td>{$language->translate('Status')}</td>
                <td>
                    <select style="width:300px;" name="projectstatus">
                        <option value="Active">{$language->translate('Active')}</option>
                        <option {if $current.status == "Inactive"}selected{/if} value="Inactive">{$language->translate('Inactive')}</option>
                    </select>
                </td>
            </tr>
        </table>
        <input type="hidden" name="pid" value="{$current.id}" />
        <input type="hidden" name="do" value="save" />
        <input type="submit" value="Save Changes" class="btn btn-success" style="height:34px;" />
        <a class="btn btn-danger" href="javascript:cancelTask('projects');" style="height:34px;">{$language->translate('Cancel')}</a>
    </fieldset>
</form>
{literal}
    <script src="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.js"></script>
    <link href="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.css" rel="stylesheet">
    <script type="text/javascript">
        jQuery('.info').tooltip();
        jQuery(document).ready(function () {
            jQuery("input[name=client]").select2({
                minimumInputLength: 2,
                multiple: false,
                allowClear: true,
                ajax: {
                    url: "addonmodules.php?module=TimeTaskManager&modpage=projects&modsubpage=ajaxSearchClients&ajax=1",
                    dataType: 'json',
                    type: "POST",
                    data: function (term, page) {
                        return {keyword: term};
                    },
                    results: function (data, page) {
                        return {results: data};
                    }
                },
                initSelection: function (item, callback) {
                    var id = item.val();
                    var text = item.data('option');
                    var data = {id: id, text: text};
                    callback(data);
                },
            });
        });
    </script>
{/literal}