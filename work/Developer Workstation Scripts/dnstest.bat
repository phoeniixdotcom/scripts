@echo off
echo CSA Website Pinger
echo *** THIS ONLY TESTS INTERNALLY ***


for %%a in (www.csatravelprotection.com www.stonebridgetravelprotection.com www.vacationprotection.com) do (
	for %%b in (www. www2. www5. staging.) do (
		echo [ Pinging %%b ]
		ping -n 3 %%b%%a
	)
)


pause

