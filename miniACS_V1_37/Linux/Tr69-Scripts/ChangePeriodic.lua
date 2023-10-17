<---
	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for i = 1, #e  do
		print ("Evnet" .. i .. " = " .. e[i]);
	end

	acs.SetParameterValues("Device.PPP.Interface.1.IdleDisconnectTime", 60);
	acs.SetParameterValues("Device.ManagementServer.PeriodicInformInterval", 120);
	acs.execute();
	
--->
