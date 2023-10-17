	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();
	isConnectRequest = 0;
	isBoot = 0;
	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
		if e[i] == "6 CONNECTION REQUEST" then
			isConnectRequest = 1;
		end
		if e[i] == "1 BOOT" then
			isBoot = 1;
		end
	end

	acs.LoadVars();
	
	if (isBoot == 1) then
		--acs.CRQ(30);
	elseif (isConnectRequest == 1) then
		acs.Reboot();
	end
	
