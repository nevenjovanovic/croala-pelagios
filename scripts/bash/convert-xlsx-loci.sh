#!/usr/bin/env bash
# convert-xslx.sh: convert a number of .xslx files into csv
# (use the first sheet everywhere)
# depends on: rclone, xlsx2csv
# Usage: convert-xslx.sh DIRNAME/ OUTPUTDIRNAME/
# for using find, see http://superuser.com/questions/715007/ls-with-glob-not-working-in-a-bash-script
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
   echo "Syncing remote directory croala-pelagios to ${DIRECTORY}..."
   rclone sync remote:croala-pelagios ${DIRECTORY}
fi

for file in $(find "${DIRECTORY}" -regextype posix-awk -regex ".*-loci.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
    xlsx2csv -i -s1 ${file} ${2}${newname}
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

