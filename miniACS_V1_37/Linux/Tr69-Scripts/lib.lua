	function PrintParameters(Paras)
		if Paras ~= nil then
			local keys = {}
			for key in pairs(Paras) do
				keys[#keys+1]=key
			end
			table.sort(keys)
			for i = 1, #keys do
				print(keys[i] .. "=".. Paras[keys[i]])
			end
		end
	end

	function PrintParametersName(Paras)
		if Paras ~= nil then
			local keys = {}
			for key in pairs(Paras) do
				keys[#keys+1]=key
			end
			table.sort(keys)
			for i = 1, #keys do
				if Paras[keys[i]] == "1" then
					print(keys[i] .. " ReadWrite")
				else
					print(keys[i] .. " Read")
				end
			end
		end
	end
	