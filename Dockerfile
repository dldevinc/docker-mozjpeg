FROM alpine as builder
ARG VERSION=3.3.1


RUN apk --update add \
	autoconf \
	automake \
	build-base \
	libtool \
	nasm \
	pkgconf \
	tar

WORKDIR /src
ADD https://github.com/mozilla/mozjpeg/archive/v${VERSION}.tar.gz ./
RUN tar -xzf v${VERSION}.tar.gz
RUN cd /src/mozjpeg-${VERSION} && \
	autoreconf -fiv && \
	./configure --with-jpeg8 && \
	make && \
	make install


FROM bugoman/pexec

COPY --from=builder /opt/mozjpeg /opt/mozjpeg
COPY ./docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
