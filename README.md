# docker-mopidy

Based on Alpine:latest

ALSA

 `sudo docker stop mopidy; sudo docker rm mopidy;sudo docker run -d  -p 6680 -p 6600 --device /dev/snd  --name mopidy muhahacz/docker-mopidy`
