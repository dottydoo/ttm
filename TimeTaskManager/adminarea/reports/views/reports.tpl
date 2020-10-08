
{literal}
    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery(".dateinput").datepicker({
                dateFormat: '{/literal}{$dateFormatPicker}{literal}',
                onSelect: function (dateText, inst) {
                }
            });
            jQuery(".basic-multiple").select2({
            });
        });

    </script>
{/literal}





<form action="addonmodules.php?module=TimeTaskManager&modpage=reports&modsubpage=pdf" method="get" target="_blank">
    <input type="hidden" name="module" value="TimeTaskManager" />
    <input type="hidden" name="modpage" value="reports" />
    <input type="hidden" name="modsubpage" value="pdf" />
    <table class="table table-bordered table-striped">
        <tr>
            <th colspan="2">{$language->translate('Report Data')}</th>
        </tr>
        <tr>
            <td>{$language->translate('Title')}</td>
            <td>
                <input name="title" value="" style="width:" maxlength="50"/>
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Date Range')}</td>
            <td>
                <input class="dateinput" name="fromdate" value="{$fromdate}" />
                to
                <input class="dateinput" name="todate" value="{$todate}" />
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Client')}</td>
            <td>
                <select name="client" class="basic-multiple">
                    <option value="">{$language->translate('All Clients')}</option>
                    {foreach from=$clients item=c}
                        <option value="{$c.id}">{$c.firstname} {$c.lastname} {if $c.companyname}({$c.companyname}){/if}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Admin')}</td>
            <td>
                {if !$administrator && !in_array('reportotheradmins',$access)}
                    {assign var="admin_id" value=$smarty.session.adminid}
                    <select disabled>
                        <option>{$admins.$admin_id}</option>
                    </select>
                {else}
                    <select name="admin" class="basic-multiple">
                        <option value="">{$language->translate('All Admins')}</option>
                        {foreach from=$admins key=aid item=admin}
                            <option {if $admin_id == $aid} selected {/if} value="{$aid}">{$admin}</option>
                        {/foreach}
                    </select>
                {/if}
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Sort Order')}</td>
            <td>
                <select name="sortorder" class="basic-multiple">
                    <option value="1">{$language->translate('Sort by task date')}</option>
                    <option value="">{$language->translate('Sort accordig to added tasks order')}</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Show_not_approved_Time')}</td>
            <td>
                <input name="notapproved" type="checkbox" value="1" >
            </td>
        </tr>
        <tr>
            <td>{$language->translate('Show_hours_price')}</td>
            <td>
                <input name="hourprice" type="checkbox" value="1" >
            </td>
        </tr>     
        <tr>
            <td style="width: 250px;">{$language->translate('Show_price_per_time_entry')}</td>
            <td>
                <input name="entryprice" type="checkbox" value="1" checked>
            </td>
        </tr>     
        <tr>
            <td>{$language->translate('Show_full_price')}</td>
            <td>
                <input name="fullprice" type="checkbox" value="1"  checked>
            </td>
        </tr>

    </table>
    <input onclick="" type="submit" value="{$language->translate('Generate PDF Report')}" class="btn btn-success" style="height:34px;" />
</form>




