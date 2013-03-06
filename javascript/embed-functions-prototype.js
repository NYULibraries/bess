/*
 * REQUIRES PROTOTYPE.JS
 */

/**
 * bobcat_embed_switch_tab: manipulate styles to change tabs to tab_id
 *
 * @param tab_id				id of tab to change to
 * @param key						unique key to allow for multiple embeds
 */
function bobcat_embed_switch_tab(tab_id,key) {
	//hide each tab
	$$('div.bobcat_embed_tab_content_' + key).each(Element.hide);
	//remove the selected tab class where it exists
	$$('li.bobcat_embed_tabs_selected_' + key).each(function(el, index) { $(el).removeClassName('bobcat_embed_tabs_selected');$(el).removeClassName('bobcat_embed_tabs_selected_'+key); });
	//add selected tab class to the new tab
	$$('li#' + tab_id).each(function(el, index) { $(el).addClassName('bobcat_embed_tabs_selected');$(el).addClassName('bobcat_embed_tabs_selected_'+key); });
	//show new tab
	tab_id_complete = "bobcat_embed_tab_content_" + tab_id;
	$(tab_id_complete).show();
}


/**
 * bobcat_embed_update: update the embed urls on each option change
 *
 * @param field					the field that has just changed
 * @param key						unique key to allow for multiple embeds
 */
function bobcat_embed_update(field,key) {
	var new_option = $(field).options[$(field).selectedIndex].value; //selected option
	var reg1 = new RegExp(field + "=.+?&"); //phrase in the middle of querystring
	var reg2 = new RegExp("&" + field + "=.+?$"); //phrase at end of querystring
	
	//match either of the above regular expressions and replace the old field value with the new
	if (bobcat_embed_base_url.match(reg1) ) {
		bobcat_embed_base_url = bobcat_embed_base_url.replace(reg1,"") + "&" + field + "=" + new_option;
	} else if (bobcat_embed_base_url.match(reg2)) {
		bobcat_embed_base_url = bobcat_embed_base_url.replace(reg2,"") + "&" + field + "=" + new_option;
	}

	//Change include links
	$('direct_url_content').update(bobcat_embed_base_url);
	$('view_source_link').writeAttribute("href", bobcat_embed_base_url + "&format=text");
	
	var js_code = '&lt;script type="text/javascript" charset="utf-8" src="' + bobcat_embed_base_url + '&format=embed_html_js"&gt;&lt;/script&gt;&lt;noscript&gt;&lt;a href="' + bobcat_embed_base_url + '"&gt;' + bobcat_embed_noscript_content + '&lt;/a&gt;&lt;/noscript&gt;';
	$('js_widget_content').update(js_code);

	//update example
	bobcat_embed_update_example(field,new_option,key);
}


/**
 * bobcat_embed_update_example: update the embedded example in the generator page
 *
 * @param field					the field that has just changed
 * @param new_option		the new option that was selected on change
 * @param key						unique key to allow for multiple embeds
 */
function bobcat_embed_update_example(field,new_option,key) {
	
	//update example by showing or hiding Limit To options
	if (field == "disp_show_limit_to") {
		if (new_option == "false")
			$$('div.bobcat_embed_limit_to').each(function(el,index) { $(el).writeAttribute('style','display:none;'); });
		else
			$$('div.bobcat_embed_limit_to').each(function(el,index) { $(el).writeAttribute('style',''); });
	}
	
	//update example by changing tab
	if (field == "disp_default_tab") 
		bobcat_embed_switch_tab(new_option + "_" + key,key);
		
}

function bobcat_embed_submit_form(select) {
	document.form_generator.disp_default_tab.disabled = true;
	document.form_generator.submit();
}