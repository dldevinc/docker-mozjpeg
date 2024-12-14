# mozjpeg

The `bugoman/mozjpeg` Docker image is designed to compress `.jpg` and `.jpeg` images using the `mozjpeg` tools, including `cjpeg`. This image is versatile and can handle both batch processing of multiple files and single-file processing using the `cjpeg` tool or other `mozjpeg` binaries.

## Usage

### Running the Image for Single-File Processing

To compress a single image, you can directly call the `cjpeg` tool inside the container. For example:

```shell
docker run --rm --user 1000:1000 \
    -v $(pwd)/img:/img \
    bugoman/mozjpeg \
    cjpeg -quality 85 -outfile /img/output.jpg /img/input.jpg
```

This command will compress the `input.jpg` file in the `/img` directory and save it as `output.jpg` in the same directory.

### Batch Processing: Multiple Files in a Folder

If you need to process multiple files located in a single folder, you can use the `batch.sh` script. This script will automatically find all `.jpg` and `.jpeg` files in the `/input` directory and compress them in parallel.

To run the image for batch processing, use the following command:
```shell
docker run --rm --user 1000:1000 \
    -v $(pwd)/input:/input \
    -v $(pwd)/output:/output \
    bugoman/mozjpeg \
    batch.sh -quality 85
```

The `batch.sh` script will scan the `/input` directory for `.jpg` and `.jpeg` files, compress them using multiple parallel processes, and save the compressed files to the `/output` directory. By default, the script calculates the number of parallel processes based on the system's available CPU cores to optimize performance.

#### Controlling the Number of Parallel Processes

If you want to manually control the number of parallel processes used for batch processing, you can set the `NUM_PROCESSES` environment variable. For example, to use 4 parallel processes:
```shell
docker run --rm --user 1000:1000 \
    -v $(pwd)/input:/input \
    -v $(pwd)/output:/output \
    -e NUM_PROCESSES=4 \
    bugoman/mozjpeg \
    batch.sh -quality 85
```
