/**
 * Copyright (c) 2011 Nicolas Forney (nicolas@eforney.com). Released under MIT
 * Licence.
 * 
 * This script requires easyXDM Javascript library.
 * 
 * This script must be loaded in the provider page (see project README.md for
 * more details).
 */

var socket = getEasyXDMSocket();

/**
 * Return an easyXDM socket used to communicate with the consumer page (parent IFrame
 * page). If an IFrame+ helper already defined an easyXDM socket to communicate with
 * the consumer page, the helper socket is returned, otherwise a new socket is created.
 * 
 * @returns {easyXDM.Socket}
 */
function getEasyXDMSocket() {
	var iframeplusHelperSocket = parent.socket;
	if(iframeplusHelperSocket==undefined){
		return instanciateLocalSocket();
	}else{
		return iframeplusHelperSocket;
	}
}

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

function instanciateLocalSocket(){
	var socket = new easyXDM.Socket({
		onReady : function() {		
			resizeIframe();
			// Automatically resize iframe when page is resized
			$(window).resize(function() {
				resizeIframe();
			});
		}
	});
	return socket;
}

/**
 * Automatically sends a message to hide loading mask when page finish loading
 * Note: this message is taken into account by the consumer page (parent page), only
 * if the hide loading mask automatically is activated in the portlet configuration
 */
$(window).load(function(){
	socket.postMessage("hide-loading-automatic");
});