<form action="" method="post">
    <fieldset>
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('New Project Details')}</th>
            </tr>

            <tr>
                <td>{$lang.label_project_client}</td>
                <td>
                    <input style="width:300px;" type="text" name="client" value="{$smarty.post.client}" data-option="{$currentclientselected}" />
                </td>
            </tr>
            <tr>
                <td>{$lang.label_project_name}</td>
                <td>
                    <input type="text" style="width:300px;" name="projectname" value="{$smarty.post.projectname}" />
                </td>
            </tr>
            <tr>
                <td>{$lang.label_project_description}</td>
                <td>
                    <textarea style="width:300px;" name="projectdescription">{$smarty.post.projectdescription}</textarea>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Status')}</td>
                <td>
                    <select style="width:300px;" name="projectstatus">
                        <option value="Active">{$language->translate('Active')}</option>
                        <option {if $smarty.post.projectstatus == "Inactive"}selected{/if} value="Inactive">{$language->translate('Inactive')}</option>
                    </select>
                </td>
            </tr>
        </table>
        <input type="hidden" name="do" value="save" />
        <input type="submit" value="{$lang.button_add_project}" class="btn btn-success" style="height:34px;" />
        <a class="btn btn-danger" href="javascript:cancelTask('projects');" style="height:34px;">{$language->translate('Cancel')}</a>
    </fieldset>
</form>
{literal}

    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
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
    <script src="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.js"></script>
    <link href="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.css" rel="stylesheet">
    <style type="text/css">
        i {font-size: 17px!important;line-height: 20px!important;}
    </style>
{/literal}