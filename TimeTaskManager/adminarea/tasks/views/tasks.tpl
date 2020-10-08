{literal}
    <script type="text/javascript">

        function getAjaxSource() {
            var notclosed = "";
            if (jQuery("#hideclosedtasks").is(":checked")) {
                notclosed = "&notclosed=1";
            }
            return "addonmodules.php?module=TimeTaskManager&modpage=tasks&modsubpage=ajaxListTasks&ajax=1" + notclosed;
        }

        jQuery(document).ready(function () {

            jQuery('.change').change(function () {
                alert();
                console.log();

            })


            ttcCheckDatatables(function () {
                var sTable = jQuery("#mgrecords").dataTable({
                    //"aaSorting": [[ 1, "desc" ]],
                    "aoColumns": getSorting(),
                    "iDisplayLength": 10,
//                    "searching": true,
                    "bProcessing": true,
                    "bServerSide": true,
                    "sAjaxSource": getAjaxSource(),
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
                        sSource = getAjaxSource();
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
                        jQuery("td.dataTables_empty,.dataTable tr td:last-child").css('text-align', 'center');
                    },
                });
            });

            jQuery('#mgrecords_wrapper div:first div:first').css('position', 'relative').css('margin-top', '10px');
            jQuery('#closedtasksfilter').appendTo('#mgrecords_wrapper div:first div:first').show();
            jQuery('#mgrecords_processing').prepend('<img src="../modules/addons/TimeTaskManager/core/assets/img/preloader24.gif" /> ');
            jQuery('select[name=mgrecords_length]').css('width', 'auto').parent().contents().filter(function () {
                return this.nodeType == 3;
            }).remove();
            jQuery('select[name=mgrecords_length]').before("{/literal}{$language->translate('Records per page')}{literal}: ");
            jQuery('#mgrecords_length').css('float', 'none');
            jQuery("#mgrecords_length").appendTo(jQuery("#mgrecords_info").parent()).before('<br />');
            jQuery('#mgrecords_filter input').css('width', '200px');//.after("<button class='btn btn-success'>Filter</button>");
        });
    </script>
{/literal}

<button class="btn btn-success" style="height:34px;" onclick="window.location = 'addonmodules.php?module=TimeTaskManager&modpage=tasks&modsubpage=add';
        return false;">{$language->translate('Add New Task')}</button>
<label id="closedtasksfilter" style="display:none; position: inherit; bottom:0;">
    <input onclick="refreshTable('mgrecords');" id="hideclosedtasks" type="checkbox"  checked/>
    <span style="vertical-align:text-top;">{$language->translate('Hide Closed Tasks')}
    </span>
</label>
<table id="mgrecords" class="dataTable table table-bordered table-striped" style="width: 100%;">
    <thead>
        <tr>
            <th>{$language->translate('ID')}</th>
            <th>{$lang.label_project_name}</th>
            <th>{$language->translate('Name')}</th>
            <th>{$language->translate('Description')}</th>
            <th>{$language->translate('Hourly Rate')}</th>
                {if $mileageenabled}
                <th>{$language->translate('Mileage Rate')}</th>
                <th>{$language->translate('Mileage Type')}</th>
                {/if}
            <th>{$language->translate('Status')}</th>
            <th>{$language->translate('Urgency')}</th>
            <th class="no_sort" style="width:70px;">{$language->translate('Actions')}</th>
        </tr>

    </thead>
    <tbody>
    </tbody>
</table>

<div id="dialog-confirm" title="{$language->translate('Delete Confirmation')}" style="display:none">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>{$language->translate('Task will be deleted. Are you sure?')}</p>
</div>

{literal}
    <style>
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd td:nth-child(9){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd td:nth-child(9){
            border-left-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even td:nth-child(9){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }   
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even td:nth-child(9){
            border-left-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }          
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd td:nth-child(9){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd td:nth-child(9){
            border-left-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even td:nth-child(9){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }   
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even td:nth-child(9){
            border-left-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd td:nth-child(9){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd td:nth-child(9){
            border-left-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even td:nth-child(9){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        } 
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even td:nth-child(9){
            border-left-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd td:nth-child(9){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd td:nth-child(9){
            border-left-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even td:nth-child(9){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even td:nth-child(9){
            border-left-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }      
    </style>
{/literal}