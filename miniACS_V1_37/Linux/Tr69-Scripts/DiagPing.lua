	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	isDiagComplete = 0;
	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
		if e[i] == "8 DIAGNOSTICS COMPLETE" then
			isDiagComplete = 1;
		end
	end

	acs.LoadVars();
	
	if (isDiagComplete == 1) then
		result = acs.GetParameterValues("InternetGatewayDevice.IPPingDiagnostics.");
		for key, value in pairs(result) do
			print(key .. " = " .. value);
		end
	else
		p = {}
		p["InternetGatewayDevice.IPPingDiagnostics.DiagnosticsState"] = "Requested";
		p["InternetGatewayDevice.IPPingDiagnostics.Host"] = "www.google.com";
		p["InternetGatewayDevice.IPPingDiagnostics.NumberOfRepetitions"] = 10;
		p["InternetGatewayDevice.IPPingDiagnostics.Timeout"] = 1000;
		p["InternetGatewayDevice.IPPingDiagnostics.DataBlockSize"] = 64;
		acs.SetParameterValues(p);
		err = acs.GetError();
		if err ~= "0" then
			print("Error = " .. err);
		end
	end		
