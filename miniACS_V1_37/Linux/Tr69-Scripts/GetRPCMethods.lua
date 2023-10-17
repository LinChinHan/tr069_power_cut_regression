
	MF, OUI, PD, SN = acs.GetDeviceInfo();
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
	end

	methods = acs.GetRPCMethods();
	for i = 1, #methods do
		print ("Method" ..i.. " = " .. methods[i]);
	end
