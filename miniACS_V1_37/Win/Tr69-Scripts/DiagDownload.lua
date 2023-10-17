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
		Prefix = "Device.IP.Diagnostics.DownloadDiagnostics."
	else
		Prefix = "InternetGatewayDevice.DownloadDiagnostics."
	end
	
	if (isDiagComplete == 1) then
		PrintParameters(acs.GPV(Prefix))
	else
		local acsInfo = acs.GetACSInfo();
		local File = "Upload/test.bin"

		p = {}
		p[Prefix .. "DiagnosticsState"] = "Requested";
---[[
		if acsInfo["IPv6"] == false then
			p[Prefix .. "DownloadURL"] = acsInfo["Protocol"] .. "://" .. acsInfo["IP"] .. ":" .. acsInfo["Port"] .. "/" .. File;
		else
			p[Prefix .. "DownloadURL"] = acsInfo["Protocol"] .. "://[" .. acsInfo["IP"] .. "]:" .. acsInfo["Port"] .. "/" .. File;
		end
--]]
		--p[Prefix .. "DownloadURL"] = "http://tlsmultiffdl354.ngcdn.telstra.com/SparcTR143/8MB.dat"
		--p[Prefix .. "DownloadURL"] = "http://speed.anet.net.tw/5M.dat"
		acs.SetParameterValues(p);
		err = acs.GetError();
		if err ~= "0" then
			print("Error = " .. err);
		end
	end		
