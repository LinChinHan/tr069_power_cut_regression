<---
	function SaveToFile(outfile) 
		if outfile then
			outfile:write(acs.GetTime() .. "\n");
			acs.Write(outfile, para);
			outfile:write("\n\n");
			outfile:flush();
		end
	end

	function GetStats()
		acs.flush();
		para = acs.GetParameterValues("Device.Services.VoiceService.1.CallControl.CallLog.");
		outfile = io.open("CallLog.log", "w");
		if type(para) == "table" then
			SaveToFile(outfile);
		end
		if outfile ~= nil then
			io.close(outfile);
		end
	end

	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for key, value in pairs(e) do
		print ("Key = " .. key);
		print ("Evnet = " .. value);
	end
	GetStats();
	
--->
