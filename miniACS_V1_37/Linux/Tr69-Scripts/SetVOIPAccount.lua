
	MF, OUI, PD, SN = acs.GetDeviceInfo();
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
	end

	acs.LoadVars();

	SIP = {};
	SIP["InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Enable"] = "Enabled";
	SIP["InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.UserAgentDomain"] = "siptest.arcadyan.com.tw";
	SIP["InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.OutboundProxy"] = "10.118.16.157";
	SIP["InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.Enable"] = "Enabled";
	SIP["InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.DirectoryNumber"] = "123456";
	SIP["InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.SIP.AuthUserName"] = "12345";
	SIP["InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.SIP.AuthPassword"] = "abcdef";
	SIP["InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.Line.1.SIP.URI"] = "1111@siptest.arcadyan.com.tw";

	acs.SetParameterValues(SIP);

	err = acs.GetError();
	if (err ~= "0") then
		print("Error = "..err);
	else	
		print("Success");
	end
	