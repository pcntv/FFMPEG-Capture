ffmpeg -i %1 -map 0 -dn -sn -c:v copy -c:a copy "F:\randombatchfiles\%~n1.avi"
pause
