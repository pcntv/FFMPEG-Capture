@echo off
:: Change your destinations here
set readyfolder=C:\Ready
set bumperfolder=F:\keepthis
set videoCodec=-map v:0 -map a:0 -c:v libx264 -s 1280x720 -crf 18 -profile:v main -level 3.1 -pix_fmt yuv420p -maxrate 4000000 -bufsize 4000001 
set audioCodec=-c:a aac -b:a 128k -af loudnorm=-16:8:-1,bass=g=-9:f=40 -ar 48000 -movflags +faststart 

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