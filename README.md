IFrame+ (for Liferay portal)
==============================================
IFrame+ is a portlet developed for the Liferay portal. 

As the official Liferay Iframe portlet, the IFrame+ portlet makes possible 
to embed another web page inside the portlet. Navigation through the embedded
page is then possible without loosing the context of the portal page.

What makes IFrame+ special and really useful is its capability to automatically 
resize its embedded IFrame in cross-domain* configuration where the official
Liferay plugin only makes it possible for web page contained in the same domain.

The IFrame+ portlet also add a loading mask option.


_*Cross-domain resizing can be used only if you have access to the source
  of the IFrame content (Javascript and CSS styles must be added)_
  
  
Screenshots  
-------------------------------------------
###Web page embedded into the portlet
![Front page](https://github.com/cm0s/iframe-plus-portlet/raw/develop/docroot/doc/images/iframe-plus-front.png)

###IFrame+ portlet configuration options
![Configuration options](https://github.com/cm0s/iframe-plus-portlet/raw/develop/docroot/doc/images/iframe-plus-config.png)

###IFrame+ portlet optional loading mask
![Loading mask](https://github.com/cm0s/iframe-plus-portlet/raw/develop/docroot/doc/images/iframe-plus-loading.png)

Glossary
-------------------------------------------
**Consumer page**: page in which an iFrame is embedded.

**Provider page**: page included in the consumer IFrame.

Why use this portlet?
-------------------------------------------
Standard theme for Liferay portal use portlet with width defines in percentage. 
Thus, when the browser window is resized in width by a user, text or other 
elements within portlets wrap and take more space in height to be display. 
For normal portlets, height is automatically modified to display all the 
content. To achieve the same objective a "Resize Automatically" option can be 
activated in the official Liferay IFrame portlet. However, this option works 
only if the page is located in the same domain. 

When the page to display through the portlet IFrame holds fixed width content
auto resize is not required because it's possible to manually define IFrame 
dimension (in pixel). However, if content width is variable (set in percent) 
the only solution to be able to display correctly all the page content even 
when browser width is resized is to use a scroll bar which is not really 
pretty and not ergonomic.

How it works
------------------------------------------
Due to browsers' security policies, it's impossible to get access to an 
IFrame content from its parent window when both documents are located in two 
different domains. To overcome this restriction, different solutions exist, 
not always quite obvious, especially when the solution must be cross-browser.

Here come the IFrame+ portlet which, with the use of the easyXDM 
Javascript library (http://easyxdm.net), brings a cross-browser easy to use
solution.

*EasyXDM definition : "At the core easyXDM provides a transport stack capable 
of passing string based messages between two windows, a consumer (the main 
document) and a provider (a document included using an iframe)."*

The easyXDM library integrated with this portlet use several techniques to make
the cross-domain communication needed for IFrame resize possible with a large
panel of browsers (IE6+, Firefox 1+, Chrome 2+, Safari 4+, Opera 9+).

To work, some Javascripts are needed on the consumer and on the provider page:
On the provider page (page displayed in the IFrame) with the use of Javascript 
a message is automatically sent to the consumer page (where IFrame tag is 
defined) whenever the provider page content is resized (for example, when a 
user resizes its browser width or when a new content is dynamically added). On the 
consumer page, some Javascript is used to listen to the message sent by the 
provider pages and when a new one is received it changes the IFrame dimension 
(the message contains the new page height). 

Choose your configuration
------------------------------------------
There is two ways to configure the Iframe+ portlet. The first configuration which
is also the simplest is intended only for single page web site (where there is no 
inner navigation to other pages). The second one is intended for the web site where 
inner navigation to other pages is possible.

### Configuration n°1 - for web site without inner navigation
When the Provider page is a web site where only one page is displayed (the inner 
window is not navigable). The simple configuration can be used.

The following schema shows how the provider page hosted in the iFrame+ portlet interacts
with the Consumer page in the simple configuration. 

![IFrame+ schema no navigation](https://github.com/cm0s/iframe-plus-portlet/raw/develop/docroot/doc/images/iframe-plus-without-intermediary.jpg)

### Configuration n°2 - for web site with inner navigation
When on the Provider side the inner window is navigable (user can navigate through
multiple pages), the simple configuration won't work because navigating to another page
will break the socket connection made on the home page and therefore subsequent pages won't 
be able to communicate with the Consumer socket anymore.

For this reason another configuration must be used. This configuration add an intermediary 
page which keeps the socket connection opened with the Consumer page. 

The following schema shows how this configuration is implemented.

![IFrame+ schema no navigation](https://github.com/cm0s/iframe-plus-portlet/raw/develop/docroot/doc/images/iframe-plus-with-intermediary.jpg)

It's up to you to choose one of these two configurations depending on your need.

How to install Iframe+ portlet 
===============================
###Intallation for Configuration n°1 (web site without inner navigation)
#####On the portal (consumer page)
1. Deploy the portlet in your Liferay server (you can use the user interface or
   place the *.war file in the deploy folder for auto deploy.)
2. Add IFrame+ portlet to a page (the portlet is instanciable and thus can be added multiple time to a page)
3. Set the IFrame web page URL in the configuration page of the portlet.

#####On the provider page
**1) Declare easyXDM.js and iframeplus-provider.js javascripts in the header of
   the page**

```html
  <script type="text/javascript" src="link/to/easyXDM.js"></script>
  <script type="text/javascript" src="link/to/iframeplus-provider.js"></script> 
```
   Javascript files can be found in 
   **/docroot/js/iframeplus/iframeplus-provider.js**
   and **/docroot/js/easyxdm/easyXDM.js**
   
**2) Apply the following style on the Provider page to hide scollbar**

```css
  html, body {
	overflow: hidden;
	margin: 0px;
	padding: 0px;
  }
```
**3) (Optional) if the consumer page uses dynamic content, you can use the 
   ``resizeIframe()`` function to indicate content has changed.**
   
   For example, if you load RSS fields using Javascript, you can call 
   ``resizeIframe()`` function once all RSS entries are loaded or after each 
   new entry to make the iframe fit correctly with the added elements.

```html
 <script type="text/javascript"> 
 	resizeIframe();
 </script>
```

###Intallation for Configuration n°2 (web site with inner navigation)
Installation for the configuration n°2 is similar to the configuration n°1. 
However, you have to create the Intermediary page and make it accessible. 
You can create the Intermediary page by using the css and the javascript files
located in **/docroot/js/iframeplus/iframeplus-intermediate.js** and
**/docroot/js/iframeplus/iframeplus-intermediate.css**, you can also use the
**/docroot/js/iframeplus/iframeplus-intermediary.html** file which already contains
the correct javascript lines of codes and css styles.

Once the Intermediary page created you have to indicates through the configuration 
page of the portlet (see "IFrame+ portlet configuration options" screenshot at the 
begining of the README) the URL of the Intermediary page you just created. 
The url must have an "url" parameter which contain the URL of the home page. 
For exemple, if your Intermediary page URL is : http://your.webapp.com/intermediary 
and your main page is http://your.webapp.com, the URL to put into the "Web site URL" 
field of the portlet configuration page is : 
http://your.webapp.com/intermediary?url=http://your.webapp.com


Loading mask option
======================
The purpose of this option is to display a loading icon while the IFrame 
content is loading.

Depending on the provider page content the end of loading can or cannot be
automatically detected.

If the "End loading: Automatically" option is checked, a message will be
automatically sent to the consumer page as soon as the static content 
of the provider page has been fully loaded (by using the jquery 
$(window).load method). 

If the "End loading: Manually" option is checked, a message to hide the 
loading mask must be manually added into the provider page. This option
is necessary when the page load dynamic content which is still running even
after the static content has been fully loaded.

To hide manually the loading mask use the "hideLoadingMask()" function
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

Liferay version tested
===========================
This portlet has been tested on Liferay 6.1EE.

License
=======
Copyright (c) 2012 University of Geneva, Nicolas Forney (nicolas@eforney.com).
This program is distributed under the terms of the GNU General Public License.

Author
============
**Developer**

* Nicolas Forney (nicolas@eforney.com)


Credits
=============
Project used to develop IFrame+ :

* jQuery [http://jquery.com](http://jquery.com/)
* easyXDM [http://easyxdm.net](http://easyxdm.net/)
* jquery-loadmask [http://code.google.com/p/jquery-loadmask/](http://code.google.com/p/jquery-loadmask/)
* Liferay [http://www.liferay.com](http://www.liferay.com)