# mozjpeg
Docker image with compiled mozilla/mozjpeg binaries

## Usage example

```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/mozjpeg /optimize.sh /img/input.jpg -optimize -progressive -quality 80 -outfile /img/output.jpg

# same as
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/mozjpeg cjpeg -optimize -progressive -quality 80 -outfile /img/output.jpg /img/input.jpg
```

Run `optimize.sh` without `-outfile` argument to overwrite the original file:
```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/mozjpeg /optimize.sh /img/input.jpg -optimize -progressive -quality 80
```

## Build custom MozJPEG version
```shell
docker build -t mozjpeg --build-arg VERSION=3.2 https://github.com/dldevinc/docker-mozjpeg.git
```
