#!/bin/bash
CONDAREPO_BASE=http://repo.continuum.io/pkgs/free
MYREPO_BASE=http://cms-service-lumi.web.cern.ch/cms-service-lumi/conda-repo/
ARCH=linux-64
CONDAREPO=$CONDAREPO_BASE/$ARCH
MYREPO=$MYREPO_BASE/$ARCH
SUFFIX=".tar.bz2"

pythonpkg='python-2.7.6-1' 
condapkg='conda-3.0.6-py27_0'

filenames=($pythonpkg $condapkg 'openssl-1.0.1c-0' 'pycosat-0.6.0-py27_0' 'pyyaml-3.10-py27_0' 'readline-6.2-2' 'sqlite-3.7.13-0' 'system-5.8-1' 'tk-8.5.13-0' 'yaml-0.1.4-0' 'zlib-1.2.7-0' 'dateutil-2.1-py27_2' 'numpy-1.7.1-py27_2' 'pandas-0.13.0-np17py27_0' 'pytz-2013b-py27_0' 'qt-4.8.5-0' 'freetype-2.4.10-0' 'libpng-1.5.13-1' 'pixman-0.26.2-0' 'cairo-1.12.2-2' 'matplotlib-1.3.0-np17py27_0' 'py2cairo-1.10.0-py27_1' 'pyside-1.2.1-py27_0' 'pyparsing-1.5.6-py27_0' 'shiboken-1.2.1-py27_0' 'six-1.5.2-py27_0' 'jpeg-8d-0' 'libtiff-4.0.2-0' 'hdf5-1.8.9-1' 'h5py-2.2.1-np17py27_0' 'conda-build-1.2.0-py27_0' 'scipy-0.13.2-np17py27_2' 'pcre-8.31-0')

filenamesStr=$( printf "%s " ${filenames[@]} | sed -e 's/ *$//g')

mypkgs=('xz-5.0.5-0' 'boost-1.53.0-0' 'libstdcplus-6.0.13-0' 'root-5.99.05-0' 'coral-2.4.1-0' 'sqlplus-11.2.0.3.0__10.2.0.4.0-0' 'oraclesdk-11.2.0.3.0-0' 'oracleclientlite-11.2.0.3.0__10.2.0.4.0-0' 'frontier_client-2.8.10-0' 'pacparser-1.3.1-0' 'expat-2.0.1-0' 'xerces-c-2.8.0-0' 'libxft-2.1.13-0' 'libxext-1.1.3-0' 'libx11-1.3.2-0' 'libxpm-3.5.8-0')

mypkgsStr=$( printf "%s " ${mypkgs[@]} | sed -e 's/ *$//g')

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

for mypkg in "${mypkgs[@]}"
do
  if [ ! -f ${mypkg}${SUFFIX} ];
  then
    wget $MYREPO/${mypkg}${SUFFIX}
  fi
done

cd ..
tar cvf pkgs.tar pkgs 
cat lumicondaheader.sh pkgs.tar | sed "s/__filenames_anchor__/filenamesStr=\"${filenamesStr}\"\\nfilenames=(\$filenamesStr)/" | sed "s/__pythonpkg__/$pythonpkg/g" | sed "s/__condapkg__/$condapkg/g" | sed "s/__mypkgs_anchor__/mypkgsStr=\"${mypkgsStr}\"\\nmypkgs=(\$mypkgsStr)/" > lumiconda.run

chmod a+x lumiconda.run
echo "lumiconda.run created"
exit 0

