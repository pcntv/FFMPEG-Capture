ffmpeg -i %1 -c:v libx264 -level 41 -pix_fmt yuv420p -preset medium -crf 19 -g 24 -vf setsar=sar=1/1 -threads 8 -x264opts bluray-compat=1:vbv-bufsize=15000:vbv-maxrate=30000 -c:a ac3 -strict experimental -ar 48000 -ab 256k -y output.h264
pause