FROM alpine:3.7 as builder
ARG MOZJPEG_VERSION=3.3.1


RUN apk --update add \
	autoconf \
	automake \
	build-base \
	libtool \
	nasm \
	pkgconf \
	tar

WORKDIR /src
ADD https://github.com/mozilla/mozjpeg/archive/v${MOZJPEG_VERSION}.tar.gz ./
RUN tar -xzf v${MOZJPEG_VERSION}.tar.gz

WORKDIR /src/mozjpeg-${MOZJPEG_VERSION}
RUN autoreconf -fiv && ./configure --with-jpeg8 --prefix=/mozjpeg && make install


FROM alpine:3.7
COPY --from=builder /mozjpeg /mozjpeg
COPY ./optimize.sh /optimize.sh
