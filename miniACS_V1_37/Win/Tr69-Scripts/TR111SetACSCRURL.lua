	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)
	Major = acs.GetMajor();
	e = acs.GetEvent();

	isConnRequest = 0;
	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
		if e[i] == "6 CONNECTION REQUEST" then
			isConnRequest = 1;
		end
	end

	function GetManageableNumberOfEntry(Prefix)
		local ParaName = Prefix.."ManageableDeviceNumberOfEntries"
		local NumberOfEntries = acs.GPV(ParaName)
		if NumberOfEntries ~= nil then
			return tonumber(NumberOfEntries)
		end
		return 0
	end
	
	function GetManageableDevice(Prefix, Entry)
		local ParaName = Prefix.."ManageableDevice.".. Entry ..".SerialNumber"
		local DeviceSN = acs.GPV(ParaName)
		if DeviceSN ~= nil then
			return acs.GetDevice(DeviceSN)
		end
		return nil
	end
	
	function GetGatewayIPAddress(ParaName)
		local FullName = acs.GetFullName(ParaName)
		if FullName ~= nil then
			return acs.GetValue(FullName)
		end
		return nil
	end

	function ParseURL(URL)
		if string.find(URL, "http") then
			local proto, ip, port, path = string.match(URL, "(.-)://(.-):(%d+)(.+)")
			urltable = {}
			urltable["proto"] = proto
			urltable["ip"] = ip
			urltable["port"] = port
			urltable["path"] = path
			return urltable
		else
			return nil
		end
	end
	
	function FindPortMapping(Prefix, inIPAddr, inPort, extPort)
		local SaveNumberOfEntry = acs.GetValue(Prefix.."PortMappingNumberOfEntries")
		local NumberOfEntry = acs.GPV(Prefix.."PortMappingNumberOfEntries")
		if SaveNumberOfEntry == nil or SaveNumberOfEntry ~= NumberOfEntry then
			acs.GPV(Prefix.."PortMapping.")
		end
		for entry = 1, NumberOfEntry do
			local PortMappingPrefix = Prefix.."PortMapping."..entry.."."
			local Paras = acs.GetValue(PortMappingPrefix)
			if Paras ~= nil then
				local Enable, InternalClient, InternalPort, ExternalPort
				for key, value in pairs(Paras) do
					if key == PortMappingPrefix.."Enable" 
						or key == PortMappingPrefix.."PortMappingEnabled" then
						Enable = value
					elseif key == PortMappingPrefix.."InternalClient" then
						InternalClient = value
					elseif key == PortMappingPrefix.."InternalPort" then
						InternalPort = tostring(value)
					elseif key == PortMappingPrefix.."ExternalPort" then
						ExternalPort = tostring(value)
					end
				end
--[[
				print(inIPAddr.." "..InternalClient)
				print(tostring(inPort).." "..InternalPort)
				print(tostring(extPort).." "..ExternalPort)
--]]
				if Enable == "1"
					and InternalClient == inIPAddr 
					and InternalPort == tostring(inPort)
					and ExternalPort == tostring(extPort) then
					return true
				end
			end
		end
		return false
	end

	function SetPortMapping(ParaName, Inst, inIPAddr, inPort, extPort)
		if Inst ~= nil then
			Map = {}
			if Major == 1 then
				Map[ParaName..Inst..".PortMappingEnabled"] = 1
				Map[ParaName..Inst..".PortMappingProtocol"] = "TCP"
				Map[ParaName..Inst..".PortMappingDescription"] = "MiniACS"
			else
				Map[ParaName..Inst..".Enable"] = 1
				Map[ParaName..Inst..".Protocol"] = "TCP"
				Map[ParaName..Inst..".Description"] = "MiniACS"
			end
			Map[ParaName..Inst..".InternalPort"] = inPort
			Map[ParaName..Inst..".ExternalPort"] = extPort
			Map[ParaName..Inst..".ExternalPortEndRange"] = extPort
			Map[ParaName..Inst..".InternalClient"] = inIPAddr
			acs.SPV(Map)
		end
	end

	function AddPortMapping(Prefix, inIPAddr, inPort, extPort)
		local ParaName = Prefix.."PortMapping."
		local Inst = acs.AddObject(ParaName)
		SetPortMapping(ParaName, Inst, inIPAddr, inPort, extPort)
	end

	function UseUsedPortMapping(Prefix, inIPAddr, inPort, extPort)
		local ParaName = Prefix.."PortMapping."
		local NumberOfEntry = acs.GetValue(Prefix.."PortMappingNumberOfEntries")
		for entry = 1, NumberOfEntry do
			local PortMappingPrefix = Prefix.."PortMapping."..entry.."."
			local Paras = acs.GetValue(PortMappingPrefix)
			if Paras ~= nil then
				local InternalPort, Description
				for key, value in pairs(Paras) do
					if key == PortMappingPrefix.."InternalPort" then
						InternalPort = tostring(value)
					elseif key == PortMappingPrefix.."Description" 
						or key == PortMappingPrefix.."PortMappingDescription" then
						Description = value
					end
				end
				if InternalPort == 0 
					or (InternalPort == tostring(inPort) and Description == "MiniACS") then 
					local Inst = tostring(entry)
					SetPortMapping(ParaName, Inst, inIPAddr, inPort, extPort)
					return true
				end
			end
		end	
		return false
	end
	
	if isConnRequest == 1 then
		if (Major== 1) then
			print("Gateway run TR098 datamodel.");
			Prefix = "InternetGatewayDevice.ManagementServer."
			--IPPrefix = "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1."
			IPPrefix = ""
			local IPAddress = acs.GetFullName("ExternalIPAddress");
			if IPAddress ~= nil then
				IPPrefix = string.gsub(IPAddress, "ExternalIPAddress", "");
			end
		else
			print("Gateway run TR181 datamodel.")
			Prefix = "Device.ManagementServer."
			IPPrefix = "Device.NAT."
		end	
		print("IPPrefix = " .. IPPrefix);
		local GatewayURL = acs.GetValue(Prefix.."ConnectionRequestURL")
		local GatewayURLTable = ParseURL(GatewayURL)
		DeviceEntries = GetManageableNumberOfEntry(Prefix)
		for entry = 1, DeviceEntries do
			repeat
				Device = GetManageableDevice(Prefix, entry)
				if Device ~= nil then
					print(Device["CRURL"] .. " " .. Device["ACSCRURL"])
					URLTable = ParseURL(Device["CRURL"])
					ACSURLTable = ParseURL(Device["ACSCRURL"])
					local needAdd = 0
					local extPort = 0;
					if URLTable ~= nil then
						if ACSURLTable ~= nil then
							if FindPortMapping(IPPrefix, URLTable["ip"], URLTable["port"], ACSURLTable["port"]) == true 
							and GatewayURLTable["ip"] == ACSURLTable["ip"]
							then
								print("Portmapping is added.")
								if URLTable["path"] ~= ACSURLTable["path"] then
									extPort = ACSURLTable["port"];
									goto MakeURL
								end
								break
							end
						end
						extPort = 10000 + GatewayURLTable["port"] + acs.random(100) + acs.random(2)
						while FindPortMapping(IPPrefix, URLTable["ip"], URLTable["port"], extPort) == true
						do
							extPort = extPort + acs.random(100) + acs.random(2)
						end
						print("PrivateIP="..URLTable["ip"].." Port="..URLTable["port"].." extPort="..extPort)
						if UseUsedPortMapping(IPPrefix, URLTable["ip"], URLTable["port"], extPort) == false then
							AddPortMapping(IPPrefix, URLTable["ip"], URLTable["port"], extPort)
						end
::MakeURL::
						local ACSCRURL = URLTable["proto"].."://"..GatewayURLTable["ip"]..":"..extPort..URLTable["path"]
						acs.SetACSCRURL(Device["SN"], ACSCRURL)
						--acs.CRQ(ACSCRURL, Device["CRUsername"], Device["CRPassword"])
					end
				end
			until true
--[[
			acs.Finish(3)
			if Device ~= nil then
				NewDevice = acs.GetDevice(Device["SN"]);
				acs.CRQ(NewDevice["ACSCRURL"], NewDevice["CRUsername"], NewDevice["CRPassword"])
			end
--]]
		end
	end
	
