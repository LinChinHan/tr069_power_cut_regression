
	result = vfy.run("ping -t 8.8.8.8", 0, 10, 20);
	print("\nPrin out")
	if (result ~= nil) then
		for i = 1, #result do
			print(result[i]);
		end
	end
	