#!/bin/bash
WORKDIR=`pwd`
CONDADIR=`pwd`
if [ -n "$1" ]; then
   CONDADIR=$1
fi
cd ${CONDADIR}

source ${CONDADIR}/bin/activate ${CONDADIR}

LUMICONDA_RECEIPE="https://github.com/xiezhen/lumiconda-receipes.git"
LUMICONDA_RECEIPE_TAG="v0.0.5"
git clone ${LUMICONDA_RECEIPE}
git checkout $LUMICONDA_RECEIPE_TAG
cd "lumiconda-receipes"

PKG_LIST=('xz' 'expat' 'libstdcplus' 'pacparser' 'xerces-c' 'boost' 'frontier_client' 'oraclesdk' 'oracleclientlite' 'sqlplus' 'coral' 'libx11' 'libxpm' 'libxext' 'libxft' 'root')
for pkgname in "${PKG_LIST[@]}"
do
    conda build $pkgname
done
conda list
conda clean --yes -t

