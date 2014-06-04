#!/bin/bash

LUMICONDA_RECEIPE="https://github.com/xiezhen/lumiconda-receipes.git"
LUMICONDA_RECEIPE_TAG="v0.6"
git clone ${LUMICONDA_RECEIPE}
git checkout $LUMICONDA_RECEIPE_TAG
cd "lumiconda-receipes"

PKG_LIST=('xz' 'expat' 'libstdcplus' 'pacparser' 'xerces-c' 'boost' 'frontier_client' 'oraclesdk' 'oracleclientlite' 'sqlplus' 'coral')
for pkgname in "${PKG_LIST[@]}"
do
    conda build $pkgname
done
conda list
conda clean --yes -t

