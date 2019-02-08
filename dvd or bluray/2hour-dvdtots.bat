set readyfolder=C:\Ready

ffmpeg -i %1 -vf yadif,hqdn3d=1:1:4:4,scale=720x480:flags=bicubic:sws_dither=none -c:v mpeg2video -aspect 16:9 -pix_fmt yuv420p -b 3450k -minrate 1350k -maxrate 8000k -c:a ac3 -ar 48000 -af loudnorm=-24:8:-1 -ab 256k -f mpegts "%readyfolder%\%~n1.ts"

PAUSE