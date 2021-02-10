docker run --name dev.lang -itd  -v /home/dev/nlp:/home/dev/code -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY   -e GDK_SCALE   -e GDK_DPI_SCALE  base:dev.lang /bin/bash
#docker run -d -p 6866:6800  -v /etc/localtime:/etc/localtime:ro   -v /tmp/.X11-unix:/tmp/.X11-unix   -e DISPLAY=unix$DISPLAY   -e GDK_SCALE   -e GDK_DPI_SCALE  --name scrapyd  willshory/scrapyd
