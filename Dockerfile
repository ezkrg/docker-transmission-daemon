FROM alpine:3.6

RUN apk add --no-cache --update \
	transmission-daemon \
	python \
	py-pip \
	supervisor \
    && pip install transmissionrpc \
    && pip install flexget

COPY supervisor/ /etc/supervisor/
COPY healthcheck.sh /healthcheck.sh

EXPOSE 9091 60198 60198/udp 5050

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]

HEALTHCHECK --interval=100s --timeout=50s CMD sh /healthcheck.sh || exit 1