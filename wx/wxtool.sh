docker run --name dev.lang.wine.wx -itd --privileged=true  -v /dev:/dev  -v /home/dev/nlp:/home/dev/code -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/run/dbus:/var/run/dbus -v /run/systemd:/run/systemd -v /usr/bin/systemctl:/usr/bin/systemctl -v /etc/systemd/system:/etc/systemd/system -e DISPLAY=unix$DISPLAY   -e GDK_SCALE   -e GDK_DPI_SCALE  base:dev.lang.wine.wx /bin/bash
#docker run -d -p 6866:6800  -v /etc/localtime:/etc/localtime:ro   -v /tmp/.X11-unix:/tmp/.X11-unix   -e DISPLAY=unix$DISPLAY   -e GDK_SCALE   -e GDK_DPI_SCALE  --name scrapyd  willshory/scrapyd

#docker run -it -v /var/run/dbus:/var/run/dbus -v /run/systemd:/run/systemd -v /usr/bin/systemctl:/usr/bin/systemctl -v /etc/systemd/system:/etc/systemd/system debian:jessie /bin/bash

#   42  apt-get install apt-utils
#   43  vim /var/lib/dpkg/statoverride

