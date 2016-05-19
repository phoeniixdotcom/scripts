net time \\japan /set /yes

rem static route for ireland
route delete 10.11.9.0
route add 10.11.9.0 mask 255.255.255.0 10.10.1.35 /p

rem static route for yuma
route delete 10.14.3.0
route add 10.14.3.0 mask 255.255.255.0 10.10.1.35 /p


route delete 10.14.2.0
route add 10.14.2.0 mask 255.255.255.0 10.10.1.35 /p


