require "Tr69-Scripts/lib"

	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	isDUStateChangeComplete = 0;
	isConnectRequest = 0;
	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
		if e[i] == "6 CONNECTION REQUEST" then
			isConnectRequest = 1;
		end
		if e[i] == "11 DU STATE CHANGE COMPLETE" then
			isDUStateChangeComplete = 1;
		end
	end

	acs.LoadVars();
	
	if (isDUStateChangeComplete == 1) then
		---[[ do notthing when isDUStateChangeComplete.
		OpResults = acs.DUStateChangeComplete();
		if OpResults ~= nil then
			print("Got "..#OpResults.." results")
			for i = 1, #OpResults do
				local result = OpResults[i];
				print("UUID " .. result["UUID"])
				print("StartTime " .. result["StartTime"])
				print("CompleteTime " .. result["CompleteTime"])
				print("CurrentState " .. result["CurrentState"])
				print("ExecutionUnitRefList " .. result["ExecutionUnitRefList"])
				print("FaultCode " .. result["FaultCode"])
				print("FaultString " .. result["FaultString"])
				print("Resolved " .. result["Resolved"])
				print("Version " .. result["Version"] .. "\n")
			end
		else
			print("No results")
		end
		--]]
	elseif (isConnectRequest == 1) then
		local File = "";
		local UUID = acs.UUID();
		if PD == "VRV7006AW22-A-GR" then
			File = "openwrt-ltqcpe-platform_vr9-ubi_debug.bin";
		elseif PD == "PRV65B444A-S-TS" then
			File = "PRV65B444A-S-TS_v1.00.00_build01_128_debug.w"
		else
			File = "G3100_1.3.6.15-eng0_00_256_debug_pureubi.w";
		end
	
		local acsInfo = acs.GetACSInfo();
		install = {["type"] = "install", ["Username"] = "Popeye", ["Password"] = "test123", ["UUID"] = UUID, ["ExecutionEnvRef"] = "test"};
		if acsInfo["IPv6"] == false then
			install["URL"] = acsInfo["Protocol"] .. "://" .. acsInfo["IP"] .. ":" .. acsInfo["Port"] .. "/" .. File;
		else
			install["URL"] = acsInfo["Protocol"] .. "://[" .. acsInfo["IP"] .. "]:" .. acsInfo["Port"] .. "/" .. File;
		end
		acs.ChangeDUState("TestInstall", install);
--[[
		update = {["type"] = "update", ["Username"] = "Popeye", ["Password"] = "test123", ["UUID"] = UUID}
		update["URL"] = install["URL"]
		acs.ChangeDUState("TestUpdate", update);
		
		uninstall = {["type"] = "uninstall", ["UUID"] = UUID, ["ExecutionEnvRef"] = "test uninstall"}
		acs.ChangeDUState("TestUninstall", uninstall);
]]		
	end

