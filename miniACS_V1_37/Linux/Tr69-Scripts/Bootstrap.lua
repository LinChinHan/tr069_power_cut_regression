	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	isBootstrap = 0;
	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
		if e[i] == "0 BOOTSTRAP" then
			isBootstrap = 1;
		end
	end

	if (isBootstrap == 1) then
		Username = OUI .. "-" .. PD .. "-".. SN;
		Password = acs.MD5(Username, 0);
		if (acs.GetMajor() == 1) then
			acs.SPV("InternetGatewayDevice.ManagementServer.ConnectionRequestUsername", Username);
			acs.SPV("InternetGatewayDevice.ManagementServer.ConnectionRequestPassword", Password);
		else
			acs.SPV("Device.ManagementServer.ConnectionRequestUsername", Username);
			acs.SPV("Device.ManagementServer.ConnectionRequestPassword", Password);
		end
		acs.execute();
		if acs.HasScript() then
			acs.CRQ(0, Username, Password);
		end
	end