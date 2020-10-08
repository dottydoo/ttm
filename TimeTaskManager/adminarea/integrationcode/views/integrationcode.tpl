<h2>{$language->translate('BuyButonConfiguration')}</h2>
<br>
<div>
    <form action="" method="post">
        <fieldset>
            <table class="table table-bordered table-striped">
                <tbody>
                    <tr>
                        <td style="width:300px;">{$lang.BuyButonConfigurationL1}</td>
                        <td>
                            <select name="buyHoursProduct" style="width:310px" {if $ttcCustomProductPatch} disabled {/if}>
                                <option value="-1">---</option>
                                {foreach from=$ttcProducts key=gname item=p}
                                    <optgroup label="{$gname}">
                                        {foreach from=$p key=k item=pr}  
                                            <option {if $ttcCustomProductId == $pr['id']} selected="selected"{/if} value="{$pr['id']}">{$pr['name']}</option>
                                        {/foreach}
                                    {/foreach}
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:300px;">{$lang.BuyButonConfigurationL2}</td>
                        <td>
                            <input type="text" class="width300 padding4" name="buyHoursProductPath" value="{$ttcCustomProductPatch}" />&nbsp;<span class="currencycode"></span>
                        </td>
                    </tr> 
                </tbody>
            </table>    
            <input type="hidden" name="do" value="save" />
            <input type="submit" value="{$language->translate('saveChangesBtn')}" class="btn btn-success" style="height:34px;" />
        </fieldset>
    </form>
</div>
<br>
<h2>{$language->translate('Client Area Integration Code')}</h2>
<div style="margin-top: 5px;">
    <b>{$language->translate('Template five:')}</b> <br>
    <p>{$language->translate('In order to enable Time Tracking Center client area features, open')}:
    <pre>&lt;whmcs_path&gt;/templates/five/clientareahome.tpl</pre> 
    {$language->translate('Add this code')}: 
    <pre>{literal}{include file=$template|cat:'/ttc_homepage.tpl'}{/literal}</pre> 
    {$language->translate('In the line 128, above')} <pre>{literal}{if in_array('invoices',$contactpermissions)}{/literal}</pre>
    <p>{$language->translate('Correctly placed integration code should look similar to image below')}:</p>
    <img src="../modules/addons/TimeTaskManager/core/assets/img/integration_placed.png"><br><br><br>


    <b>{$language->translate('Template six:')}</b> <br>
    <p>{$language->translate('In order to enable Time Tracking Center client area features, open')}:
    <pre>&lt;whmcs_path&gt;/templates/six/clientareahome.tpl</pre>
    {$language->translate('Add this code')}: 
    <pre>{literal}{include file=$template|cat:'/ttc_homepage.tpl'}{/literal}</pre> 
    {$language->translate('In the line 144, before last')} <pre>{literal}&lt;/div&gt;{/literal}</pre>
    <p>{$language->translate('Correctly placed integration code should look similar to image below')}:</p>
    <img src="../modules/addons/TimeTaskManager/core/assets/img/integration_placed_six.png">

    </p>
    <br />
    <b>{$language->translate('Closed Tasks:')}</b> <br>
    <p>{$language->translate('Same for six and five templates. In order to enable Time & Task Manager client area features, open')}:
    <pre>&lt;whmcs_path&gt;/templates/six/clientareahome.tpl</pre>
    {$language->translate('Add this code, just below previous integration code')}: 
    <pre>{literal}{include file=$template|cat:'/ttc_homepageClosed.tpl'}{/literal}</pre> 
</div>
