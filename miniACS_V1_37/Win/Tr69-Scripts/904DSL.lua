	function DSL()
		acs.SetParameterValues("InternetGatewayDevice.ManagementServer.PeriodicInformInterval", "84000");
		acs.SetParameterValues("InternetGatewayDevice.ManagementServer.PeriodicInformEnable", "1");
		acs.SetParameterValues("InternetGatewayDevice.ManagementServer.X_ARCOR_NET_RetryDelayInitial", "10");
		acs.SetParameterValues("InternetGatewayDevice.ManagementServer.X_ARCOR_NET_RetryDelayIncrementFactor", "3");
		acs.SetParameterValues("InternetGatewayDevice.ManagementServer.X_ARCOR_NET_RetryDelayMaxIncrement", "6");

		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.X_ARCOR_NET_AutoReconnectEnable", "0");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.X_ARCOR_NET_AutoReconnectStart", "120");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.X_ARCOR_NET_AutoReconnectInterval", "180");

		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Enable", "Enabled");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.DTMFMethod", "RFC2833");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.ProxyServer", "voip.arcadyan.com");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.ProxyServerPort", "5060");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.RegistrarServer", "voip.arcadyan.com");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.UserAgentDomain", "voip.arcadyan.com");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.UserAgentPort", "5060");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.RegistrationPeriod", "3600");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.X_ARCOR_NET_ListenVC", "2");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.Enable", "Enabled");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.SIP.AuthUserName", "040519001001");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.SIP.AuthPassword", "040519001001");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.SIP.URI", "sip:040519001001@voip.arcadyan.com");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.CallingFeatures.CallerIDName", "040519001001");

		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.Enable", "Enabled");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.DTMFMethod", "RFC2833");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.SIP.ProxyServer", "voip.arcadyan.com");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.SIP.ProxyServerPort", "5060");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.SIP.RegistrarServer", "voip.arcadyan.com");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.SIP.UserAgentDomain", "voip.arcadyan.com");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.SIP.UserAgentPort", "5060");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.SIP.RegistrationPeriod", "3600");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.SIP.X_ARCOR_NET_ListenVC", "2");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.Line.1.Enable", "Enabled");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.Line.1.SIP.AuthUserName", "040519001002");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.Line.1.SIP.AuthPassword", "040519001002");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.Line.1.SIP.URI", "sip:040519001002@voip.arcadyan.com");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.2.Line.1.CallingFeatures.CallerIDName", "040519001002");

		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.PhyInterface.1.X_ARCOR_NET_OutCallPriorityList", "1,PSTN");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.PhyInterface.1.X_ARCOR_NET_AnswerAllLines", "1");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.PhyInterface.2.X_ARCOR_NET_OutCallPriorityList", "1,PSTN");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.PhyInterface.2.X_ARCOR_NET_AnswerAllLines", "1");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.PhyInterface.3.X_ARCOR_NET_OutCallPriorityList", "1,PSTN");
		acs.SetParameterValues("InternetGatewayDevice.Services.VoiceService.1.PhyInterface.3.X_ARCOR_NET_AnswerAllLines", "1");	

		acs.SetParameterValues("InternetGatewayDevice.DeviceInfo.X_ARCOR_NET_Iptv", "1");

		acs.SetParameterValues("InternetGatewayDevice.DeviceInfo.ProvisioningCode", "ACT1");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANCommonInterfaceConfig.Layer1UpstreamMaxBitRate", "10250000");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANDSLLinkConfig.Enable", "1");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANDSLLinkConfig.LinkType", "PPPoE");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANEthernetLinkConfig.X_ARCOR_NET_NumberOfVLANTags", "1");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANEthernetLinkConfig.X_ARCOR_NET_VLANId_1", "132");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANEthernetLinkConfig.X_ARCOR_NET_PBit_1", "0");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.Enable", "1");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.Username", "test");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.Password", "123456");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.MaxMRUSize", "1492");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.ConnectionTrigger", "AlwaysOn");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANDSLLinkConfig.Enable", "1");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANDSLLinkConfig.LinkType", "PPPoE");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANEthernetLinkConfig.X_ARCOR_NET_NumberOfVLANTags", "1");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANEthernetLinkConfig.X_ARCOR_NET_VLANId_1", "232");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANEthernetLinkConfig.X_ARCOR_NET_PBit_1", "6");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Enable", "1");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Username", "ppp");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Password", "ppp");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.MaxMRUSize", "1492");
		acs.SetParameterValues("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.ConnectionTrigger", "AlwaysOn");

        acs.execute();
	end


	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	isTransferComplete = 0;
	isBootStrap = 0;
	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
		if e[i] == "0 BOOTSTRAP" then
			isBootStrap = 1;
		elseif e[i] == "7 TRANSFER COMPLETE" then
			isTransferComplete = 1;
		end
	end

	acs.LoadVars();
	if (isBootStrap == 1) then
		d = {}
		d["CommandKey"] = "testDownload";
		d["URL"] = "https://10.118.16.125:8443/openwrt-ltqcpe-platform_ar10-ubi.bin";
		d["Username"] = "Popeye";
		d["Password"] = "12345678";
		d["DelaySeconds"] = 3;

		acs.Download(d);
		err = acs.GetError();
		if err ~= "0" then
			print("Error = " .. err);
		end
	else
		if (isTransferComplete == 1) then
			err = acs.GetError();
			if (err ~= "0") then
				print("Download Failure: Errorcode =  " .. err);
			else
				print("Download success.");
			end
		end
		Code = acs.GetParameterValues("InternetGatewayDevice.DeviceInfo.ProvisioningCode");
		print ("ProvisioningCode = " .. Code);
		if Code ~= "ACT1" then
			print ("ACSLOG:: 904DSL AutoProvision start NOW!!!");
			DSL();
		end
	end