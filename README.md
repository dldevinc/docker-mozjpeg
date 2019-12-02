# mozjpeg
Docker image with compiled mozilla/mozjpeg binaries

# Usage example

```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/mozjpeg sh -c "/optimize.sh /img/input.jpg -optimize -progressive -quality 80 -outfile /img/output.jpg"
```

Skip `-outfile` to overwrite original file:
```shell
docker run --user 1000:1000 --rm -v $(pwd):/img bugoman/mozjpeg sh -c "/optimize.sh /img/input.jpg -optimize -progressive -quality 80"
```
