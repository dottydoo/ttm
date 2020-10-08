function refreshIncident() {
    var inc = jQuery("select[name=incident]").val();
    if (inc && inc !== 0)
    {
       // jQuery("select[name=prepaid] option[value='']").attr('selected', 'selected');
    }
    if (parseInt(incident_used)) {
        jQuery("select[name=incident]").attr("disabled", true);
        jQuery("#incidentinfo").html("Already Charged");
    } else if (!jQuery("select[name=project]").val()) {
        jQuery("select[name=incident]").val("").attr("disabled", true);
        jQuery("#incidentinfo").html("Select Support Client First");
    } else {
        if (jQuery("select[name=incident]").val()) {
            var fid = jQuery("select[name=incident]").val();
            var incidents = jQuery("select[name=project] option:selected").attr("data-incidents" + fid);
            if (typeof (incidents) === 'undefined') {
                incidents = 0;
            }
            jQuery("select[name=incident]").removeAttr("disabled");
            jQuery("#incidentinfo").html("Client Has " + incidents + " Incidents Left");
        } else {
            jQuery("select[name=incident]").removeAttr("disabled");
            jQuery("#incidentinfo").html("");
        }
    }
    loadDefaultIncidentRate();
}
function loadCurrencyCode(loaddefaultrate) {
    var id = jQuery("select[name=project] option:selected").attr("data-currencyid");
    if (typeof currencies[id] !== 'undefined' && typeof currencies[id].code !== 'undefined') {
        var code = currencies[id].code;
        jQuery(".currencycode").html(code + "/h");
        var fid = jQuery("[name=prepaid]").val();
        if (fid && loaddefaultrate) {
            loadDefaultRate();
        }
    } else {
        jQuery(".currencycode").html("");
    }
}
function loadDefaultRate() {


    var currid = jQuery("select[name=project] option:selected").attr("data-currencyid");
    if (!currid) {
        currid = 1;
    }
    var fid = jQuery("[name=prepaid]").val();

    if (jQuery("select[name=project]").val()) {
        var hours = jQuery("select[name=project] option:selected").attr("data-hours" + fid);
        if (typeof (hours) === 'undefined') {
            hours = null;
        }
        if(hours !== null)
        {
            jQuery("#hoursinfo").html("Client Has " + hours + " Left");
        }else{
            jQuery("#hoursinfo").html("");
        }
    } else {
        jQuery("#hoursinfo").html("");
    }
    if (typeof defaultfieldrates[fid] !== 'undefined' && typeof defaultfieldrates[fid][currid] !== 'undefined') {
        jQuery("[name=hourlyrate]").val(defaultfieldrates[fid][currid]);
    } else {
        jQuery("[name=hourlyrate]").val("0.00");
    }
}
function loadDefaultIncidentRate() {

    var currid = jQuery("select[name=project] option:selected").attr("data-currencyid");
    if (!currid) {
        currid = 1;
    }
    var fid = jQuery("[name=incident]").val();

    if (jQuery("select[name=incident]").val()) {
        var hours = jQuery("select[name=project] option:selected").attr("data-hours" + fid);
        if (typeof (hours) === 'undefined') {
            hours = "0 hours 00 minutes";
        }
        //jQuery("#hoursinfo").html("Client Has " + hours + " Left");
    } else {
        //jQuery("#hoursinfo").html("");
    }
    if (incidentDefaultRate !== null && typeof incidentDefaultRate[fid] !== 'undefined') {
        jQuery("[name=hourlyrate]").val(incidentDefaultRate[fid]);
    } else {
        jQuery("[name=hourlyrate]").val("");
    }
}
function loadDefaultRates() {
    var fid = jQuery("[name=prepaid]").val();
    if (typeof defaultfieldrates[fid] !== 'undefined') {
        jQuery.each(defaultfieldrates[fid], function (currency, rate) {
            jQuery("[name='hourlyrates[" + currency + "]']").val(rate);
        });
    }
}
function refreshTable(id) {
    var e = jQuery.Event("keypress");
    e.which = 13;
    e.keyCode = 13;
    jQuery("#" + id + "_filter input").trigger(e);
}
function refreshIframe(id, src) {

    jQuery("#" + id).attr('src', src);
}
function refreshTablePage(id) {
    jQuery("#" + id + "_wrapper div.dataTables_paginate li.active").click();
}
function addTimeEntry() {
    if (!jQuery("#ajax_timeentry #addtimeentry").length) {
        var params = {};
        params['modpage'] = 'timesheet';
        params['modsubpage'] = 'ajaxAddForm';
        ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajax_timeentry"), true, false, false, function () {
            jQuery("select[name=project]").select2();
            jQuery('.info').tooltip();
        });
        jQuery("#btnnewentry").hide();
    }
    window.location.hash = 'ajax_timeentry';
}
function editTimeEntry(eid) {

    var params = {};
    params['modpage'] = 'timesheet';
    params['modsubpage'] = 'ajaxEditForm';
    params['eid'] = eid;
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajax_timeentry"), true, false, false, function () {
        jQuery('.info').tooltip();
    });
    jQuery("#btnnewentry").show();
    window.location.hash = 'ajax_timeentry';
}
function deleteTimeEntry(eid) {
    jQuery("#dialog-confirm").dialog({
        
        open:   function(){
                    var closeBtn = jQuery('.ui-dialog-titlebar-close');
                    jQuery( ".ui-dialog-titlebar-close" ).addClass( "ui-button ui-widget ui-state-default ui-corner-all  ui-dialog-titlebar-close" );
                    closeBtn.find('#closeModalIcon').remove();
                    closeBtn.append('<span title="Close" id="closeModalIcon">x</span>\n\
                                        ');
                            
                },
        resizable: false,
        modal: true,
        buttons: {
            "Delete": {
                text: 'Delete',
                class: 'btn btn-danger',
                click: function () {
                    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=timesheet&modsubpage=delete&eid=' + eid;
                }
            },
            "Cancel": {
                text: 'Cancel',
                class: 'btn',
                click: function () {
                    jQuery(this).dialog("close");
                }
            }
        }
    });
}

function resetLogsConfirm() {
    jQuery("#dialog-confirm").dialog({
        
        open:   function(){
                    var closeBtn = jQuery('.ui-dialog-titlebar-close');
                    jQuery( ".ui-dialog-titlebar-close" ).addClass( "ui-button ui-widget ui-state-default ui-corner-all ui-dialog-titlebar-close" );
                    closeBtn.find('#closeModalIcon').remove();
                    closeBtn.append('<span title="Close" id="closeModalIcon">x</span>\n\
                                       ');
                            
                },
        resizable: false,
        modal: true,
        buttons: {
            "Delete": {
                text: 'Delete',
                class: 'btn btn-danger',
                click: function () {
                    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=logs&resetlog=1';
                }
            },
            "Cancel": {
                text: 'Cancel',
                class: 'btn',
                click: function () {
                    jQuery(this).dialog("close");
                }
            }
        }
    });
}


function addToQueue(eid) {

    jQuery("#ajaxbuttons" + eid).parent().parent().find("label[class=status]").html('Status Changed');
    var params = {};
    params['modpage'] = 'billing';
    params['modsubpage'] = 'ajaxAddToQueue';
    params['eid'] = eid;
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajaxbuttons" + eid), true, false, false);
}

function invoiceNow(eid, duedate, dataForm) {

    jQuery("#ajaxbuttons" + eid).parent().parent().find("label[class=status]").html('Status Changed');
    var params = {};
    params['modpage'] = 'billing';
    params['modsubpage'] = 'ajaxInvoiceEntry';
    params['eid'] = eid;
    params['duedate'] = duedate;
    params['dataForm'] = dataForm;
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajaxbuttons" + eid), true, false, false);
}

function getSorting() {
    var aoColumns = [];
    jQuery('#mgrecords thead th').each(function () {
        if (jQuery(this).hasClass('no_sort')) {
            jQuery(this).css('cursor', 'auto');
            aoColumns.push({"bSortable": false});
        } else {
            aoColumns.push(null);
        }
    });
    return aoColumns;
}

function checkAllRecords() {
    if (jQuery("[name=checkall]").is(":checked")) {
        jQuery("[name^=checkrecord_]").prop("checked", true);
    } else {
        jQuery("[name^=checkrecord_]").prop("checked", false);
    }
}

function bulkAction(action) {

    if (action) {
        var bulkaction = action;
    } else {
        var bulkaction = jQuery("[name=bulkaction]").val();
    }
    if (!bulkaction) {
        return false;
    }

    var params = {};
    params['modpage'] = 'billing';
    params['modsubpage'] = 'ajaxBulkAction';
    params['bulkaction'] = bulkaction;
    params['records'] = [];
    i = 0;
    jQuery.each(jQuery("[name^='checkrecord_']:checked").serializeArray(), function (k, v) {
        params['records'][i] = v.value;
        i++;
    });

    callback = function () {
        refreshTablePage('mgrecords');
    };
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#bulkactionresults"), true, false, false, callback);

}

function editProject(pid) {
    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=projects&modsubpage=edit&pid=' + pid;
}
function deleteProject(pid) {

    jQuery("#dialog-confirm").dialog({
        
        open:   function(){
                            var closeBtn = jQuery('.ui-dialog-titlebar-close');
                            jQuery( ".ui-dialog-titlebar-close" ).addClass( "ui-button ui-widget ui-state-default ui-corner-all ui-dialog-titlebar-close" );
                            closeBtn.find('#closeModalIcon').remove();
                            closeBtn.append('<span title="Close" id="closeModalIcon">x</span>\n\
                                                ');
                            
                        },
        resizable: false,
        modal: true,
        buttons: {
            "Delete": {
                text: 'Delete',
                class: 'btn btn-danger',
                click: function () {
                    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=projects&modsubpage=delete&pid=' + pid;
                }
            },
            "Cancel": {
                text: 'Cancel',
                class: 'btn',
                click: function () {
                    jQuery(this).dialog("close");
                }
            }
        }
    });
}


function approveTimeEntry(eid, fromdate)
{
    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=timesheet&modsubpage=approveTimeEntry&eid=' + eid + '&fromdate=' + fromdate;
}
function unapproveTimeEntry(eid, fromdate)
{

    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=timesheet&modsubpage=unapproveTimeEntry&eid=' + eid + '&fromdate=' + fromdate;
}


function editTask(tid) {
    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=tasks&modsubpage=edit&tid=' + tid;
}

function cancelTask(where) {

    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=' + where;
}

function backTicket(where) {

    window.location = 'supporttickets.php?action=view&id=' + where;
}

function editBilling(eid) {
    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=billing&modsubpage=edit&eid=' + eid;
}

function deleteTask(tid) {
    jQuery("#dialog-confirm").dialog({
        open:   function(){
                            var closeBtn = jQuery('.ui-dialog-titlebar-close');
                            jQuery( ".ui-dialog-titlebar-close" ).addClass( "ui-button ui-widget ui-state-default ui-corner-all ui-dialog-titlebar-close" );
                            closeBtn.find('#closeModalIcon').remove();
                            closeBtn.append('<span title="Close" id="closeModalIcon">x</span>\n\
                                                ');
                            
                        },
        resizable: false,
        modal: true,
        buttons: {
            "Delete": {
                text: 'Delete',
                class: 'btn btn-danger',
                click: function () {
                    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=tasks&modsubpage=delete&tid=' + tid;
                }
            },
            "Cancel": {
                text: 'Cancel',
                class: 'btn',
                click: function () {
                    jQuery(this).dialog("close");
                }
            }
        }
    });
}

function changeTaskStatus(stat, tid) {
    var params = {};
    params['modpage'] = 'tasks';
    params['modsubpage'] = 'ajaxTaskStatusChanged';
    params['tid'] = tid;
    params['status'] = stat;
    callback = function () {
        callRates();
    };
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#taskchangestatus" + tid), true, false, false, callback);

}

function editPredefinedTask(tid) {
    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=predefinedtasks&modsubpage=edit&tid=' + tid;
}
function deletePredefinedTask(tid) {
    jQuery("#dialog-confirm").dialog({
        
        open:   function(){
                            var closeBtn = jQuery('.ui-dialog-titlebar-close');
                            jQuery( ".ui-dialog-titlebar-close" ).addClass( "ui-button ui-widget ui-state-default ui-corner-all ui-dialog-titlebar-close" );
                            closeBtn.find('#closeModalIcon').remove();
                            closeBtn.append('<span title="Close" id="closeModalIcon">x</span>\n\
                                                ');
                            
                        },
        resizable: false,
        modal: true,
        buttons: {
            "Delete": {
                text: 'Delete',
                class: 'btn btn-danger',
                click: function () {
                    window.location = 'addonmodules.php?module=TimeTaskManager&modpage=predefinedtasks&modsubpage=delete&tid=' + tid;
                }
            },
            "Cancel": {
                text: 'Cancel',
                class: 'btn',
                click: function () {
                    jQuery(this).dialog("close");
                }
            }
        }
    });
}

jQuery('.info').tooltip();
function getTasksByProject(pid) {
    var params = {};
    params['modpage'] = 'timesheet';
    params['modsubpage'] = 'ajaxTaskSelect';
    params['pid'] = pid;
    callback = function () {
        callRates();
    };
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajax_taskselect"), true, false, false, callback);
}

function callRates(one, two) {
    getRateByTask(jQuery('#ttcSelectTasks').val());
}

function getRateByTask(tid) {
    var params = {};
    params['modpage'] = 'timesheet';
    params['modsubpage'] = 'ajaxRateSelect';
    params['tid'] = tid;
    params['curr'] = jQuery('input[name=curriences]').val();
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajax_rateselect"), true, false, false, false);
}

function saveMgAutoCreditApply() {
    var params = {};
    params['modpage'] = 'cron';
    params['modsubpage'] = 'ajaxSaveMgAutoCreditApply';
    params['mgAutoCreditApply'] = jQuery("select[name=mgAutoCreditApply]").val();
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajax_creditResult"), true, false, false);
}

function saveZeroInvoicesAction() {
    var params = {};
    params['modpage'] = 'cron';
    params['modsubpage'] = 'ajaxSaveZeroInvoicesAction';
    params['zeroInvoicesForPrePaid'] = jQuery("select[name=zeroInvoicesForPrePaid]").val();
    console.log(params);
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajax_iresult"), true, false, false);
}

function saveCronBillingAction(pid) {
    var params = {};
    params['modpage'] = 'cron';
    params['modsubpage'] = 'ajaxSaveBillingAction';
    params['billingaction'] = jQuery("select[name=billingaction]").val();
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajax_results"), true, false, false);

}

function saveCronCleaningAction(pid) {
    var params = {};
    params['modpage'] = 'cron';
    params['modsubpage'] = 'ajaxSaveCleaningAction';
    params['cleaningaction'] = jQuery("select[name=cleaningaction]").val();
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#ajax_results1"), true, false, false);

}

function ajaxCall(url, params, where, preloader, update, func, callback) {
    if (!params)
        var params = {};
    params['ajax'] = 1;
    if (preloader && where) {
        if (update)
            jQuery(where).append('<span id="ajax_updater"><img src="../modules/addons/TimeTaskManager/core/assets/img/preloader16.gif" /> Loading...</span>');
        else
            jQuery(where).html('<span id="ajax_updater"><img src="../modules/addons/TimeTaskManager/core/assets/img/preloader16.gif" /> Loading...</span>');
    }
    jQuery.post(url, params, function (data) {
        jQuery('#ajax_updater').remove();
        if (func) {
            func.call(null, data);
        } else if (where) {
            if (update)
                jQuery(where).append(data);
            else
                jQuery(where).html(data);
        }
        if (callback) {
            callback.call(null, data);
        }
        jQuery(".datepick").datepicker({
            dateFormat: datepickerformat
        });
    });
}

function confirmInvoice(eid) {
    jQuery("#ttcNewInvoiceDudate").attr('disabled', 'disabled');
    jQuery("#dialog-confirm").dialog({
        
        open:   function(){
                            var closeBtn = jQuery('.ui-dialog-titlebar-close');
                            jQuery( ".ui-dialog-titlebar-close" ).addClass( "ui-button ui-widget ui-state-default ui-corner-all  ui-dialog-titlebar-close" );
                            closeBtn.find('#closeModalIcon').remove();
                            closeBtn.append('<span title="Close" id="closeModalIcon">x</span>\n\
                                                ');
                            
                        },
        resizable: true,
        modal: true,
        buttons: {
            "Delete": {
                text: 'Invoice Now',
                class: 'btn btn-danger',
                click: function () {
                    var duedate = jQuery("#ttcNewInvoiceDudate").val();
                    var dateFormat = jQuery("#ttcNewInvoiceDudateFormat").val();

                    invoiceNow(eid, duedate, {dateFormat:dateFormat});
                    jQuery(this).dialog("close");
                }
            },
            "Cancel": {
                text: 'Cancel',
                class: 'btn',
                click: function () {
                    jQuery(this).dialog("close");
                }
            }
        }
    });
    jQuery("#ttcNewInvoiceDudate").removeAttr('disabled', 'disabled');
}

function bConfirmInvoices() {
    jQuery("#ttcNewBInvoiceDudate").attr('disabled', 'disabled');
    jQuery("#bdialog-confirm").dialog({
        
        open:   function(){
                            var closeBtn = jQuery('.ui-dialog-titlebar-close');
                            jQuery( ".ui-dialog-titlebar-close" ).addClass( "ui-button ui-widget ui-state-default ui-corner-all  ui-dialog-titlebar-close" );
                            closeBtn.find('#closeModalIcon').remove();
                            closeBtn.append('<span title="Close" id="closeModalIcon">x</span>\n\
                                                ');
                            
                        },
        resizable: true,
        modal: true,
        buttons: {
            "Delete": {
                text: 'Invoice Now',
                class: 'btn btn-danger',
                click: function () {
                    var duedate = jQuery("#ttcNewBInvoiceDudate").val();
                    bbulkAction('invoicenow', duedate);
                    jQuery(this).dialog("close");
                    refreshTable('mgrecords');
                }
            },
            "Cancel": {
                text: 'Cancel',
                class: 'btn',
                click: function () {
                    jQuery(this).dialog("close");
                }
            }
        }
    });
    jQuery("#ttcNewBInvoiceDudate").removeAttr('disabled', 'disabled');
}

function bbulkAction(action, duedate) {

    if (action) {
        var bulkaction = action;
    } else {
        var bulkaction = jQuery("[name=bulkaction]").val();
    }
    if (!bulkaction) {
        return false;
    }

    var params = {};
    params['modpage'] = 'billing';
    params['modsubpage'] = 'ajaxBulkAction';
    params['bulkaction'] = bulkaction;
    params['duedate'] = duedate;
    params['formatDueDate'] = jQuery("#ttcNewInvoiceDudateFormat").val();
    params['records'] = [];
    i = 0;
    jQuery.each(jQuery("[name^='checkrecord_']:checked").serializeArray(), function (k, v) {
        params['records'][i] = v.value;
        i++;
    });

    callback = function () {
        refreshTablePage('mgrecords');
    };
    ajaxCall("addonmodules.php?module=TimeTaskManager", params, jQuery("#bulkactionresults"), true, false, false, callback);

}
