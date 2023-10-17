--acs.SetParameterValues("Device.PPP.Interface.1.Username", "5200123455558888#0000@t-online.de");
--acs.SetParameterValues("Device.PPP.Interface.1.Password", "tonline");
--acs.SetParameterValues("Device.PPP.Interface.1.IdleDisconnectTime", 0);
--acs.SetParameterValues("Device.PPP.Interface.1.ConnectionTrigger", "AlwaysOn");
--acs.SetParameterValues("Device.PPP.Interface.1.Reset", 1);
acs.GetParameterValues("Device.WiFi.SSID.");
acs.execute();
