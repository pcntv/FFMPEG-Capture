
:: Change your destinations here
set readyfolder=C:\Ready
set bumperfolder=F:\keepthis
set videoCodec=--c copy -bsf:v h264_mp4toannexb -f mpegts
set audioCodec=-c:a aac -b:a 128k -af loudnorm=-16:8:-1,bass=g=-9:f=40 -ar 48000 -movflags +faststart 


ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal %1 > tmpFile 
set /p myvar= < tmpFile 
del tmpFile 
echo %myvar%
ffmpeg -i %1 -c copy -bsf:v h264_mp4toannexb -f mpegts  "%bumperfolder%\tttt.ts"
ffmpeg -f concat -safe 0 -i "%bumperfolder%\listFace.txt" -c copy -bsf:a aac_adtstoasc "%readyfolder%\%~n1.mp4"
del "%bumperfolder%\tttt.ts"


PAUSE
  

:choice
set /P c=Do you need to set an IN and OUT[Y/N]?
if /I "%c%" EQU "Y" goto :trim
if /I "%c%" EQU "N" goto :bumperchoicenotrim
goto :choice

:bumperchoice
set /P c=Do you need a bumper[Y/N]?
if /I "%c%" EQU "Y" goto :bumper
if /I "%c%" EQU "N" goto :original
goto :bumperchoice

:bumperchoicenotrim
set /P c=Do you need a bumper[Y/N]?
if /I "%c%" EQU "Y" goto :bumpernotrim
if /I "%c%" EQU "N" goto :originalnotrim
goto :bumperchoicenotrim

:trim
SET /P ss=Set Start:
SET /P to=Time Out:
goto :bumperchoice

:bumpernotrim
ffmpeg -i %1 %videoCodec% %audioCodec% "%bumperfolder%\tttt.mp4"
ffmpeg -f concat -safe 0 -i "%bumperfolder%\list.txt" -c copy "%readyfolder%\%~n1.mp4"
del "%bumperfolder%\tttt.mp4"
echo "ALL DONE Upload %~n1 to Brightcove"
pause
exit

:bumper
ffmpeg -i %1 -ss %ss% -to %to% %videoCodec% %audioCodec% "%bumperfolder%\tttt.mp4"
ffmpeg -f concat -safe 0 -i "%bumperfolder%\list.txt" -c copy "%readyfolder%\%~n1.mp4"
del "%bumperfolder%\tttt.mp4"
echo "ALL DONE Upload %~n1 to Brightcove"
pause
exit

:original
ffmpeg -i %1 -ss %ss% -to %to% %videoCodec% %audioCodec%"%readyfolder%\%~n1.mp4"
echo "ALL DONE Upload %~n1 to Brightcove"
pause 
exit

:originalnotrim
ffmpeg -i %1 %videoCodec% %audioCodec% "%readyfolder%\%~n1.mp4"
echo "ALL DONE Upload %~n1 to Brightcove"
pause 
exit