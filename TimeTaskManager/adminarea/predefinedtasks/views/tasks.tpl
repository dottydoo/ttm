{literal}
    <script type="text/javascript">

        function getAjaxSource() {
            return "addonmodules.php?module=TimeTaskManager&modpage=predefinedtasks&modsubpage=ajaxListTasks&ajax=1";
        }

        jQuery(document).ready(function () {
            ttcCheckDatatables(function () {
                var sTable = jQuery("#mgrecords").dataTable({
                    //"aaSorting": [[ 1, "desc" ]],
                    "aoColumns": getSorting(),
                    "iDisplayLength": 10,
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
                    }
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

<button class="btn btn-success" style="height:34px;" onclick="window.location = 'addonmodules.php?module=TimeTaskManager&modpage=predefinedtasks&modsubpage=add';
        return false;">{$language->translate('Add New Predefined Task')}</button>
<table id="mgrecords" class="dataTable table table-bordered table-striped">
    <thead>
        <tr>
            <th>{$language->translate('Name')}</th>
            <th>{$language->translate('Description')}</th>
            <th class="no_sort">{$language->translate('Hourly Rates')}</th>
            <th class="no_sort">{$language->translate('Extra Hourly Rates')}</th>            
                {if $mileageenabled}
                <th class="no_sort">{$language->translate('Mileage Rates')}</th>
                <th>{$language->translate('Mileage Type')}</th>
                {/if}
            <th>{$language->translate('Status')}</th>
            <th class="no_sort">{$language->translate('Urgency')}</th>            
            <th class="no_sort" style="width:70px;">{$language->translate('Actions')}</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<div id="dialog-confirm" title="{$language->translate('Delete Confirmation')}" style="display:none">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>{$language->translate('predConfirmation')}</p>
</div>
{literal}
    <style>
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd :nth-child(8){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd :nth-child(1){
            border-left-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even :nth-child(8){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even :nth-child(1){
            border-left-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd :nth-child(8){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd :nth-child(1){
            border-left-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even :nth-child(8){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }   
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even :nth-child(1){
            border-left-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd :nth-child(8){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd :nth-child(1){
            border-left-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even :nth-child(8){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        } 
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even :nth-child(1){
            border-left-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd :nth-child(8){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd :nth-child(1){
            border-left-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even :nth-child(8){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even :nth-child(1){
            border-left-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }      
    </style>
{/literal}