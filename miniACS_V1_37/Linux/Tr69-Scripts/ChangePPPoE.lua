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
			--acs.SetParameterValues("Device.ManagementServer.URL", "https://10.118.16.157:8444/acs");
			acs.SetParameterValues("Device.PPP.Interface.1.Username", "ppp");
			acs.SetParameterValues("Device.PPP.Interface.1.Password", "ppp");
			acs.SetParameterValues("Device.PPP.Interface.1.IdleDisconnectTime", 180);
			acs.SetParameterValues("Device.PPP.Interface.1.ConnectionTrigger", "OnDemand");
			acs.SetParameterValues("Device.PPP.Interface.1.Reset", 1);
		else
			--acs.SetParameterValues("Device.ManagementServer.URL", "https://10.118.16.157:8443/acs");
			acs.SetParameterValues("Device.PPP.Interface.1.Username", "85365610@hinet.net");
			acs.SetParameterValues("Device.PPP.Interface.1.IdleDisconnectTime", 0);
			acs.SetParameterValues("Device.PPP.Interface.1.Password", "2jdixjxl");
			acs.SetParameterValues("Device.PPP.Interface.1.ConnectionTrigger", "AlwaysOn");
			acs.SetParameterValues("Device.PPP.Interface.1.Reset", 1);
		end
		acs.execute();
	end

	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
	end

	acs.LoadVars();
	if e[1] == "4 VALUE CHANGE" then
		acs.SetVar("connreq", 1);
	elseif e[1] == "6 CONNECTION REQUEST" then
		urltogle();
	end
	
--->
