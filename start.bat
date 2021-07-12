@ECHO OFF
:: ===============================================================
:: Minecraft Startup Script
:: To be used with AdoptOpenJDK 16 + OpenJ9 and PaperMC 1.16.5
:: ===============================================================
::  
::  
:: Get Current Public IPv4 Address and Print it to Console
nslookup myip.opendns.com. resolver1.opendns.com
:: 
:: Display Java Version
java -version
:: 
:: Start Minecraft Server
::  
:: Xmns should be Xms/4 and Xmnx should be ((Xmx*2)/5). Xms is usually set to 4096, adjust according to your needs.
:: Flags are meant for OpenJ9. For more information, go here https://steinborn.me/posts/tuning-minecraft-openj9/
java -Xgc:concurrentScavenge -Xgcpolicy:balanced -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:scvNoAdaptiveTenure -Xdisableexplicitgc -Xmx4096M -Xms4096M -Xmns1024M -Xmnx1639M -jar paper-1.16.5-778.jar nogui
:: 
:: Wait for Keypress before closing Console
pause