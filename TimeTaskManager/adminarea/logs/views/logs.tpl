{literal}
    <script type="text/javascript">
        jQuery(document).ready(function () {
            ttcCheckDatatables(function () {
                var sTable = jQuery("#mgrecords").dataTable({
                    "aaSorting": [[0, "desc"]],
                    "aoColumns": getSorting(),
                    "bProcessing": true,
                    "bServerSide": true,
                    "sAjaxSource": "addonmodules.php?module=TimeTaskManager&modpage=logs&modsubpage=ajaxListLogs&ajax=1",
                    "language": {
                        "emptyTable": "{/literal}{$language->translate('dttemptyTable')}{literal}",
                        "info": "{/literal}{$language->translate('dttinfo')}{literal}",
                        "infoEmpty": "{/literal}{$language->translate('dttinfoEmpty')}{literal}",
                        "infoFiltered": "{/literal}{$language->translate('dttinfoFiltered')}{literal}",
                        "thousands": "{/literal}{$language->translate('dttthousands')}{literal}",
                        "lengthMenu": "{/literal}{$language->translate('dttlengthMenu')}{literal}",
                        "loadingRecords": "{/literal}{$language->translate('dttloadingRecords')}{literal}",
                        "processing": "{/literal}{$language->translate('dttprocessing')}{literal}",
                        "search": "{/literal}{$language->translate('dttsearch')}{literal}",
                        "zeroRecords": "{/literal}{$language->translate('dttzeroRecords')}{literal}",
                        "paginate": {
                            "first": "{/literal}{$language->translate('dttfirst')}{literal}",
                            "last": "{/literal}{$language->translate('dttlast')}{literal}",
                            "next": "{/literal}{$language->translate('dttnext')}{literal}",
                            "previous": "{/literal}{$language->translate('dttprevious')}{literal}",
                        },
                        "aria": {
                            "sortAscending": "{/literal}{$language->translate('dttsortAscending')}{literal}",
                            "sortDescending": "{/literal}{$language->translate('dttsortDescending')}{literal}"
                        }
                    },
                    "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
                        jQuery.getJSON(sSource, aoData, function (json) {
                            if (!json.aaData) {
                                alert("{/literal}{$language->translate('dttUnexpectedError')}{literal}");
                            } else {
                                fnCallback(json);
                            }
                        })
                                .fail(function () {
                                    alert("{/literal}{$language->translate('dttUnexpectedError')}{literal}");
                                });
                    },
                    "fnInitComplete": function () {
                        jQuery('#mgrecords_filter input').off('keyup');
                        jQuery('#mgrecords_filter input').on('keypress', function (e) {
                            if (e.keyCode === 13)
                            {
                                e.preventDefault();
                                sTable.fnFilter(jQuery(this).val());
                            }
                        });
                    },
                    "fnDrawCallback": function () {
                        jQuery("td.dataTables_empty").css('text-align', 'center');
                    },
                });
            });
            jQuery('#mgrecords_processing').prepend('<img src="../modules/addons/TimeTaskManager/core/assets/img/preloader24.gif" /> ');
            jQuery('select[name=mgrecords_length]').css('width', 'auto').parent().contents().filter(function () {
                return this.nodeType == 3;
            }).remove();
            jQuery('select[name=mgrecords_length]').before("{/literal}{$language->translate('Records per page')}{literal}: ");
            jQuery('#mgrecords_length').css('float', 'none');
            jQuery("#mgrecords_length").appendTo(jQuery("#mgrecords_info").parent()).before('<br />');
            jQuery('#mgrecords_filter input').css('width', '200px');
        });
    </script>
{/literal}

<table id="mgrecords" class="dataTable table table-bordered table-striped">
    <thead>
        <tr>
            <th>{$language->translate('ID')}</th>
            <th>{$language->translate('Scope')}</th>
            <th>{$language->translate('Action')}</th>
            <th class="no_sort" >{$language->translate('Relative ID')}</th>
            <th class="no_sort" style="width:300px">{$language->translate('Data')}</th>
            <th class="no_sort" style="width:300px">{$language->translate('Old Data')}</th>
            <th>{$language->translate('Admin')}</th>
            <th class="no_sort" >{$language->translate('Time')}</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>
{if $administrator eq 1}
    <button type="submit" onclick="resetLogsConfirm()" href="javascript:;" class="btn btn-danger"> {$language->translate('reset_logs')}  </button>
    
    

 <div id="dialog-confirm" title="{$lang['Reset_Logs']}" style="display:none">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>{$language->translate('Reset_logs_dial')}</p>
</div>
    
{/if}

 
 
