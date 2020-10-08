
{literal}
    <script type="text/javascript">

        function isValidDate(date){
            return true;
          }  
          
        function getAjaxSource() {

            if (jQuery("#onlynotque").is(":checked")) {
                onlynotque = "&onlynotque=true";
            } else {

                onlynotque = "";
            }

            var filters = {};

            var fromisValid = jQuery("[name=fromdate]").val();
            var toisValid = jQuery("[name=todate]").val();
			
			
            if (isValidDate(fromisValid) && isValidDate(toisValid)) {
	
                filters['fromdate'] = jQuery("[name=fromdate]").val();
                filters['todate'] = jQuery("[name=todate]").val();
                filters['client'] = jQuery("[name=client]").val();

                return "addonmodules.php?module=TimeTaskManager&modpage=billing&modsubpage=ajaxListBillingEntries&ajax=1&" + jQuery.param(filters) + onlynotque;
            } else {
			
                alert('Date is not valid');
                return "addonmodules.php?module=TimeTaskManager&modpage=billing&modsubpage=ajaxListBillingEntries&ajax=1&" + jQuery.param(filters) + onlynotque;
            }
        }

        jQuery(document).ready(function () {

            jQuery("#ttcfromdate").datepicker({
                dateFormat: '{/literal}{$dateFormatPicker}{literal}',
                onSelect: function (dateText, inst) {
                    refreshTable('mgrecords');
                }
            });
            jQuery("#ttctodate").datepicker({
                dateFormat: '{/literal}{$dateFormatPicker}{literal}',
                onSelect: function (dateText, inst) {
                    refreshTable('mgrecords');
                }
            });

            ttcCheckDatatables(function () {
                var sTable = jQuery("#mgrecords").dataTable({
                    "aaSorting": [[1, "desc"]],
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
                        delete aoData[2];
                        jQuery.ajax({
                            type: "POST",
                            url: sSource,
                            data: aoData,
                            success: function(data)
                            {
                                json = JSON.parse(data);
                                if (!json.aaData) {
                                    alert("{/literal}{$language->translate('dttUnexpectedError')}{literal}");
                                } else {
                                    fnCallback(json);
                                }
                        
                            },
                                error: function(){
                                     alert("{/literal}{$language->translate('dttUnexpectedError')}{literal}");
                                }
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
            jQuery('select[name=mgrecords_length]').on('change', function () {
                jQuery('select[name=checkall]:checkbox').attr('checked', false);
            });
        });

    </script>
{/literal}

<form action="" method="post">

    <fieldset id="addtimeentry">
        <table class="table table-bordered table-striped">
            <tr>
                <th colspan="2">{$language->translate('Filters')}</th>
            </tr>
            <tr>
                <td>{$language->translate('Date Range')}</td>
                <td>
                    <input class="dateinput" name="fromdate"  id="ttcfromdate" value="{$fromdate}" />
                    {$language->translate('to')}
                    <input class="dateinput" name="todate" id="ttctodate" value="{$todate}" />
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Support Client')}</td>
                <td>
                    <select name="client" onchange="refreshTable('mgrecords')" style="width:300px">
                        <option value="">{$language->translate('All Clients')}</option>
                        {foreach from=$clients item=c}
                            <option {if $smarty.post.client == $c.id} selected="selected"{/if} value="{$c.id}">{$c.firstname} {$c.lastname} {if $c.companyname}({$c.companyname}){/if}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr>
                <td>{$language->translate('Only Not Queued')}</td>
                <td>
                    <input id="onlynotque" type="checkbox" />
                </td>
            </tr>
        </table>
        <input type="hidden" name="do" value="refreshfilters" />
        <input onclick="refreshTable('mgrecords');
                return false;" type="submit" value="{$language->translate('Refresh Filters')}" class="btn btn-success" style="height:34px;" />

    </fieldset>


    <table id="mgrecords" class="dataTable table table-bordered table-striped">
        <thead>
            <tr>
                <th class="no_sort" style="width:13px;"><input type="checkbox" name="checkall" value="" onclick="checkAllRecords();" /></th>
                <th style="min-width:25px;">{$language->translate('ID')}</th>
                <th>{$language->translate('Entry Description')}</th>
                <th>{$language->translate('Task')}</th>
                <th>{$lang.label_project_name}</th>
                <th>{$lang.label_project_client}</th>
                <th>{$language->translate('Admin')}</th>
                <th>{$language->translate('Hours')}</th>
                {if $mileageenabled}<th>{$language->translate('Mileage')}</th>{/if}
                <th>{$language->translate('Hours Price')}</th>
                {if $mileageenabled}<th>{$language->translate('Mileage Price')}</th>{/if}
                <th>{$language->translate('Date')}</th>            
                <th class="no_sort" >{$language->translate('Status')}</th>
                <th class="no_sort" style="width:80px">{$language->translate('Actions')}</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</form>
<div id="bulkactionresults"></div>
<div id="bulkaction">
    <button class="btn btn-info" onclick="bulkAction('addtoqueue');
            refreshTable('mgrecords');">{$language->translate('Add To Queue')}</button>
    <button class="btn btn-danger" onclick="bConfirmInvoices();">{$language->translate('Invoice Now')}</button>
</div>
{literal}
    <script src="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.js"></script>
    <link href="../modules/addons/TimeTaskManager/core/assets/select2-3.5.0/select2.css" rel="stylesheet">
    <script type="text/javascript">

        jQuery(document).ready(function () {
            jQuery("select[name=client]").select2();

            jQuery("#ttcNewInvoiceDudate").datepicker({
                dateFormat: datepickerformat
            });

            jQuery("#ttcNewBInvoiceDudate").datepicker({
                dateFormat: datepickerformat
            });

        });
    </script>
    <style> 
        .ui-dialog{
            min-width: 400px;
        }

        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd :nth-child(4){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }     
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.odd :nth-child(4){
            border-left-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even :nth-child(4){
            background-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.1}{literal}.even :nth-child(4){
            border-left-color: #{/literal}{$urgencyColors.1}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd :nth-child(4){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.odd :nth-child(4){
            border-left-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even :nth-child(4){
            background-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }   
        #mgrecords tbody .{/literal}{$urgencyColors.2}{literal}.even :nth-child(4){
            border-left-color: #{/literal}{$urgencyColors.2}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd :nth-child(4){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.odd :nth-child(4){
            border-left-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even :nth-child(4){
            background-color: #{/literal}{$urgencyColors.3}{literal} !important;
        } 
        #mgrecords tbody .{/literal}{$urgencyColors.3}{literal}.even :nth-child(4){
            border-left-color: #{/literal}{$urgencyColors.3}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd :nth-child(4){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.odd :nth-child(4){
            border-left-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }      
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even :nth-child(4){
            background-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }    
        #mgrecords tbody .{/literal}{$urgencyColors.4}{literal}.even :nth-child(4){
            border-left-color: #{/literal}{$urgencyColors.4}{literal} !important;
        }      

    </style>   
{/literal}
<div id="dialog-confirm" title="{$language->translate('invoiceConfirmation')}" style="display:none;">
    <div>
        <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>{$language->translate('invoiceConfirmationDescription')}</p>
    </div>
    <div>
        {$language->translate('newInvoiceDudateLabel')} <input class="dateinput" id="ttcNewInvoiceDudate" value="" disabled />
        <input type="hidden" class="dateformat" id="ttcNewInvoiceDudateFormat" value="{$dateFormat}"/>
    </div>
</div>

<div id="bdialog-confirm" title="{$language->translate('invoiceConfirmation')}" style="display:none;">
    <div>
        <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>{$language->translate('bInvoiceConfirmationDescription')}</p>
    </div>
    <div>
        {$language->translate('newBInvoiceDudateLabel')} <input class="dateinput" id="ttcNewBInvoiceDudate" value="" disabled />
    </div>
</div>    
