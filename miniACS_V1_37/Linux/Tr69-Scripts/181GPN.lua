require "Tr69-Scripts/lib"

	MF, OUI, PD, SN = acs.GetDeviceInfo();
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
	end
	
	PrintParametersName(acs.GPN("Device.", "true"));

