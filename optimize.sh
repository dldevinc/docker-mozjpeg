#!/usr/bin/env sh


E_INVALID_USAGE=1
USAGE=$(cat <<-END
Usage: $0 file [options]
Examples:
  $0 ./input.jpg -optimize -progressive -outfile ./output.jpg
END
)

if [ $# -eq 0 ]; then
  >&2 echo "$USAGE"
  exit $E_INVALID_USAGE
fi


INPUTFILE=$1
shift

echo $@ | grep -qe '-outfile\b'
INPLACE=$?

if [ "$INPLACE" == "1" ]
then
	tmpfile=$(mktemp)
	/mozjpeg/bin/cjpeg $@ -outfile ${tmpfile} $INPUTFILE
	mv ${tmpfile} $INPUTFILE
else
	/mozjpeg/bin/cjpeg $@ $INPUTFILE
fi
