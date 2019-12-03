FROM alpine:3.7 as builder
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

WORKDIR /src/mozjpeg-${VERSION}
RUN autoreconf -fiv && ./configure --with-jpeg8 && make install


FROM alpine:3.7
COPY --from=builder /opt/mozjpeg /opt/mozjpeg
COPY ./optimize.sh /optimize.sh
ENV PATH=${PATH}:/opt/mozjpeg/bin
