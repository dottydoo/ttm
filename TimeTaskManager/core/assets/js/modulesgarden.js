
jQuery(function ()
{
    jQuery('section [href^="#"]').click(function (e) {
        e.preventDefault()
    });

    jQuery(".btn-delete").click(function (event)
    {
        return confirm("Are you sure you want to procced?");
    });

    jQuery('.tooltip-box').tooltip({
        selector: "a[rel=tooltip]",
        delay: {show: 0, hide: 0}
    });

    //We don't want jQuery buttons!
    var options = {
        buttons: {}
    };
    jQuery('.body button').button("destroy");

});

/****************************
 *          PAGINATION
 *****************************/

/**
 * Get paginaton and insert it!
 **/
function getPagination(parent)
{
    jQuery.get(document.location, "ajax=1&pagination=1&get=1&parent=" + parent, function (data) {
        form = jQuery("form.pagination input[name$=\"parent\"][value$=\"" + parent + "\"]").parents("div.pagination");
        jQuery(form).html(data);
        jQuery("div.pagination a").click(onClickPagination);
    });
}

function resetPagination(parent)
{

}

function onClickPagination(event)
{
    event.preventDefault();
    if (jQuery(this).parent().hasClass('disabled'))
    {
        return;
    }

    href = jQuery(this).attr("href");
    href = href.substring(1);
    vars = href.split('&');
    parent = vars[1].split('=');
    parent = parent[1];
    pagination = jQuery(this).closest('div.pagination');

    jQuery.get(document.location, "ajax=1&pagination=1&" + href, function (data)
    {
        jQuery("#" + parent + " tbody").html(data);
        getPagination(parent);
    });
}




/****************************
 *          FILTERING
 ***************************/
function enableFiltering()
{
    form = jQuery(this).parents('form.filtering');
    parent = jQuery(form).children("input[name$=\"parent\"]").val();

    jQuery(this).addClass("hide");
    jQuery(form).children(".disable-filtering").removeClass("hide");

    jQuery("form.filtering-options input[name$=\"parent\"][value$=\"" + parent + "\"]").parents('.filtering-options').parent().parent().removeClass("hide");
}

function disableFiltering()
{
    form = jQuery(this).parents('form.filtering');
    parent = jQuery(form).children("input[name$=\"parent\"]").val()

    jQuery(this).parent().children(".enable-filtering").removeClass("hide");
    jQuery(this).addClass("hide");
    jQuery(this).parent().parent().next().addClass("hide");

    resetFiltering(parent);
    getPagination(parent)
}


/**
 * Disable filtering and get new content!
 **/
function resetFiltering(parent)
{
    jQuery.get(document.location, "ajax=1&pagination=1&reset=1&parent=" + parent, function (data) {
        jQuery("#" + parent).html(data);
    });
}

function addKeyPressEvent()
{
    var timeout_id = 0;

    parent = jQuery(this).parents(".filtering-options");
    parent_name = jQuery(parent).find('input[name$="parent"]').val();
    clearTimeout(timeout_id);
    timeout_id = setTimeout(function () {
        jQuery.get(document.location, "ajax=1&pagination=1&" + jQuery(parent).serialize(), function (data) {
            jQuery("#" + parent_name + " tbody").html(data);
            getPagination(parent_name);
        });
    }, 500);
}

function enableOrderBy(event)
{
    parent = jQuery(this).parents('table.pagination').attr('id');
    event.preventDefault();
    href = jQuery(this).attr("href");
    order_by = href.substring(1);

    jQuery.get(document.location, "ajax=1&pagination=1&order_by=" + order_by + "&parent=" + parent, function (data)
    {
        jQuery("#" + parent + " tbody").html(data);
    });
}

jQuery(function ()
{
    //FIND PAGINATION AND ADD EVENTS
    jQuery("div.pagination a").click(onClickPagination);

    //BIND KEY PRESS EVENT FOR FILTERING
    jQuery(".filtering-options input").keypress(addKeyPressEvent);

    //BIND TABLE HEADER
    jQuery("table.pagination thead a").click(enableOrderBy);
});
