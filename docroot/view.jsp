<%
/**
 * Copyright (c) 2011 Nicolas Forney (nicolas@eforney.com). 
 * Released under MIT Licence.
 */
%>

<%@include file="/init.jsp"%>

<%
	String sourceUrl = preferences.getValue("sourceUrl",StringPool.BLANK);
	String portletPath = renderResponse.encodeURL(renderRequest.getContextPath());
	String portalHomeUrl = PortalUtil.getPortalURL(request);

%>

<div class="iframe-plus" id="<%=portletNamespace%>-iframe-container">
</div>


<script type="text/javascript">

/*A loading mask is added if the option is activated (user set the option from 
  the configuration menu)*/
	
if(<%=maskActivated%>){
	$("#<%=portletNamespace%>-iframe-container").mask("<liferay-ui:message key='loading'/>");
}



/* Socket used to listen to the provider messages iFrame height is reset with
the value provided by the provider through the message system */
if("<%=sourceUrl%>"){
	var transport = new easyXDM.Socket({
	    remote: "<%=sourceUrl%>",
	    swf: "<%=portalHomeUrl%><%=portletPath%>/easyxdm/easyxdm.swf",
	    container: "<%=portletNamespace%>-iframe-container",
	    onMessage: function(message, origin){	 
	        if(message=="hide-loading-automatic" && "<%=endLoading%>"=="automatic"){
	        	$("#<%=portletNamespace%>-iframe-container").unmask();
			} else if(message=="hide-loading-manual" ) {
				$("#<%=portletNamespace%>-iframe-container").unmask();
			}else{
				this.container.getElementsByTagName("iframe")[0]
				.style.height = message	+ "px";
			}
		}
	});
}
</script>