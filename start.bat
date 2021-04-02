@ECHO OFF
java -Xgc:concurrentScavenge -Xgc:dnssExpectedTimeRatioMaximum=3 -Xgc:scvNoAdaptiveTenure -Xdisableexplicitgc -Xmx3072M -Xms3072M -Xmns1536M -Xmnx2458M -jar paper-1.16.5-575.jar nogui
pause