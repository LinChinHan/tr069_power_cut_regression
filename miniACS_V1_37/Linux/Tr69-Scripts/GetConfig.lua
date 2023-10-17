<---
	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for key, value in pairs(e) do
		print ("Key = " .. key);
		print ("Evnet = " .. value);
	end

	config = acs.GetParameterValues("Device.DeviceInfo.X_T-ONLINE-DE_ConfigFile");
	print(config);

--->	
