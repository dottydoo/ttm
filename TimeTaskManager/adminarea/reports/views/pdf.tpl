{literal}
    <style type="text/css">
        .infotable{
            font-size: 12px;
        }
        .infotable td.label{
            width:100px;
            text-align:right;
            color:gray
        }
        .reporttable{
            font-size: 10px;
        }
        .reporttable th{
            font-size: 10px;
            background-color: gainsboro;
            line-height: 16px;
        }
        .reporttable td{
            line-height: 20px;
        }
        .textright{
            text-align: right;
        }
        .day td{
            border-bottom: 1px solid gray;
        }
        .col0{
            width:1px;
        }
        .col1{
            width:350px;
        }
        .col2{
            width:150px;
        }
        .thead th{
            border-bottom: 1px solid gray;
        }
        .thead .col1{
            border-right: 1px solid gray;
        }
        .task td,.timeentry td{
            border-bottom: 1px solid #E0E0E0;
        }
        .timeentry{
            font-style: italic;
        }
        .descmargin {
            width:20px;
        }
        .clientmargin{
            width:10px;
        }
        .desc{
            width:330px;
        }
        .clientname{
            width:340px;
        }
    </style>
{/literal}
<h1>{$title}</h1>
<br />
<table class="infotable">
    {if $client}
        <tr>
            <td class="label">{$language->translate('Projects for client')}</td>
            <td>{$client}</td>
        </tr>
    {/if}
    {if $admin}
        <tr>
            <td class="label">{$language->translate('Entries by admin')}</td>
            <td>{$admin}</td>
        </tr>
    {/if}
    <tr>
        <td class="label">{$language->translate('Time interval')}</td>
        <td>{$fromdate} - {$todate}</td>
    </tr>
</table>
<br /><br />
<table class="reporttable">
    <tr class="thead">
        <th class="col0"></th>
        <th class="col1"><strong>{$language->translate('Total')}</strong></th>
        <th class="col2 textright"><strong>{$data.total}</strong></th>
    </tr>
    {foreach from=$data.days item=day key=date}
        <tr class="day">
            <td class="datemargin"></td>
            <td><strong>{$date}</strong></td>
            <td class="textright"><strong>{$day.total}</strong></td>
        </tr>
        {foreach from=$day.tasks item=task key=task_id}
            <tr class="task">
                <td class="clientmargin"></td>
                <td class="clientname">{if !$client}{assign var="cid" value=$task.client_id}<strong>{$clients.$cid.firstname} {$clients.$cid.lastname}</strong> - {/if}{$task.name} </td>
                <td class="textright">{$task.total}</td>
            </tr>
            {foreach from=$task.entries item=entry key=entry_id}
                <tr class="timeentry">
                    <td class="descmargin"></td>
                    <td class="desc">{if !$admin}{assign var="aid" value=$entry.admin_id}{$admins.$aid} - {/if}{$entry.description} {if $settings[0] eq 1}({$entry.prefix} {$entry.price} {$entry.suffix}/h){/if}{if $settings[3] == 'true' && $entry.approved eq '0'} <i>   (Not Billable)</i> {/if}</td>
                    <td class="textright">{$entry.hours} {if $settings[1] eq 1}({$entry.prefix} {$entry.fulcost} {$entry.suffix}){/if}</td>
                </tr>
            {/foreach}
        {/foreach}
    {foreachelse}
        <tr colspan="2">
            <td>{$language->translate('No Data Available In The Date Range')}</td>
        </tr>
    {/foreach}
    <tr class="thead">
        <th class="col1"><strong>{$language->translate('Total')}</strong></th>
        <th class="col2 textright"><strong>{$data.total}</strong></th>
    </tr>
    {if $settings[2] eq 1}
        {foreach from=$data.totalcost item=cost key=suffix}
            <tr class="thead">
                <th class="col1"><strong>{$language->translate('FullCost')} {$suffix}</strong></th>
                <th class="col2 textright"><strong> {$cost} {$suffix} </strong></th>
            </tr>
        {/foreach}
    {/if}
</table>

