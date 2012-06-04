package ch.unige.liferay.iframeplus.action;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.portlet.BaseConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.Constants;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portlet.PortletPreferencesFactoryUtil;


/**
 * Class used to handle portlet configuration page 
 * @author Nicolas Forney (nicolas@eforney.com)
 */
public class ConfigurationActionImpl extends BaseConfigurationAction {

	@Override
	public void processAction(
		PortletConfig portletConfig, ActionRequest actionRequest,
		ActionResponse actionResponse)
		throws Exception {

		String cmd = ParamUtil.getString(actionRequest, Constants.CMD);

		if (!cmd.equals(Constants.UPDATE)) {
			return;
		}

		String sourceUrl = ParamUtil.getString(actionRequest, "sourceUrl");
		String maskActivated = ParamUtil.getString(actionRequest, "maskActivated");
		String endLoading = ParamUtil.getString(actionRequest, "endLoading");
		
		String portletResource = ParamUtil.getString(actionRequest,"portletResource");
		PortletPreferences preferences = PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource);

		preferences.setValue("sourceUrl", sourceUrl);
		preferences.setValue("maskActivated", maskActivated);
		preferences.setValue("endLoading", endLoading);
		

		preferences.store();

		SessionMessages.add(actionRequest, portletConfig.getPortletName()+ ".doConfigure");
	}

	@Override
	public String render(
		PortletConfig portletConfig, RenderRequest renderRequest,
		RenderResponse renderResponse)
		throws Exception {

		return "/config.jsp";
	}

}
