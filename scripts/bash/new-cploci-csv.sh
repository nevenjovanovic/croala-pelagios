#!/usr/bin/env bash
# new-latlexents-csv.sh: convert the cp-croala-latlexents-novi.xlsx into csv
# (use the first sheet)
# Usage: new-latlexents-csv.sh DIRNAME/ OUTPUTDIRNAME/
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


for file in $(find "${DIRECTORY}loci-id-novi.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
    libreoffice --headless --convert-to csv --infilter=CSV:44,34,UTF8 --outdir ${2} ${file} 
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

