set readyfolder=C:\Ready

SET /P hours=Length in Hours:
SET /P minutes=Length in Minutes:

node \\192.168.1.215\Public\Seth\web\calculator\calculator.js %hours% %minutes%

SET /P rate=Set Bitrate:

rem convert LENGTH to Rate


ffmpeg -y -i %1 -strict experimental -c:v libx264 -pix_fmt yuv420p -r 29.97 -s 1920x1080  -filter_complex "setsar=sar=1/1" -preset veryslow -tune film -profile high -x264opts "bitrate=%rate%:bluray-compat=1:force-cfr=1:bframes=3:ref=4:no-weightb:b-pyramid=none:vbv-bufsize=25000:level=4.1:keyint=30:tff:min-keyint=1" -flags -cgop -sn -an -slices 4 -threads 0 -f h264 -aspect 16:9 "%readyfolder%\%~n1.m4v"
ffmpeg -i %1 -c:a aac -b:a 192k -af loudnorm=-24:8:-1 -acodec pcm_s16le -ar 48000 -ac 2 "%readyfolder%\%~n1.wav"
PAUSE