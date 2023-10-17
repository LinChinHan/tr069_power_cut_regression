<---
	function urltogle()
		togletimes = acs.GetVar("togletimes");
		if togletimes == nil then
			togletimes = 0;
		end
		togletimes = togletimes + 1;
		acs.SetVar("togletimes", togletimes);
		print("togletimes = " .. togletimes);
		acs.SaveVars();

		if togletimes % 2 == 1 then
			acs.SetParameterValues("Device.ManagementServer.URL", "https://10.118.16.157:8444/acs");
		else
			acs.SetParameterValues("Device.ManagementServer.URL", "https://10.118.16.157:8443/acs");
		end
		acs.execute();
	end

	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for key, value in pairs(e) do
		print ("Key = " .. key);
		print ("Evnet = " .. value);
	end

	acs.LoadVars();
	print ("event 1 = " .. e[1]);
	if e[1] == "0 BOOTSTRAP" or e[1] == "6 CONNECTION REQUEST" then
		urltogle();
	end		
	
--->
