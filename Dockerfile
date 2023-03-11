FROM alpine:3.17 AS build

ARG VERSION

RUN apk add --update --no-cache build-base cmake curl-dev python3 musl-libintl linux-headers \
 && cd /tmp \
 && wget https://github.com/transmission/transmission/releases/download/${VERSION}/transmission-${VERSION}.tar.xz \
 && tar -xf transmission-${VERSION}.tar.xz \
 && cd transmission-${VERSION} \
 && mkdir build \
 && cd build \
 && cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. \
 && make transmission-daemon \
 && make install/strip

# ---

FROM alpine:3.17 AS transmission-daemon

RUN apk add --update --no-cache \
        libcrypto3 libcurl libdeflate libevent libgcc libintl libssl3 libstdc++ miniupnpc \
 && addgroup -g 101 transmission \
 && adduser -h /var/lib/transmission -g transmission -u 100 -G transmission -S transmission

COPY --from=build /usr/local/ /usr/local/

EXPOSE 9091

USER transmission

ENTRYPOINT [ "/usr/local/bin/transmission-daemon" ]
CMD [ "--foreground", "--log-level=error" ]