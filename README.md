IFrame+ (for Liferay portal)
==============================================
IFrame+ is a portlet developped for the Liferay portal. 

IFrame+ portlet main feature is its capability to automatically resized its
embedded IFrame even in cross-domain* configuration.

Other feature :
	* Possibility to activate a loading mask 

***Cross-domain resizing can be used only if you have access to the source
  of the IFrame content (Javascript and css styles must be added)**

Glossary
-------------------------------------------
**Consumer page** : page in which an iFrame is embedded.
**Provider page** : page included in the consumer IFrame.

Why use this portlet?
-------------------------------------------
Standard theme for Liferay portal use portlet with width defines in percentage. 
Thus, when browser window is resized in width by a user, text or other elements 
within portlets wrap and take more space in height to be display. 
For normal portlets, height is automatically modified to display all the 
content. To achieve the same objective a "Resize Automatically" option can be 
activated in the official Liferay IFrame portlet. However this option works only
if the page is located in the same domain. 

When the page to display through the portlet IFrame holds fixed width content
auto resize is not required because it's possible to manually define IFrame 
dimension (in pixel). However if content width is variable (set in percent) the 
only solution to be able to correctly display all the page content even when
browser width is resized is to use a scroll bar which is not really pretty 
and not ergonomic.

How it works
------------------------------------------
Due to browsers security policies, it's not possible to get access to an IFrame
content from its parent window when both documents are located in two different
domains. To overcome this restriction, different solutions exists, not always
quite obvious, especially when the solution must be cross-browser.

Here come the IFrame+ portlet which, with the use of the easyXDM 
Javascript library (http://easyxdm.net), brings a cross-browser easy to use
solution.

*EasyXDM definition : "At the core easyXDM provides a transport stack capable 
of passing string based messages between two windows, a consumer (the main 
document) and a provider (a document included using an iframe)."*

The easyXDM library integrated with this portlet use several techniques to make
the cross-domain communication needed for IFrame resize possible with a large
panel of browsers (IE6+, Firefox 1+, Chrome 2+, Safari 4+, Opera 9+).

To work some Javascript are needed on the consumer and on the provider page :
On the provider page (page displayed in the IFrame) with the use of Javascript 
a message is automatically sends to the consumer page (where IFrame tag is 
defined) whenever the provider page content is resized (for example, when user 
resizes browser width or when new content is dynamically added). On the 
consumer page some Javascript is used to listen to the message sent by the 
provider pages and when a new one is received change the IFrame dimension 
(the message contains the new page height). 

How to install Iframe+ portlet
===============================
###On the portal (consumer page)###
1. Deploy the portlet in your Liferay server (you can use the user interface or
   place the *.war file in the deploy folder for auto deploy.)
2. Add IFrame+ portlet to a page (the portlet is instanciable)
3. Set the IFrame web page URL in the configuration page of the portlet.

###On the provider page###
**1) Declare easyXDM.js and iframe-plus.js javascripts in the header of
   the page**

```html
  <script type="text/javascript" src="link/to/easyXDM.js"></script>
  <script type="text/javascript" src="link/to/iframe-plus.js"></script> 
```
   Javascript files can be found in **/docroot/js/for-iframe-page/iframe-plus.js**
   and **/docroot/js/easyxdm/easyXDM.js**
   
**2) Apply the following style to hide scollbar**

```css
  html, body {
	overflow: hidden;
	margin: 0px;
	padding: 0px;
  }
```
**3) (Optional) if consumer page use dynamic content you can use the 
   ``resizeIframe()`` function to indicates content has changed.**
   
   For example, if you load RSS fields using Javascript you can call 
   ``resizeIframe()`` function once all RSS entry are loaded or after each 
   new entry to make the iframe fits correctly with the added elements.

	```html
	 <script type="text/javascript"> 
	 	resizeIframe();
	 </script>
	```

Loading mask option
======================
The purpose of this option is to display a loading icon while the IFrame 
content is loading.

Depending on the provider page content the end of loading can or can not be
automatically detected.

If the "End loading: Automatically" option is checked, a message will be
automatically sent to the consumer page as soon as the static content 
of the provider page has been fully loaded (by using the jquery 
$(window).load method). 

If the "End loading: Manually" option is checked, a message to hide the 
loading mask must be manually added into the provider page. This option
is necessary when page load dynamic content which is still running even
after the static content have been fully loaded.

To manually hide the loading mask use the "hideLoadingMask()" function
defined in the "iframe-plus.js" script.

```html
 <script type="text/javascript"> 
 	hideLoadingMask();
 </script>
```

Internationalization (i18n)
===========================
Portlet is available in French and English.

New Language can easily be added by creating a *.properities file for the
language to support in the WEB-INF/src/content folder. Once created, the
new "Language" file must be declared in the WEB-INF/liferay-hook.xml file.

License
=======
IFrame+ portlet is distributed under the MIT license.

Author
============
**Developer**
Nicolas Forney (nicolas@eforney.com)


Credits
=============
Project used to develop IFrame+ :
	* jQuery [http://jquery.com](http://jquery.com/)
	* easyXDM [http://easyxdm.net](http://easyxdm.net/)
	* jquery-loadmask [http://code.google.com/p/jquery-loadmask/](http://code.google.com/p/jquery-loadmask/)
	* Liferay [http://www.liferay.com](http://www.liferay.com)
