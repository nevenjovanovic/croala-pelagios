#!/usr/bin/env bash
# convert-xslx.sh: convert a number of .xslx files into csv
# (use the first sheet everywhere)
# depends on: rclone, xlsx2csv, libreoffice
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
# 0. Sync with google drive
DIRECTORY=$1
if [ -d "$DIRECTORY" ]; then
   echo "Syncing remote directory croala-pelagios to ${DIRECTORY}..."
   rclone sync remote:croala-pelagios ${DIRECTORY}
fi

# 1. convert morphology to CSV
for file in $(find "${DIRECTORY}" -regextype posix-awk -regex ".*-morphologia.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
    xlsx2csv -i -s1 ${file} ${2}${newname}
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

# 2. convert place identifications to CSV
for file in $(find "${DIRECTORY}" -regextype posix-awk -regex ".*-loci-id.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
    xlsx2csv -i -s1 ${file} ${2}${newname}
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

# 3. convert periods to CSV
for file in $(find "${DIRECTORY}" -regextype posix-awk -regex ".*-aetates-id.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
    libreoffice --headless --convert-to csv --infilter=CSV:44,34,UTF8 --outdir ${2} ${file}
#    xlsx2csv -i -s1 ${file} ${2}${newname}
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

# 4. convert place entities to CSV
for file in $(find "${DIRECTORY}loci-id-novi.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
    libreoffice --headless --convert-to csv --infilter=CSV:44,34,UTF8 --outdir ${2} ${file} 
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

# 5. convert period entities to CSV
for file in $(find "${DIRECTORY}aetates-id-novae.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
    libreoffice --headless --convert-to csv --infilter=CSV:44,34,UTF8 --outdir ${2} ${file} 
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

# 6. convert lexical entities to CSV
for file in $(find "${DIRECTORY}cp-croala-latlexents-novi.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
    libreoffice --headless --convert-to csv --infilter=CSV:44,34,UTF8 --outdir ${2} ${file} 
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

# 7. convert estlocus qualifications to CSV

for file in $(find "${DIRECTORY}" -regextype posix-awk -regex ".*-loci.xlsx")
do
    modified=`date -r ${file}`
    newname=$(basename ${file%.*}).csv
#    xlsx2csv -i -s1 ${file} ${2}${newname}
    libreoffice --headless --convert-to csv --infilter=CSV:44,34,UTF8 --outdir ${2} ${file}
    echo "File ${2}${newname} updated to the version last modified on ${modified}."
done

# copy results

cp ${2}*morphologia.csv csv/morph/
cp ${2}*cp-croala-latlexents-novi.csv csv/morph/
cp ${2}*-loci-id.csv csv/loci/
cp ${2}*-loci.csv csv/loci/
cp ${2}*loci-id-novi.csv csv/loci/
cp ${2}*-aetates-id.csv csv/aetates/
cp ${2}*aetates-id-novae.csv csv/aetates/

# End
