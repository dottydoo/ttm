<select name="task" onchange="getRateByTask(jQuery(this).val());" id = "ttcSelectTasks">
    {if $tasks}
        <optgroup label="Client's Tasks">
            {foreach from=$tasks item=t key=k}
                <option {if $smarty.post.task == $t.id || (!$smarty.post.task && $k == '0')} selected="selected"{/if} value="{$t.id}">{$t.name}</option>
            {/foreach}
        </optgroup>
    {/if}
    {if $predefined_tasks}
        <optgroup label="Create From Predefined Tasks">
            {foreach from=$predefined_tasks item=t}
                <option {if ($smarty.post.task == 'p-'|cat:$t.id)  || (!$smarty.post.task && !$tasks)} selected="selected"{/if} value="p-{$t.id}">{$t.name}</option>
            {/foreach}
        </optgroup>
    {/if}
</select>
