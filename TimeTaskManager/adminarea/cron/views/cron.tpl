
{literal}
    <script type="text/javascript">

        function getAjaxSource() {

            var filters = {};
            return "addonmodules.php?module=TimeTaskManager&modpage=cron&modsubpage=ajaxListBillingEntries&ajax=1&" + jQuery.param(filters);
        }

        jQuery(document).ready(function () {
            ttcCheckDatatables(function () {
                var sTable = jQuery("#mgrecords").dataTable({
                    "aaSorting": [[1, "desc"]],
                    "aoColumns": getSorting(),
                    "iDisplayLength": 5,
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
                        delete aoData[2];
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

    <fieldset>
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('Cron Settings')}</th>
            </tr>
            <tr>
                <td>{$language->translate('Cron Billing Action')}</td>
                <td>
                    <select name="billingaction" onchange="saveCronBillingAction();
                            return false;">
                        <option {if $cron_billingaction=='invoiceall'}selected="selected"{/if} value="invoiceall">{$language->translate('Invoice All Queued Entries')}</option>
                        <option {if $cron_billingaction=='invoiceweek'}selected="selected"{/if} value="invoiceweek">{$language->translate('Invoice Entries From Previous Week')}</option>
                        <option {if $cron_billingaction=='invoicemonth'}selected="selected"{/if} value="invoicemonth">{$language->translate('Invoice Entries From Previous Month')}</option>
                    </select>
                    <span id="ajax_results"></span>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Cron Path')}</td>
                <td>{$cron_path}</td>
            </tr>
            <tr>
                <td>{$language->translate('Cron URL')}</td>
                <td><a href="{$cron_url}" target="_blank">{$cron_url}</a></td>
            </tr>
            <tr>
                <td>{$language->translate('Last Cron Run')}</td>
                <td>{$cron_lastrun}</td>
            </tr>
            <tr>
                <td>{$language->translate('Auto Credit Applying On Invoice')}</td>
                <td>
                    <select name="mgAutoCreditApply" onchange="saveMgAutoCreditApply();
                            return false;">
                        <option {if $cron_autoCreditApply == 'off' || !$cron_autoCreditApply}selected="selected"{/if} value="off">{$language->translate('Disable Auto Credit Applying')}</option>
                        <option {if $cron_autoCreditApply == 'on'}selected="selected"{/if} value="on">{$language->translate('Enable Auto Credit Applying')}</option>
                    </select>
                    <span id="ajax_creditResult"></span>
                </td>
            </tr>   
            <tr>
                <td>{$language->translate('Zero Invoices For Prepaid Entries')}</td>
                <td>
                    <select name="zeroInvoicesForPrePaid" onchange="saveZeroInvoicesAction();
                            return false;">
                        <option {if $cron_saveZeroInvoicesAction == 'off' || !$cron_saveZeroInvoicesAction}selected="selected"{/if} value="off">{$language->translate('Disable Zero Invoices')}</option>
                        <option {if $cron_saveZeroInvoicesAction=='on'}selected="selected"{/if} value="on">{$language->translate('Enable Zero Invoices')}</option>
                    </select>
                    <span id="ajax_iresult"></span>
                </td>
            </tr>          
        </table>
    </fieldset><br /><br />

    <h1>{$language->translate('Queued Entries')}</h1>
    <table id="mgrecords" class="dataTable table table-bordered table-striped">
        <thead>
            <tr>
                <th class="no_sort" style="width:13px;"><input type="checkbox" name="checkall" value="" onclick="checkAllRecords();" /></th>
                <th>{$language->translate('ID')}</th>
                <th>{$language->translate('Entry')}</th>
                <th>{$language->translate('Task')}</th>
                <th>{$lang.label_project_name}</th>
                <th>{$lang.label_project_client}</th>
                <th>{$language->translate('Admin')}</th>
                <th>{$language->translate('Hours')}</th>
                {if $mileageenabled}<th>{$language->translate('Mileage')}</th>{/if}
                <th>{$language->translate('Hours Price')}</th>
                {if $mileageenabled}<th>{$language->translate('Mileage Price')}</th>{/if}
                <th>{$language->translate('Status')}</th>
                <th class="no_sort" style="width:80px">{$language->translate('Actions')}</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</form>
<div id="bulkactionresults"></div>
<div id="bulkaction">
    <input type="hidden" name="bulkaction" value="invoicenow" />
    <button class="btn btn-danger" onclick="bulkAction();">{$language->translate('Invoice Now')}</button>
</div>
{literal}
    <style> 
        .ui-dialog{
            min-width: 400px;
        }

        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd td:nth-child(4){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }     

        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even td:nth-child(4){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }    

        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd td:nth-child(4){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }

        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even td:nth-child(4){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }   

        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd td:nth-child(4){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }

        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even td:nth-child(4){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        } 

        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd td:nth-child(4){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }

        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even td:nth-child(4){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }    

    </style>   
{/literal}