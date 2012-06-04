/**
 * This script requires easyXDM Javascript library.
 * 
 * This script must be loaded in the IFrame+ intermediary page (see IFrame+ project README.md
 * for more details).
 */

var socket;


/**
 * Sends a message to the consumer page (parent page) with the current content
 * height which is used to resize the IFrame. This function is particularly
 * useful when dealing with AJAX content.
 */
function createEasyXDMSocket(swfPath){
	socket = new easyXDM.Socket({
					swf: swfPath,                       
					onReady: function(){
						iframe = document.createElement('iframe');
						iframe.id = 'iframeplus';
						iframe.frameBorder = 0;
						document.body.appendChild(iframe);
						iframe.src = easyXDM.query.url;
					},
					onMessage: function(url, origin){
						iframe.src = url;
					}
				}); 
}