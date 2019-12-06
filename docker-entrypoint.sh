#!/usr/bin/env sh


E_INVALID_USAGE=1
USAGE=$(cat <<-END
Usage: $0 file [options]
Examples:
  $0 ./input.jpg -quality 80 -outfile ./output.jpg
END
)

if [ $# -eq 0 ]; then
    >&2 echo "$USAGE"
    exit $E_INVALID_USAGE
fi


echo $@ | grep -qe '-outfile\b'
INPLACE=$?


if [ -d "$1" ]; then
    if [ $INPLACE -ne 1 ]; then
        echo "Invalid arguments" 1>&2
        exit 1
    fi

    folder=$1
    shift
    options=$@

    # Find all JPEG files
    for file in $folder/*; do
        if [ -f "$file" ] && echo "$file" | grep -qiE ".jpe?g"; then
            echo "$file" >> /tmp/images.list
        fi
    done

	# Process files in parallel
    pexec -f /tmp/images.list -e IMG -c -o - -- "$0 \$IMG $options"
else
	# Process single file
    file=$1
    shift
    options=$@

    if [ $INPLACE -eq 1 ]; then
        tmpfile=$(mktemp)
        /opt/mozjpeg/bin/cjpeg $options -outfile ${tmpfile} $file
        mv ${tmpfile} $file
    else
        exec /opt/mozjpeg/bin/cjpeg cjpeg $options $file
    fi
fi
