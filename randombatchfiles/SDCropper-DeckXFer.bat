SET /P ss=Set Start:
SET /P to=Time Out:
ffmpeg -i %1 -ss %ss% -to %to% -map v:0 -map a:1 -c:v libx264 -vf yadif,crop=1072:1072:184:4,scale=640x480,hqdn3d=1:1:1:1,pp=al -aspect 4:3 -profile:v main -level 3.1 -pix_fmt yuv420p -crf 18 -maxrate 4000000 -bufsize 4000001 -c:a aac -b:a 128k -af loudnorm=-16:8:-1 -ar 48k -ac 2 -threads 0 -movflags +faststart "C:\Ready\%~n1.mp4"
pause
