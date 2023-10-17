	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	if (acs.GetMajor() == 1) then
		print("Gateway run TR098 datamodel.");
		Root="InternetGatewayDevice."
	else
		print("Gateway run TR181 datamodel.");
		Root="Device."
	end
	acs.StartMakeDataModel(true);
	acs.GPV(Root);
	acs.SaveDataModel();
