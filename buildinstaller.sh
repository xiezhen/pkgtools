#!/bin/bash
CONDAREPO_BASE=http://repo.continuum.io/pkgs/free
ARCH=linux-64
CONDAREPO=$CONDAREPO_BASE/$ARCH
SUFFIX=".tar.bz2"

filenames=('python-2.7.6-1' 'openssl-1.0.1c-0' 'pycosat-0.6.0-py27_0' 'pyyaml-3.10-py27_0' 'readline-6.2-2' 'sqlite-3.7.13-0' 'system-5.8-1' 'tk-8.5.13-0' 'yaml-0.1.4-0' 'zlib-1.2.7-0' 'conda-3.0.0-py27_0')
filenameStr=$( printf "%s " ${filenames[@]} | sed -e 's/ *$//g')

rm -f pkgs.tar
mkdir -p pkgs
cd pkgs

for filename in "${filenames[@]}"
do
  if [ ! -f ${filename}${SUFFIX} ];
  then
    wget $CONDAREPO/${filename}${SUFFIX}
  fi
done
cd ..
tar cvf pkgs.tar pkgs 
cat lumicondaheader.sh pkgs.tar | sed "s/__filenames_anchor__/filenamesStr=\"${filenameStr}\"\\nfilenames=(\$filenamesStr)/" > lumiconda.run
echo "lumiconda.run created"
exit 0

