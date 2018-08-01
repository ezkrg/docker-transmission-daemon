FROM alpine:3.8

RUN apk add --no-cache --update \
	transmission-daemon

EXPOSE 9091 60198 60198/udp

USER transmission

ENTRYPOINT [ "/usr/bin/transmission-daemon", "--foreground", "--log-error" ]