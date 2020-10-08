<select name="changestatus" onchange="changeTaskStatus(jQuery(this).val(),{$tid});" style="width:150px">
    <option {if $status == 'Pending'} selected="selected"{/if} value="pending">Pending</option>
    <option {if $status == 'In Progress'} selected="selected"{/if} value="inprogress">In Progress</option>
    <option {if $status == 'Closed'} selected="selected"{/if} value="closed">Closed</option>
</select><br>
<span id="taskchangestatus{$tid}" style="width:150px"></span>
