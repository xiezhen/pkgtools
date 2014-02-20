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

LUMICONDA_RECEIPE="https://github.com/xiezhen/lumiconda-receipes.git"
LUMICONDA_RECEIPE_TAG="v0.0.1"
git clone ${LUMICONDA_RECEIPE}
git checkout $LUMICONDA_RECEIPE_TAG
cd "lumiconda-receipes"

conda install $INSTALL_FLAGS conda-build=1.2.0
conda install $INSTALL_FLAGS pandas=0.13.1
conda install $INSTALL_FLAGS matplotlib=1.3.1
conda install $INSTALL_FLAGS h5py=2.2.1
conda install $INSTALL_FLAGS pcre=8.31
conda install $INSTALL_FLAGS libtiff=4.0.2
conda install $INSTALL_FLAGS jpeg=8d
conda install $INSTALL_FLAGS libxml2=2.9.0
conda install $INSTALL_FLAGS llvm=3.3

conda build xz
conda build expat
conda build pacparser
conda build xerces-c
conda build boost
conda build frontier_client
conda build oraclesdk
conda build oracleclientlite
conda build sqlplus
conda build coral
conda build root
conda list
conda clean -t

