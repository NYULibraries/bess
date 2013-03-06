/**
 * bobcat_embed_switch_tab: manipulate styles to change tabs to tab_id
 *
 * @param tab_id			id of tab to change to
 * @param key						unique key to allow for multiple embeds
 */
function bobcat_embed_switch_tab(tab_id,key) {
	//hide each tab
	var bobcat_tabs = bobcat_embed_get_els_by_class('div','bobcat_embed_tab_content_' + key);
	for (var i=0;i<bobcat_tabs.length;i++) {
		bobcat_tabs[i].style.display = 'none';
	}
	//remove the selected tab class where it exists
	var bobcat_tab_selected = bobcat_embed_get_els_by_class('li','bobcat_embed_tabs_selected_' + key);
	for (var i=0;i<bobcat_tab_selected.length;i++) {
		bobcat_tab_selected[i].bobcat_embed_remove_class_name('bobcat_embed_tabs_selected');
		bobcat_tab_selected[i].bobcat_embed_remove_class_name('bobcat_embed_tabs_selected_' + key);
	}
	//add selected tab class to the new tab
	document.getElementById(tab_id).bobcat_embed_add_class_name('bobcat_embed_tabs_selected');
	document.getElementById(tab_id).bobcat_embed_add_class_name('bobcat_embed_tabs_selected_' + key);
	//show new tab
	tab_id_complete = "bobcat_embed_tab_content_" + tab_id;
	document.getElementById(tab_id_complete).style.display = 'block';
}


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
			var bobcat_limit_to = bobcat_embed_get_els_by_class('div','bobcat_embed_limit_to');
			for (var i=0;i<bobcat_limit_to.length;i++) {
				bobcat_limit_to[i].style.display = 'none';
			}
		} else {
			var bobcat_limit_to = bobcat_embed_get_els_by_class('div','bobcat_embed_limit_to');
			for (var i=0;i<bobcat_limit_to.length;i++) {
				bobcat_limit_to[i].setAttribute('style','');
			}
		}			
			
	}
	
	//update example by changing tab
	if (field == "disp_default_tab") 
		bobcat_embed_switch_tab(new_option + "_" + key, key);
		
}

function bobcat_embed_submit_form(select) {
	document.form_generator.disp_default_tab.disabled = true;
	document.form_generator.submit();
}

function bobcat_embed_get_els_by_class(tag, searchClass) {
	var classElements = new Array();
	var node = document;
	var els = node.getElementsByTagName(tag);
	var elsLen = els.length;
	var pattern = new RegExp("(^|\\s)"+searchClass+"(\\s|$)");
	for (i = 0, j = 0; i < elsLen; i++) {
		if ( pattern.test(els[i].className) ) {
			classElements[j] = els[i];
			j++;
		}
	}
	return classElements;
}

/**
 * bobcat_embed_has_class_name
 *
 * Returns boolean indicating whether the object has the class name;
 *    built with the understanding that there may be multiple classes
 *
 * @strClass                class name to add
 **/ 
Element.prototype.bobcat_embed_has_class_name = function (strClass) {

	// if there is a class
	if ( this.className ) {
		
			// the classes are just a space separated list, so first get the list
			var arrList = this.className.split(' ');
			// get uppercase class for comparison purposes
			var strClassUpper = strClass.toUpperCase();

			// find all instances and remove them
			for ( var i = 0; i < arrList.length; i++ ) {
				// if class found
				if ( arrList[i].toUpperCase() == strClassUpper ) {
					// we found it
					return true;
				}
			}
						
		}
   // if we got here then the class name is not there
   return false;
}

/**
 * bobcat_embed_add_class_name
 *
 * Adds a class to the class attribute of a DOM element;
 *    built with the understanding that there may be multiple classes
 *
 * @strClass                 class name to add
 **/
Element.prototype.bobcat_embed_add_class_name = function (strClass) {	
	// if there is a class
	if ( this.className ) {
		// the classes are just a space separated list, so first get the list
		var arrList = this.className.split(' ');

		// if the new class name may already exist in list
		if ( ! this.bobcat_embed_has_class_name(strClass) ) {
			// add the new class to end of list
			arrList[arrList.length] = strClass;

			// assign modified class name attribute
			this.className = arrList.join(' ');
		}
	// if there was no class
	} else {
		// assign modified class name attribute      
		this.className = strClass;
	}
}


/** 
 * bobcat_embed_remove_class_name
 *
 * Removes a class from the class attribute of a DOM element;
 *	built with the understanding that there may be multiple classes
 *
 * @strClass							class name to remove
 **/
Element.prototype.bobcat_embed_remove_class_name = function (strClass) {	

   // if there is a class
   if ( this.className ) {

      // the classes are just a space separated list, so first get the list
      var arrList = this.className.split(' ');

      // get uppercase class for comparison purposes
      var strClassUpper = strClass.toUpperCase();

      // find all instances and remove them
      for ( var i = 0; i < arrList.length; i++ )  {
         // if class found
         if ( arrList[i].toUpperCase() == strClassUpper ) {
            // remove array item
            arrList.splice(i, 1);
            // decrement loop counter as we have adjusted the array's contents
            i--;
          }
      }

      // assign modified class name attribute
      this.className = arrList.join(' ');

   }
   // if there was no class
   // there is nothing to remove
}