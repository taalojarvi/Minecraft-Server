@ECHO OFF
:: ===============================================================
:: Minecraft Bootstrap Script
:: To be used with Eclipse Temurin 17 and PaperMC 1.18.1
:: ===============================================================
::  
::  
:: [DEPRECATED] Get Current Public IPv4 Address and Print it to Console
::FOR /F "tokens=*" %%a in ('curl  --ipv4 ifconfig.me') do SET MYIP=%%a
:: SET DISCORD_WEBHOOK_URL=[REDACTED]
::echo Server is booting up! | discat.exe -u %DISCORD_WEBHOOK_URL%
:: echo Server's Address is %MYIP%:25565 | discat.exe -u %DISCORD_WEBHOOK_URL%
:: echo Server's LiveAtlas Map Address is http://%MYIP%:8123 | discat.exe -u %DISCORD_WEBHOOK_URL%
:: 
:: Couldn't figure out how to parse json. Hence this kinky fudgery of echo commands
FOR /F "tokens=*" %%a in ('curl  --ipv4 ifconfig.me') do SET MYIP=%%a
SET DISCORD_WEBHOOK_URL=[REDACTED]
echo { > temp.json
echo "embeds": [ >> temp.json
echo { >> temp.json
echo "title":"Server is booting up!", >> temp.json
echo "url":"https://github.com/taalojarvi/Minecraft-Server", >> temp.json
echo  "color":6711211, >> temp.json
echo "footer":{ >> temp.json
echo "text":"The standard Discord webhook has two parts you see - The web and the hook. An elegant design!">> temp.json
echo }, >> temp.json
echo "thumbnail":{ >> temp.json
echo "url":"https://media.forgecdn.net/avatars/310/463/637398807454019141.png" >> temp.json
echo }, >> temp.json
echo  "author":{ >> temp.json
echo "name":"Pongi's Minecraft Server", >> temp.json
echo "url":"https://discordapp.com" >> temp.json
echo }, >> temp.json
echo "fields":[ >> temp.json
echo { >> temp.json
echo "name":"Server IP Address:", >> temp.json
echo "value":"%MYIP%:25565" >> temp.json
echo }, >> temp.json
echo { >> temp.json
echo "name":"Server LiveAtlas Address:", >> temp.json
echo "value":"http://%MYIP%:8123" >> temp.json
echo }]}]}>> temp.json
:: xidel.exe -s -e "{"embed":{"title":"Server is booting up!","url":"https:\/\/github.com\/taalojarvi\/Minecraft-Server","color":6711211,"footer":{"text":"The standard Discord webhook has two parts you see - The web and the hook. An elegant design!"},"thumbnail":{"url":"https:\/\/media.forgecdn.net\/avatars\/310\/463\/637398807454019141.png"},"author":{"name":"Pongi's Minecraft Server","url":"https:\/\/discordapp.com"},"fields":[{"name":"Server IP Address:","value":"%MYIP%:25565"},{"name":"Server LiveAtlas Address:","value":"http:\/\/%MYIP%:8123"}]}}"
curl -v -d @temp.json --header "Content-Type: application/json" %DISCORD_WEBHOOK_URL%

:: Display Java Version
java -version
:: 
:: Start Minecraft Server
::  
:: Xmns should be >6GB
:: Aikar's flags are included
java -Xms8G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper-1.18.jar nogui
:: 
:: Wait for Keypress before closing Console
pause
