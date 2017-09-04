### https://github.com/Darkade/slacktunes-mopidy
FROM alpine:latest

RUN adduser -S mopidy

RUN apk update \
    && apk upgrade \

    && apk add --no-cache \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
            --repository  http://dl-cdn.alpinelinux.org/alpine/edge/community \
            --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
            gstreamer \
            mopidy \
            py-pip \
            python-dev alpine-sdk \

    && if [[ ! -e /usr/bin/easy_install ]];  then ln -sf /usr/bin/easy_install-3.4 /usr/bin/easy_install; fi \
    && pip install --upgrade pip \
    && if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip3.4 /usr/bin/pip; fi \
    && pip install -U six \
    && pip install  Mopidy-GMusic pyasn1==0.1.8 \

    && pip install -U Mopidy-YouTube \
    && pip install -U Mopidy-Mopify \
    && pip install -U mopidy-musicbox-webclient \
    && pip install -U Mopidy-Iris \
    && pip install -U Mopidy-Moped

COPY mopidy.conf  /tmp/

RUN chown mopidy:audio -R /etc/mopidy

USER mopidy

EXPOSE 6600
EXPOSE 6680

CMD /usr/bin/mopidy --config /tmp/mopidy.conf
