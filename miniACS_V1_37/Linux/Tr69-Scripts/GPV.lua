
	MF, OUI, PD, SN = acs.GetDeviceInfo();
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
	end

	Paras = acs.GetParameterValues("InternetGatewayDevice.");
--[[	
	for key, value in pairs(Paras) do
		print(key .." = " .. value);
	end
]]	
	if (Paras ~= nil) then
		outfile = io.open("GPV.log", "w");
		acs.Write(outfile, Paras);
		io.close(outfile);
	end
	