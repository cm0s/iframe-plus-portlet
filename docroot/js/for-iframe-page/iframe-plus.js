/**
 * Copyright (c) 2011 Nicolas Forney (nicolas@eforney.com). Released under MIT
 * Licence.
 * 
 * This script requires easyXDM Javascript library.
 * 
 * This script must be loaded in the provider page (see project README.md for
 * more details).
 */

var socket = _activateAutoResize();

/**
 * Sends a message to the consumer page (parent page) with the current content
 * height which is used to resize the IFrame. This function is particularly
 * useful when dealing with AJAX content.
 */
function resizeIframe() {
	socket.postMessage(document.body.clientHeight || document.body.offsetHeight
			           || document.body.scrollHeight);
}

/**
 * Sends a message to the consumer page (parent IFrame page) indicating the
 * loading mask must be hidden.
 * This function is particularly useful when dealing with AJAX content.
 */
function hideLoadingMask() {
	socket.postMessage("hide-loading-manual");
}

/**
 * Create a new socket to communicate with the consumer page (parent IFrame
 * page).
 * 
 * @returns {easyXDM.Socket}
 */
function _activateAutoResize() {
	var _socket = new easyXDM.Socket({
		onReady : function() {
			resizeIframe();
			// Automatically resize iframe when page is resized
			$(window).resize(function() {
				resizeIframe();
			});
		}
	});
	return _socket;
}

/**
 * Automatically sends a message to hide loading mask when page finished loading
 */
$(window).load(function(){
	socket.postMessage("hide-loading-automatic");
});