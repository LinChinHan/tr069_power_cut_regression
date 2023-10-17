require "Tr69-Scripts/lib"

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
	Major = acs.GetMajor();
	if Major == 2 then
		Prefix = "Device.IP.Diagnostics.UploadDiagnostics."
	else
		Prefix = "InternetGatewayDevice.UploadDiagnostics."
	end
	
	if (isDiagComplete == 1) then
		PrintParameters(acs.GPV(Prefix))
	else
		local acsInfo = acs.GetACSInfo();
		local File = "Upload/test.bin"
		p = {}
		p[Prefix .. "DiagnosticsState"] = "Requested";
		if acsInfo["IPv6"] == false then
			p[Prefix .. "UploadURL"] = acsInfo["Protocol"] .. "://" .. acsInfo["IP"] .. ":" .. acsInfo["Port"] .. "/" .. File;
		else
			p[Prefix .. "UploadURL"] = acsInfo["Protocol"] .. "://[" .. acsInfo["IP"] .. "]:" .. acsInfo["Port"] .. "/" .. File;
		end
		p[Prefix .. "TestFileLength"] = 10*1024*1024;
		acs.SetParameterValues(p);
		err = acs.GetError();
		if err ~= "0" then
			print("Error = " .. err);
		end
	end		
