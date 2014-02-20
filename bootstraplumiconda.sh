#!/bin/bash

WORKDIR=`pwd`
if [ -n "$1" ]; then
   WORKDIR=$1
fi

LUMICONDA_ROOT="${WORKDIR}/lumiconda"
MINICONDA_SRC="Miniconda-3.0.5-Linux-x86_64.sh"
MINICONDA="repo.continuum.io/miniconda/"${MINICONDA_SRC}

cd $WORKDIR
wget ${MINICONDA}

rm -rf ${LUMICONDA_ROOT}
bash ${MINICONDA_SRC} -b -p ${LUMICONDA_ROOT}
source ${LUMICONDA_ROOT}/bin/activate ${LUMICONDA_ROOT}
conda list
rm ${WORKDIR}/${MINICONDA_SRC}
