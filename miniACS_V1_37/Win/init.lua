
print("miniACS start at " .. init.Time());

--[[
	Methods = init.GetMethods();
	if Methods ~= nil then
		print("init supported methods:");
		for i = 1, #Methods do
			print("\tinit." .. Methods[i] .. init.GetUsage(Methods[i]));
		end
	end
--]]

--[[
	ACS = init.GetACSInfo()
	print("acsurl = " .. ACS["Protocol"] .. "://" .. ACS["IP"] .. ":" .. ACS["Port"] .. ACS["Path"])
	print("isV6 = " .. tostring(ACS["IPv6"]));
--]]

--print(init.GetVar("Vendor"));
--init.OpenScript("Download.lua");
--init.DeleteVars("Vendor", "nTotalFail", "nTotal");
--init.PostCmd("echo \"Popeye make ACS.\"")

--[[
	init.CreateQ("DownloadQ", 1);
	init.EnterQ("DownloadQ");
	init.LeaveQ("DownloadQ")
	init.DestoryQ("DownloadQ")
--]]

--[[
	isFinished = init.WaitForAny("test", 20);
	if isFinished ~= nil then
		print("Get " .. isFinished);
	else
		print("Deleted or TimeOut.");
	end
--]]

--[[
init.ACSCmd("scan");
Devices = init.GetDevices(true);
if Devices ~= nil then
	print(#Devices .. " Devices Online.");
	for i = 1, #Devices do
		DeviceURL = init.GetDeviceCR(Devices[i]);
		if (DeviceURL ~= nil) then
			print("Device " .. Devices[i] .. " URL = " .. DeviceURL);
			init.OpenScript("Download.lua", Devices[i]);
			os.execute("./connreq -url " .. DeviceURL .. " -c config.txt");
		end
	end
end
--]]