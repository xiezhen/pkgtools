#!/bin/bash
CONDAREPO_BASE=http://repo.continuum.io/pkgs/free
MYREPO_BASE=http://cms-service-lumi.web.cern.ch/cms-service-lumi/conda-repo/
ARCH=linux-64
CONDAREPO=$CONDAREPO_BASE/$ARCH
MYREPO=$MYREPO_BASE/$ARCH
SUFFIX=".tar.bz2"
pythonpkg='python-2.7.6-1' 
condapkg='conda-3.0.6-py27_0'

filenames=($pythonpkg $condapkg 'openssl-1.0.1c-0' 'pyyaml-3.10-py27_0' 'readline-6.2-2' 'sqlite-3.7.13-0' 'system-5.8-1' 'yaml-0.1.4-0' 'zlib-1.2.7-0' 'dateutil-2.1-py27_2' 'numpy-1.7.1-py27_2' 'pandas-0.13.0-np17py27_0' 'pytz-2013b-py27_0'  'six-1.5.2-py27_0' 'hdf5-1.8.9-1' 'h5py-2.2.1-np17py27_0' 'conda-build-1.2.0-py27_0' )

filenamesStr=$( printf "%s " ${filenames[@]} | sed -e 's/ *$//g')

mypkgs=('xz-5.0.5-0' 'boost-1.53.0-0' 'libstdcplus-6.0.13-0' 'coral-2.4.2-0' 'sqlplus-11.2.0.3.0__10.2.0.4.0-0' 'oraclesdk-11.2.0.3.0-0' 'oracleclientlite-11.2.0.3.0__10.2.0.4.0-0' 'frontier_client-2.8.10-0' 'pacparser-1.3.1-0' 'expat-2.0.1-0' 'xerces-c-2.8.0-0' )

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
  rm -rf ${filename}
  bunzip2 -f ${filename}${SUFFIX}
  tar --delete --file=${filename}.tar lib/libexpat.a >/dev/null 2>&1
  tar --delete --file=${filename}.tar share/doc >/dev/null 2>&1
  tar --delete --file=${filename}.tar share/man >/dev/null 2>&1
  tar --delete --file=${filename}.tar lib/python2.7/*/tests >/dev/null 2>&1
  tar --delete --file=${filename}.tar lib/python2.7/site-packages/*/tests >/dev/null 2>&1
  bzip2 -f ${filename}.tar
done

for mypkg in "${mypkgs[@]}"
do
  if [ ! -f ${mypkg}${SUFFIX} ];
  then
    wget $MYREPO/${mypkg}${SUFFIX}
  fi
  rm -rf ${mypkg} 
  bunzip2 ${mypkg}${SUFFIX}
  echo $mypkg
  tar --delete --file=${mypkg}.tar share/doc >/dev/null 2>&1
  tar --delete --file=${mypkg}.tar share/man >/dev/null 2>&1
  tar --delete --file=${mypkg}.tar include/xercesc >/dev/null 2>&1
  tar --delete --file=${mypkg}.tar lib/libxerces-c.so >/dev/null 2>&1 
  bzip2 -f ${mypkg}.tar
done

cd ..
cp dellist.txt pkgs
tar cvf pkgs.tar pkgs 

cat brilcondaheader.sh pkgs.tar | sed "s/__filenames_anchor__/filenamesStr=\"${filenamesStr}\"\\nfilenames=(\$filenamesStr)/" | sed "s/__pythonpkg__/$pythonpkg/g" | sed "s/__condapkg__/$condapkg/g" | sed "s/__mypkgs_anchor__/mypkgsStr=\"${mypkgsStr}\"\\nmypkgs=(\$mypkgsStr)/" > brilcondacore.run

chmod a+x brilcondacore.run
rm -f pkgs.tar
rm -rf pkgs
echo "brilcondacore.run created"
exit 0

