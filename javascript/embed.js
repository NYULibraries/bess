/**
 * bobcat_embed_update: update the embed urls on each option change
 *
 * @param field					the field that has just changed
 * @param key						unique key to allow for multiple embeds
 */
function bobcat_embed_update(field,key) {
	var new_option = document.getElementById(field).options[document.getElementById(field).selectedIndex].value; //selected option
	var reg1 = new RegExp(field + "=.+?&"); //phrase in the middle of querystring
	var reg2 = new RegExp("&" + field + "=.+?$"); //phrase at end of querystring

  var bobcat_embed_base_url;
	//match either of the above regular expressions and replace the old field value with the new
	if (bobcat_embed_base_url.match(reg1) ) {
		bobcat_embed_base_url = bobcat_embed_base_url.replace(reg1,"") + "&" + field + "=" + new_option;
	} else if (bobcat_embed_base_url.match(reg2)) {
		bobcat_embed_base_url = bobcat_embed_base_url.replace(reg2,"") + "&" + field + "=" + new_option;
	}

	//Change include links
	document.getElementById('direct_url_content').innerHTML = bobcat_embed_base_url;
	document.getElementById('view_source_link').setAttribute("href", bobcat_embed_base_url + "&format=text");

	var js_code = '&lt;script type="text/javascript" charset="utf-8" src="' + bobcat_embed_base_url + '&format=embed_html_js"&gt;&lt;/script&gt;&lt;noscript&gt;&lt;a href="' + bobcat_embed_base_url + '"&gt;' + bobcat_embed_noscript_content + '&lt;/a&gt;&lt;/noscript&gt;';
	document.getElementById('js_widget_content').innerHTML = js_code;

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
		if (new_option == "false") {
			var bobcat_limit_to = document.getElementsByClassName('bobcat_embed_limit_to');
			for (var i=0;i<bobcat_limit_to.length;i++) {
				bobcat_limit_to[i].style.display = 'none';
			}
		} else {
			var bobcat_limit_to = document.getElementsByClassName('bobcat_embed_limit_to');
			for (var i=0;i<bobcat_limit_to.length;i++) {
				bobcat_limit_to[i].setAttribute('style','');
			}
		}

	}

	//update example by changing tab
	if (field == "disp_default_tab") {
		bobcat_embed_switch_tab(new_option + "_" + key, key);
  }

}

function bobcat_embed_submit_form(select) {
  document.form_generator.disp_default_tab.disabled = true;
  document.form_generator.submit();
}
