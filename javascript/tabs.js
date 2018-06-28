/**
 * bobcat_embed_switch_tab: manipulate styles to change tabs to tab_id
 *
 * @param tab_id    id of tab to change to
 * @param key       unique key to allow for multiple embeds
 */
function bobcat_embed_switch_tab(tab_id,key) {
	// Hide all tabpanels for this key
	var bobcat_tabpanels = document.getElementsByClassName(`bobcat_embed_tab_content_${key}`);
	var bobcat_previously_selected_tabpanel;
	for (var i=0;i<bobcat_tabpanels.length;i++) {
		bobcat_previously_selected_tabpanel = bobcat_tabpanels[i];
		bobcat_previously_selected_tabpanel.style.display = 'none';
		bobcat_previously_selected_tabpanel.setAttribute('aria-hidden', 'true');
	}
	// Unselect previous tab
	var bobcat_previously_selected_tab = document.getElementsByClassName(`bobcat_embed_tabs_selected_${key}`)[0];
	bobcat_previously_selected_tab.classList.remove('bobcat_embed_tabs_selected', `bobcat_embed_tabs_selected_${key}`);
	bobcat_previously_selected_tab.setAttribute('aria-selected', 'false');
	// Select current tab
	var bobcat_selected_tab = document.getElementById(tab_id);
	bobcat_selected_tab.classList.add('bobcat_embed_tabs_selected',`bobcat_embed_tabs_selected_${key}`);
	bobcat_selected_tab.setAttribute('aria-selected', 'true');
	// Show new tabpanel
	var bobcat_seleced_tabpanel = document.getElementById(`bobcat_embed_tab_content_${tab_id}`);
	bobcat_seleced_tabpanel.style.display = 'block';
	bobcat_seleced_tabpanel.setAttribute('aria-hidden', 'false');
}
