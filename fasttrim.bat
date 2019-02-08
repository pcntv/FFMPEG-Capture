SET /P ss=Set Start:

ffmpeg -ss %ss% -i %1 -codec copy "C:\Ready\%~n1.mkv"
pause 
exit