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
		err = acs.GetError();
		if (err ~= "0") then
			print("Upload Failure: Errorcode =  " .. err);
		else
			print("Upload success.");
		end
		-- tc = acs.TransferComplete();
		-- print("Start: " .. tc["StartTime"]);
		-- print("Complete: " .. tc["CompleteTime"]);
		-- acs.SetVar("connreq", 1);
	else
		d = {}
		d["CommandKey"] = "testUpload";
		d["URL"] = "http://10.118.16.161/DeviceCfg.cfg";
		d["Username"] = "Popeye";
		d["Password"] = "12345678";
		d["DelaySeconds"] = 3;
		-- d["FileType"] = "2 Vendor Log File";

		acs.Upload(d);
		err = acs.GetError();
		if err ~= "0" then
			print("Error = " .. err);
		end
	end		
