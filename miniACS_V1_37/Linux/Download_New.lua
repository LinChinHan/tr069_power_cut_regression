	MF, OUI, PD, SN = acs.GetDeviceInfo()
	print (MF .. " " .. OUI .. " " .. PD .. " " .. SN)
	e = acs.GetEvent();

	isTransferComplete = 0;
	for i = 1, #e do
		print ("Evnet" ..i.. " = " .. e[i]);
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
	else
		--local File = "openwrt-ltqcpe-platform_ar10-ubi.bin";
		local File = "14.bin";
		--local File = "fullimage.root.squash.debug.signed";
		--local File = "openwrt-ltqcpe-platform_ar10-ubi_debug.bin";
		--local File = "openwrt-ltqcpe-platform_vr9-ubi.bin";
		--local File = "GVT2X2_FWT_2.00.02-20150318.bin";
		--local acsInfo = acs.GetACSInfo();
		d = {};
		d["CommandKey"] = "testDownload";
		d["URL"] = "http://129.16.11.217/KVD21_0.00.22_230922_053000_19167f10.bin";
		d["Username"] = "popeye";
		d["Password"] = "12345";
		d["DelaySeconds"] = 1;

		--acs.Download(d);
		acs.Download(d);
	end		
