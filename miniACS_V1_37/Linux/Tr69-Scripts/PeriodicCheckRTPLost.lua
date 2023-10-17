<---
	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	acs.LoadVars();
	acs.SetVar("silent", 1); --silent mode.
	acs.SetVar("nextdelay", 30); --delay seconds for connection request.
	acs.SetVar("username", "popeye"); --connect request username.
	acs.SetVar("password", "popeye123"); --connect request password.
	acs.SetVar("connreq", 1); --do connection request after requests.
	
	PacketLost = acs.GetParameterValues("Device.Services.VoiceService.1.NetworkProfile.1.Line.1.Stats.PacketsLost");
	error = acs.GetError();
	if (error == "0") then
		print("PackLost = " .. PacketLost .. "\n");
	else
		print("error = " .. error .. "\n");
	end
--->
