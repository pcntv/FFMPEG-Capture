set readyfolder=C:\Ready
What is bit rate

ffmpeg -i %1 -vf yadif,hqdn3d=1:1:4:4,scale=720x480:flags=bicubic:sws_dither=none -c:v mpeg2video -aspect 16:9 -pix_fmt yuv420p -b  4900k -minrate 1850k -maxrate 8000k -bufsize 1835k -c:a ac3 -ar 48000 -af loudnorm=-24:8:-1 -ab 256k -f mpegts "%readyfolder%\%~n1.ts"

PAUSE