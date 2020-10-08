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
                                <option value="">---</option>
                                {foreach from=$ttcProducts key=gname item=p}
                                    <optgroup label="{$gname}">
                                        {foreach from=$p key=k item=pr}  
                                            <option {if $ttcCustomProductId === $pr.id} selected="selected"{/if} value="{$pr.id}">{$pr.name}</option>
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
    <p>{$language->translate('In order to enable Time Tracking Center client area features, open')}:<pre>clientareahome.tpl</pre> {$language->translate('Located at')}: <pre>&lt;whmcs_path&gt;/templates/default/</pre> {$language->translate('Add this code')}: <pre>{literal}{include file=$template|cat:'/ttc_homepage.tpl'}{/literal}</pre> {$language->translate('In the line 128 above')} <pre>{literal}{if in_array('invoices',$contactpermissions)}{/literal}</pre></p>
</div>
<div>
    <p>{$language->translate('Correctly placed integration code should look similar to image below')}:</p>
    <img src="../modules/addons/TimeTaskManager/core/assets/img/integration_placed.png">
</div>
<br />
<div>        
    <b>{$language->translate('Closed Tasks:')}</b> <br>
    <p>{$language->translate('In order to enable Time Tracking Center client area features, open')}:
    <pre>clientareahome.tpl</pre>
    {$language->translate('Located at')}: <pre>&lt;whmcs_path&gt;/templates/default/</pre>
    {$language->translate('Add this code, just below previous integration code')}: 
    <pre>{literal}{include file=$template|cat:'/ttc_homepageClosed.tpl'}{/literal}</pre>     
</div>