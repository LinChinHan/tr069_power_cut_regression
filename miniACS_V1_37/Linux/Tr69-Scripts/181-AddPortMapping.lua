
	MF, OUI, PD, SN = acs.GetDeviceInfo();
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
	end

	acs.LoadVars();

	PortMapping = acs.GetParameterNames("Device.NAT.PortMapping.", "true");
	nCount = 0;
	for key, value in pairs(PortMapping) do
		nCount = nCount + 1;
	end
	print("nPortMapping = " .. nCount);
	if (nCount == 0) then
		acs.AddObject("Device.NAT.PortMapping.");
	end
	Inst = 1;
	
	Map = {};
	Map["Device.NAT.PortMapping."..Inst..".Enable"] = 1;
	Map["Device.NAT.PortMapping."..Inst..".InternalPort"] = 1002;
	Map["Device.NAT.PortMapping."..Inst..".ExternalPort"] = 1002;
	Map["Device.NAT.PortMapping."..Inst..".ExternalPortEndRange"] = 1004;
	Map["Device.NAT.PortMapping."..Inst..".Protocol"] = "TCP";
	Map["Device.NAT.PortMapping."..Inst..".InternalClient"] = "192.168.2.100";
	
	acs.SetParameterValues(Map);

	err = acs.GetError();
	if (err ~= "0") then
		print("Error = "..err);
	else	
		print("Success");
	end
	