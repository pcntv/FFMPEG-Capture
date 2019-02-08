set readyfolder=C:\Ready

SET /P ss=Set Start:
SET /P to=Time Out:

ffmpeg -i %1 -ss %ss% -to %to% -vf yadif,hqdn3d=1:1:4:4,scale=720x480:flags=bicubic:sws_dither=none -c:v mpeg2video -aspect 16:9 -pix_fmt yuv420p -b 6500k -bt 8192k -maxrate 9000k -c:a ac3 -ar 48000 -ab 256k -f mpegts "%readyfolder%\%~n1.ts"

PAUSE