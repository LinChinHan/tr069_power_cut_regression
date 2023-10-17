<---
	function SaveToFile(outfile) 
		if outfile then
			outfile:write(acs.GetTime() .. "\n");
			for key, value in pairs(para) do
				outfile:write(key .. "=" .. value .. "\n");
			end			
			outfile:write("\n\n");
			outfile:flush();
		end
	end

	function GetStats()
		logtimes = acs.GetVar("logtimes");
		if logtimes == nil then
			logtimes = 0;
		end
		logtimes = logtimes + 1;
		acs.SetVar("logtimes", logtimes);
		print("logtimes = " .. logtimes);
		acs.SaveVars();

		if logtimes % 2 == 1 then
			acs.flush();
			para = acs.GetParameterValues("Device.DSL.Channel.1.Stats.");
			outfile = io.open("DSLstats.log", "a");
			if outfile == nil then
				outfile = io.open("DSLstats.log", "w");
			end
			SaveToFile(outfile);
		else
			acs.flush();
			para = acs.GetParameterValues("Device.Services.VoiceService.1.NetworkProfile.1.Line.1.Stats.");
			outfile = io.open("VOIPstats.log", "a");
			if outfile == nil then
				outfile = io.open("VOIPstats.log", "w");
			end
			if type(para) == "table" then
				SaveToFile(outfile);
			end
			acs.GetParameterNames("Device.Services.VoiceService.1.CallControl.CallLog.", "true");
			acs.flush();
			para = acs.GetParameterValues("Device.Services.VoiceService.1.CallControl.CallLog.1.");
			if type(para) == "table" then
				SaveToFile(outfile);
			end
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

	acs.LoadVars();
	print ("event 1 = " .. e[1]);
	if e[1] == "0 BOOTSTRAP" or e[1] == "1 BOOT" then
		GetStats();
	elseif e[1] == "4 VALUE CHANGE" or e[1] == "6 CONNECTION REQUEST" then
		Username = acs.GetParameterValues("Device.PPP.Interface.1.Username");
		print("Username = " .. Username);
		GetStats();
	end		
	
--->
