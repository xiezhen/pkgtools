#!/bin/bash

WORKDIR=`pwd`
if [ -n "$1" ]; then
   WORKDIR=$1
fi
cd ${WORKDIR}

LUMICONDA_ROOT="${WORKDIR}/lumiconda"
source ${LUMICONDA_ROOT}/bin/activate ${LUMICONDA_ROOT}

INSTALL_FLAGS="--yes --quiet"
LUMICONDA_VERSION="0.0.1"
#major : miniconda version; minor pkg composition; trivial pkg version

conda install $INSTALL_FLAGS conda-build=1.2.0
conda install $INSTALL_FLAGS pandas=0.13.1
conda install $INSTALL_FLAGS matplotlib=1.3.1
conda install $INSTALL_FLAGS h5py=2.2.1
conda install $INSTALL_FLAGS pcre=8.31
conda install $INSTALL_FLAGS libtiff=4.0.2
conda install $INSTALL_FLAGS jpeg=8d
conda install $INSTALL_FLAGS libxml2=2.9.0

conda install $INSTALL_FLAGS xz
conda install $INSTALL_FLAGS expat
conda install $INSTALL_FLAGS pacparser
conda install $INSTALL_FLAGS xerces-c
conda install $INSTALL_FLAGS boost
conda install $INSTALL_FLAGS frontier_client
conda install $INSTALL_FLAGS oraclesdk
conda install $INSTALL_FLAGS oracleclientlite
conda install $INSTALL_FLAGS sqlplus
conda install $INSTALL_FLAGS coral
conda install $INSTALL_FLAGS root
conda list
conda clean --yes -i -t

