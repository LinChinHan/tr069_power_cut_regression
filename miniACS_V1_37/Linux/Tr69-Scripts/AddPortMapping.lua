
	MF, OUI, PD, SN = acs.GetDeviceInfo();
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
	end

	acs.LoadVars();

	PortMapping = acs.GetParameterNames("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.PortMapping.", "true");
	nCount = 0;
	for key, value in pairs(PortMapping) do
		nCount = nCount + 1;
	end
	print("nPortMapping = " .. nCount);
	if (nCount == 0) then
		acs.AddObject("InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.PortMapping.");
	end
	Inst = 1;
	
	Map = {};
	Map["InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.PortMapping."..Inst..".PortMappingEnabled"] = 1;
	Map["InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.PortMapping."..Inst..".InternalPort"] = 1002;
	Map["InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.PortMapping."..Inst..".ExternalPort"] = 1002;
	Map["InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.PortMapping."..Inst..".ExternalPortEndRange"] = 1004;
	Map["InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.PortMapping."..Inst..".PortMappingProtocol"] = "TCP";
	Map["InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.PortMapping."..Inst..".InternalClient"] = "192.168.2.100";
	
	acs.SetParameterValues(Map);

	err = acs.GetError();
	if (err ~= "0") then
		print("Error = "..err);
	else	
		print("Success");
	end
	