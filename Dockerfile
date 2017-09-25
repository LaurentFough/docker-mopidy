FROM alpine:latest

ENV LANG C.UTF-8
ENV PYTHONIOENCODING UTF-8

ENV MOPIDY_VERSION 2.1.0

ENV UID 1000
ENV USER htpc
ENV GROUP htpc


RUN addgroup -S ${GROUP} && adduser -D -S -u ${UID} ${USER} ${GROUP} \
 && echo "@main http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
 && echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk upgrade --no-cache --available \
 && apk add --no-cache \
        gst-libav@main \
        gst-plugins-good@main \
        gst-plugins-ugly@main \
        py-gst@community \
        py-pip \
        tzdata \
        python \
        python-dev \
        alpine-sdk \
        libffi-dev \
 && pip install -U pip \
 && pip install \
        Mopidy-Internetarchive \
        Mopidy-MusicBox-Webclient \
        Mopidy-Podcast \
        Mopidy-Scrobbler \
        Mopidy-TuneIn \
        Mopidy-YouTube \
        Mopidy-SoundCloud \
        Mopidy-Emby \
        Mopidy-Mopify \
        Mopidy-Iris \
        Mopidy-Moped \
        spotipy \
#        Mopidy-Spotify \
        mopidy==${MOPIDY_VERSION} 

RUN apk update --no-cache && apk del alpine-sdk

COPY mopidy.conf /var/lib/mopidy/local/

VOLUME /var/lib/mopidy/local
VOLUME /var/lib/mopidy/media

EXPOSE 6680 6600

LABEL name=Mopidy
LABEL version=${MOPIDY_VERSION}
LABEL url=https://api.github.com/repos/mopidy/mopidy/releases/latest

USER ${USER}

CMD /usr/bin/mopidy --config /tmp/mopidy.conf
