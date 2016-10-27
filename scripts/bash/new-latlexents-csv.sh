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


for file in `ls ${DIRECTORY}cp-croala-latlexents-novi.xlsx`;
do newname=$(basename ${file%.*}).csv
xlsx2csv -i -s 1 --dateformat="%Y-%m-%d" ${file} ${2}${newname}
echo "File ${newname} converted to csv."
done

