
:: Change your destinations here
set readyfolder=C:\Ready
set bumperfolder=F:\keepthis
set videoCodec=-map v:0 -map a:0 -c:v libx264 -s 1280x720 -crf 18 -profile:v main -level 3.1 -pix_fmt yuv420p -maxrate 4000000 -bufsize 4000001
set audioCodec=-c:a aac -b:a 128k -af loudnorm=-16:8:-1 -ar 48000 -movflags +faststart
set transportCodec=-bsf:v h264_mp4toannexb -f mpegts

  

:choice
set /P c=Do you need to set an IN and OUT[Y/N]?
if /I "%c%" EQU "Y" goto :trim
if /I "%c%" EQU "N" goto :originalnotrim
goto :choice


:trim
SET /P ss=Set Start:
SET /P to=Time Out:
goto :original


:original
ffmpeg -i %1 -ss %ss% -to %to% %videoCodec% %audioCodec%  %transportCodec% "%readyfolder%\%~n1.ts"
echo "ALL DONE Upload %~n1 USE BATCH TO COMBINE"
pause 
exit

:originalnotrim
ffmpeg -i %1 %videoCodec% %audioCodec% %transportCodec% "%readyfolder%\%~n1.ts"
echo "ALL DONE Upload %~n1 USE BATCH TO COMBINE"
pause 
exit