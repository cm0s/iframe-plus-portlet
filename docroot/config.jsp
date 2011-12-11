<%@page import="com.liferay.portal.service.persistence.PortletUtil"%>
<%
/**
 * Copyright (c) 2011 Nicolas Forney (nicolas@eforney.com). Released under MIT Licence.
 */
%>

<%@ include file="/init.jsp" %>
<liferay-portlet:renderURL varImpl="portletURL" />

<%
String redirect = ParamUtil.getString(renderRequest, "redirect");
String sourceUrl = PrefsParamUtil.getString(preferences, renderRequest, "sourceUrl");
String portletUrl = portletDisplay.getURLPortlet().split("/")[1];
String portalHomeUrl = PortalUtil.getPortalURL(request);
boolean automaticOptionChecked = false;
boolean manualOptionChecked = false;
if(endLoading.equals("manual")){
	manualOptionChecked=true;
}else{
	automaticOptionChecked=true;
}
%>

<liferay-portlet:actionURL portletConfiguration="true" var="configurationURL" />


<aui:form action="<%= configurationURL %>" method="post" name="fm">
	<aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />
	<aui:input name="redirect" type="hidden" value="<%= redirect %>" />
	
	<aui:fieldset>
		<div class="portlet-msg-info"><liferay-ui:message key="configuration-msg-info"/></div>
		<aui:input name="sourceUrl" label="input-label" value="<%=HtmlUtil.toInputSafe(sourceUrl) %>"/>			
	</aui:fieldset>	
		<div class="loadmaskoption">
			<span class="loadmaskoption-left-box inline">
				<aui:input cssClass="checkbox" type="checkbox" label="check-box-label" name="maskActivated" checked="<%=maskActivated%>"/>
			</span>
			
			<span class="loadmaskoption-middle-box inline hidden">
					<img src="<%=portalHomeUrl %>/<%=portletUrl%>/images/arrow_right.png"/>
			</span>
			
			<span class="loadmaskoption-right-box inline hidden">				
				<aui:field-wrapper  name="endLoading" label="end-loading-label">
					<aui:input cssClass="loadmaskoption-radiobutton" inlineLabel="right" name="endLoading" type="radio" value="automatic" label="radio-label-automatic" helpMessage="radio-help-msg-automatic" checked="<%=automaticOptionChecked %>"/>
					<aui:input cssClass="loadmaskoption-radiobutton" inlineLabel="right" name="endLoading" type="radio" value="manual" label="radio-label-manual" helpMessage="radio-help-msg-manual" checked="<%=manualOptionChecked %>"/>
				</aui:field-wrapper>	
			</span>
			
			<c:if test='<%=maskActivated%>'>
				<script type="text/javascript">
					$(".loadmaskoption-middle-box, .loadmaskoption-right-box").removeClass("hidden");
				</script>	
			</c:if>
		</div>
	<aui:button-row>
		<aui:button type="submit" />
	</aui:button-row>
</aui:form>