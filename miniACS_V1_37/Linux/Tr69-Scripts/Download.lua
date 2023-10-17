	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)

	e = acs.GetEvent();

	isTransferComplete = 0;
	isConnectRequest = 0;
	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
		if e[i] == "6 CONNECTION REQUEST" then
			isConnectRequest = 1;
		end
		if e[i] == "7 TRANSFER COMPLETE" then
			isTransferComplete = 1;
		end
	end

	acs.LoadVars();
	
	if (isTransferComplete == 1) then
		-- do notthing when Transfercomplete.
		tc = acs.TransferComplete();
		-- print("Start: " .. tc["StartTime"]);
		-- print("Complete: " .. tc["CompleteTime"]);
		-- print("CommandKey: " .. tc["CommandKey"]);
		-- print("FaultCode: " .. tc["FaultCode"]);
		errcode = tc["FaultCode"];
		if (errcode ~= "0") then
			print("Download Failure: Errorcode =  " .. errcode);
		else
			print("Download success.");
		end
	elseif (isConnectRequest == 1) then
		local File = "";
		if PD == "VRV7006AW22-A-GR" then
			File = "openwrt-ltqcpe-platform_vr9-ubi_debug.bin";
			--File = "GVT2X2_FWT_1.00.06t1_20150713.bin";
			--File = "GVT2X2_FW_1.00.04t_20150617.bin";
		else
		--File = "openwrt-ltqcpe-platform_ar10-ubi.bin";
		--File = "sysimg.bin";
		--File = "fullimage.root.squash.debug.signed";
		File = "openwrt-ltqcpe-platform_ar10-ubi_debug.bin";
		--File = "GVT2X2_FWT_2.00.02-20150318.bin";
		--File = "o2_IAD_6441_FW_1.01.21T.image";
		--File = "ARV7506PW11-A-GR_FWT_1.00.46(20150430).bin";
		--File = "DSL-AC87U_v1.00.01_build01_fs_image_128_ubi.w";
		--File = "DSL-AC87U_v1.00.02T8_build01_cferom_fs_image_128_ubi_debug.w";
		end

		local acsInfo = acs.GetACSInfo();
		d = {};
		d["CommandKey"] = "testDownload";
		if acsInfo["IPv6"] == false then
			d["URL"] = acsInfo["Protocol"] .. "://" .. acsInfo["IP"] .. ":" .. acsInfo["Port"] .. "/" .. File;
		else
			d["URL"] = acsInfo["Protocol"] .. "://[" .. acsInfo["IP"] .. "]:" .. acsInfo["Port"] .. "/" .. File;
		end
		d["Username"] = "popeye";
		d["Password"] = "12345";
		d["DelaySeconds"] = 1;
		--acs.WaitForMore("nTotal", 100, 10);
		--acs.EnterQ("DownloadQ");
		acs.Download(d);
		--acs.LeaveQ("DownloadQ");
	end	

