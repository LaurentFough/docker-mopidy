FROM alpine:latest

RUN   echo "@main http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
 && echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk upgrade --no-cache --available \
 && apk add --no-cache \
        gstreamer \
        gstreamer-tools@main \
        gst-plugins-base@main \
        gst-plugins-good@main \
        gst-plugins-ugly@main \
        py-gst@community \
        py2-pip \
        python2 \
        python2-dev \
 && pip2 install \
        mopidy && \
        mkdir -p /var/lib/mopidy 

RUN pip2 install  Mopidy-Mopify \
        Mopidy-TuneIn

COPY mopidy.conf /var/lib/mopidy/

VOLUME /var/lib/mopidy/local
VOLUME /var/lib/mopidy/media

EXPOSE 6680 6600

CMD /usr/bin/mopidy --config /var/lib/mopidy/mopidy.conf
