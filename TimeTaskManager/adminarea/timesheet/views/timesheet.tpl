
{literal}
    <style type="text/css">
        table.ui-datepicker-calendar td{ width:30px !important;}
        .ll-skin-latoja .ui-datepicker td {
            position: relative;
        }
        table.ui-datepicker-calendar .dayhours {
            color: #F00;
            position: absolute;
            bottom: -2px;
            font-size: 10px;
            right: 2px;
        }
        .ll-skin-latoja .ui-datepicker td span, .ll-skin-latoja .ui-datepicker td a {
            padding: 0px 5px 16px;
            color: #6A747A;
            text-align: left;
        }
        .ll-skin-latoja td a.ui-state-active, .ll-skin-latoja td a.ui-state-active.ui-state-hover {
            background-color: #B9D7F7;
        }
    </style>
    <script type="text/javascript">

        var dailyinfo = {};
        function getMonthlyInfo(month, year) {
            var params = {};
            params['modpage'] = 'timesheet';
            params['modsubpage'] = 'ajaxGetMonthlyInfo';
            params['month'] = month;
            params['year'] = year;
            ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#monthlyinfo"), true, false, false);
        }

        function getDailyInfo(month, year) {
            var params = {};
            params['modpage'] = 'timesheet';
            params['modsubpage'] = 'ajaxGetDailyInfo';
            params['month'] = month;
            params['year'] = year;
            callback = function (data) {
                var log = {};
                try {
                    log = JSON.parse(data);
                } catch (e) {
                    console.log('Invalid Response: '.data);
                    return false;
                }
                dailyinfo = log;
                showDailyInfo(log, year, month);
            }
            ajaxCall("addonmodules.php?module=TimeTaskManager", params, false, true, false, callback);
        }

        function showDailyInfo(data, year, month) {
            if (!year || !month) {
                return false;
            }
            if (!data) {
                data = dailyinfo;
            }
            var hours = data.hours;

            //var mileage = log.mileage;
            jQuery.each(jQuery("#datepicker td[data-year='" + year + "'][data-month='" + (month - 1) + "']"), function (k, daycell) {
                var day = jQuery(daycell).find("a").text();
                var dayhours = '';
                if (hours[day] && hours[day] != '0.00') {
                    dayhours = hours[day];
                }
                jQuery(daycell).prepend('<div class="dayhours">' + dayhours + '</div>');
            });
        }

        function getAjaxSource() {

            if (jQuery("#onlynotque").is(":checked")) {
                onlynotque = "&onlynotque=true";
            } else {

                onlynotque = "";
            }

            return "addonmodules.php?module=TimeTaskManager&modpage=timesheet&modsubpage=ajaxListEntries&ajax=1&fromdate=" + jQuery("#dateinput").val() + onlynotque;
        }

        jQuery(document).ready(function () {
            jQuery("#datepicker").datepicker({
                dateFormat: datepickerformat,
    {/literal}{if $defaultdate}defaultDate: '{$defaultdate}',{/if}{literal}
                altField: "#dateinput",
                onSelect: function (dateText, inst) {
                    refreshTable('mgrecords');
                    inst.inline = false;
                    jQuery(".ui-datepicker-calendar .ui-datepicker-current-day").removeClass("ui-datepicker-current-day").children().removeClass("ui-state-active");
                    jQuery(".ui-datepicker-calendar TBODY A").each(function () {
                        if (jQuery(this).text() == inst.selectedDay) {
                            jQuery(this).addClass("ui-state-active");
                            jQuery(this).parent().addClass("ui-datepicker-current-day");
                        }
                    });
                },
                onChangeMonthYear: function (year, month) {
                    getMonthlyInfo(month, year);
                    getDailyInfo(month, year);
                }
            });
            getMonthlyInfo('{/literal}{$defaultmonth}{literal}', '{/literal}{$defaultyear}{literal}');
            getDailyInfo('{/literal}{$defaultmonth}{literal}', '{/literal}{$defaultyear}{literal}');

            ttcCheckDatatables(function () {
                var sTable = jQuery("#mgrecords").dataTable({
                    //"aaSorting": [[ 1, "desc" ]],
                    "aoColumns": getSorting(),
                    "iDisplayLength": 10,
                    "aLengthMenu": [[5, 10, 25, 50, 100], [5, 10, 25, 50, 100]],
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
            jQuery('#entriesdateinput').appendTo('#mgrecords_wrapper div:first div:first').show();
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

<form action="" method="post">
    <div class="mgrow">
        <div class="mgdatepick">
            <div id="entriesdateinput" style="display:none;">
                {$language->translate('Entries From')}: 
                <input id="dateinput" readonly name="fromdate" id="ttcfromdate" value="{$fromdate}"/><br>

                <input onclick="refreshTable('mgrecords');" id="onlynotque" type="checkbox"/>
                <span style="vertical-align:text-top;">{$language->translate('Only Not Queued')}
                </span>
            </div>
            <div  id="datepicker" class="ll-skin-latoja"></div>
            <div id="monthlyinfo"></div>
            <br />
            <a style="display:none;" id="btnnewentry" class="mgaddactionbutton btn btn-info" href="javascript:addTimeEntry();">{$language->translate('New Time Entry')}</a>
        </div>
        <div id="ajax_timeentry">
            {include file='ajax_addform.tpl'}
        </div>
        <div class="clear"></div>
    </div>
    <input type="hidden" class="dateformat" id="ttcNewInvoiceDudateFormat" name ="dateFormat" value="{$dateFormat}"/> 
    <div class="mgrecordstable" style="padding-left: {if $whmcs6}5px{else}20px{/if} !important; width: 100%;">
        <table id="mgrecords" class="dataTable table table-bordered table-striped" style="width: 100%;">
            <thead>
                <tr>
                    <th>{$language->translate('ID')}</th>
                    <th>{$lang.label_project_name}</th>
                    <th>{$language->translate('Task')}</th>
                    <th>{$language->translate('Admin')}</th>
                    <th>{$language->translate('Hours')}</th>
                        {if $mileageenabled}
                        <th>{$language->translate('Mileage')}</th>
                        {/if}
                    <th style="width:350px;overflow: auto;">{$language->translate('Description')}</th>
                    <th>{$language->translate('Status')}</th>                    
                    <th class="no_sort" style="width:70px">{$language->translate('Actions')}</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</form>

<div id="dialog-confirm" title="Delete Confirmation" style="display:none">
    <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>{$language->translate('Time entry will be deleted. Are you sure?')}</p>
</div>

{literal}
    <script src="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.js"></script>
    <link href="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.css" rel="stylesheet">
    <script type="text/javascript">
                    jQuery(document).ready(function () {
                        jQuery("select[name=project]").select2();
                    });
    </script>
{/literal}
{literal}
    <style>
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd td:nth-child(3){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd td:nth-child(3){
            border-left-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even td:nth-child(3){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even td:nth-child(3){
            border-left-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd td:nth-child(3){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd td:nth-child(3){
            border-left-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even td:nth-child(3){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }   
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even td:nth-child(3){
            border-left-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd td:nth-child(3){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd td:nth-child(3){
            border-left-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even td:nth-child(3){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        } 
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even td:nth-child(3){
            border-left-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd td:nth-child(3){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd td:nth-child(3){
            border-left-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even td:nth-child(3){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even td:nth-child(3){
            border-left-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }      
    </style>
{/literal}