/**
 * bobcat_embed_switch_tab: manipulate styles to change tabs to tab_id
 *
 * @param tab_id			id of tab to change to
 * @param key						unique key to allow for multiple embeds
 */
function bobcat_embed_switch_tab(tab_id,key) {
	//hide each tab
	var bobcat_tabs = document.getElementsByClassName(`bobcat_embed_tab_content_${key}`);
	for (var i=0;i<bobcat_tabs.length;i++) {
		bobcat_tabs[i].style.display = 'none';
    bobcat_tabs[i].setAttribute('aria-hidden', 'true');
	}
	//remove the selected tab class where it exists
	var bobcat_tab_selected = document.getElementsByClassName(`bobcat_embed_tabs_selected_${key}`);
	for (var i=0;i<bobcat_tab_selected.length;i++) {
		bobcat_tab_selected[i].classList.remove('bobcat_embed_tabs_selected', `bobcat_embed_tabs_selected_${key}`);
	}
	//add selected tab class to the new tab
	document.getElementById(tab_id).classList.add('bobcat_embed_tabs_selected',`bobcat_embed_tabs_selected_${key}`);
	//show new tab
	var tab_id_complete = "bobcat_embed_tab_content_" + tab_id;
	document.getElementById(tab_id_complete).style.display = 'block';
  document.getElementById(tab_id_complete).setAttribute('aria-hidden', 'false');
}
