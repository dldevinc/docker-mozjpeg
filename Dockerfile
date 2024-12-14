FROM alpine AS builder
ARG VERSION=4.1.1

RUN apk --update add \
  cmake \
  clang \
  make \
  nasm

WORKDIR /src

RUN wget -qO v${VERSION}.tar.gz https://codeload.github.com/mozilla/mozjpeg/tar.gz/v${VERSION} \
 && tar -xzf v${VERSION}.tar.gz \
 && cd ./mozjpeg-${VERSION} \
 && cmake -G"Unix Makefiles" -DPNG_SUPPORTED=0 -DCMAKE_BUILD_TYPE=Release . \
 && make \
 && make install


FROM alpine
COPY --from=builder /opt/mozjpeg /opt/mozjpeg

RUN mkdir /input \
 && mkdir /output

ADD ./batch.sh /usr/local/bin

ENV PATH="$PATH:/opt/mozjpeg/bin"

CMD ["batch.sh"]
