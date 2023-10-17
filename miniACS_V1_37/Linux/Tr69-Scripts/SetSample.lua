
	para = acs.GetParameterNames("Device.PeriodicStatistics.SampleSet.", "true");
	nSample = 0;
	for key, value in pairs(para) do
		nSample = nSample + 1;
	end
	if (nSample == 0) then
		acs.AddObject("Device.PeriodicStatistics.SampleSet.");
		acs.AddObject("Device.PeriodicStatistics.SampleSet.");
	end
	para = acs.GetParameterNames("Device.PeriodicStatistics.SampleSet.1.Parameter.", "true");
	nParameter = 0;
	for key, value in pairs(para) do
		nParameter = nParameter + 1;
	end
	if (nParameter == 0) then
		acs.AddObject("Device.PeriodicStatistics.SampleSet.1.Parameter.");
		acs.AddObject("Device.PeriodicStatistics.SampleSet.1.Parameter.");
		acs.AddObject("Device.PeriodicStatistics.SampleSet.2.Parameter.");
		acs.AddObject("Device.PeriodicStatistics.SampleSet.2.Parameter.");
	end

	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.Enable", 1);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.TimeReference", "2013-07-22T07:00:00");
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.SampleInterval", 180);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.ReportSamples", 24);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.FetchSamples", 12);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.Parameter.1.Enable", 1);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.Parameter.1.Reference", "Device.Time.CurrentLocalTime");
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.Parameter.2.Enable", 1);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.1.Parameter.2.Reference", "Device.Hosts.HostNumberOfEntries");

	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.Enable", 1);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.TimeReference", "2013-07-22T07:00:30");
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.SampleInterval", 180);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.ReportSamples", 24);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.FetchSamples", 12);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.Parameter.1.Enable", 1);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.Parameter.1.Reference", "Device.Time.CurrentLocalTime");
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.Parameter.2.Enable", 1);
	acs.SetParameterValues("Device.PeriodicStatistics.SampleSet.2.Parameter.2.Reference", "Device.DeviceInfo.ProcessStatus.CPUUsage");
	acs.execute();
	err = acs.GetError();
	if (err ~= "0") then
		print("Set err " .. err);
	end
	
	
	
	