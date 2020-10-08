<select name="hourlyrate" style="width:310px" id = "ttcSelectRates" {if !$extraRate || $extraRate == '0.00'} disabled {/if}>
    <option {if !$extraRate} selected {/if} value="">{$language->translate('Normal Rate')} {$cur.prefix}{$normalRate}{$cur.suffix}</option>
    <option value="1">{$language->translate('Extra Rate')} {$cur.prefix}{$extraRate}{$cur.suffix}</option>
</select>