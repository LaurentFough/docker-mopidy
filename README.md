# docker-mopidy

Based on Alpine:latest

ALSA
https://gstreamer.freedesktop.org/documentation/frequently-asked-questions/using.html

 `sudo docker rm -f mopidy;sudo docker run -d -p 6680:6680 -p 6600:6600 --device /dev/snd  --name mopidy -v mopidy:/opt/mopidy lukasmrtvy/docker-mopidy`
