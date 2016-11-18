FROM alpine:3.4

RUN apk add --no-cache --update \
	transmission-daemon \
	python \
	py-pip \
    && pip install transmissionrpc \
    && pip install flexget

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 9091 60198 60198/udp 5050

USER transmission

ENTRYPOINT [ "sh", "/docker-entrypoint.sh" ]

