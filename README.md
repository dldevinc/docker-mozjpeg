# mozjpeg
Docker image with compiled mozilla/mozjpeg binaries

## Usage example

```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/mozjpeg /img/input.jpg -quality 80 -outfile /img/output.jpg
```

Run without `-outfile` argument to overwrite the original file:
```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/mozjpeg /img/input.jpg -quality 80
```

Process all JPEG files in parallel:
```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/mozjpeg /img -quality 80
```

## Build custom MozJPEG version
```shell
docker build -t mozjpeg --build-arg VERSION=3.2 https://github.com/dldevinc/docker-mozjpeg.git
```
