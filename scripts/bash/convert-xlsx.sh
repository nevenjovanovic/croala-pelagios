#!/usr/bin/env bash
# convert-xslx.sh: convert a number of .xslx files into csv
# (use the first sheet everywhere)
# Usage: convert-xslx.sh DIRNAME/ OUTPUTDIRNAME/
# 2016/10/27

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app

arg1="${1:-}"

DIRECTORY=$1
if [ -d "$DIRECTORY" ]; then
   rclone sync remote:croala-pelagios ${DIRECTORY}
   echo "Syncing remote directory croala-pelagios to ${DIRECTORY}..."
fi

for file in `ls ${DIRECTORY}*-morphologia.xlsx`;
do newname=$(basename ${file%.*}).csv
xlsx2csv -i -s1 ${file} ${2}${newname}
echo "File ${newname} converted to csv."
done

