#!/bin/bash

#
# Build a standalone installer from a reference area
#

echo "$0" | grep '\.sh$' >/dev/null
if (( $? )); then
    echo 'Please run using "bash" or "sh", but not "." or "source"' >&2
    return 1
fi

#CONDAREPO_BASE="http://repo.continuum.io/pkgs/free"
OS=`uname`
PATFORM=`uname -m`
THIS_DIR=$(pwd)
#PKGDIR=""
PREFIX=""
VERSION="1.0.0"

if [ ${OS}="Linux" ]; then
    PKGDIR="linux-64"
else
    PKGDIR="osx-64" 
fi
#CONDAREPO="${CONDAREPO_BASE}/${PKGDIR}"
#echo $CONDAREPO

while getopts ":v:p:h" x; do
    case "$x" in
	h)
	    echo "usage: $0 [options]
Build Brilconda installer
    -h               print this help message and exit
    -v VERSION       version of the installer
    -p PREFIX        install prefix, defaults to $PREFIX
"
	    exit 2
	    ;;
	v)
	    VERSION="$OPTARG"
	    ;;
        p)
	    PREFIX="$OPTARG"
	    ;;
	\?)
	    echo "Error: did not recognize option, please try -h"
	    exit 1
	    ;;
    esac
done

shift $(($OPTIND - 1))

if [ -z "$PREFIX" ]; then
    echo "-p PREFIX is required" >&2
    exit 1
fi

pkgdirs=( $(find ${PREFIX}/pkgs -mindepth 1 -maxdepth 1 -name "*-*" -type d) )
echo $( printf "%s " ${pkgdirs[@]} )
rm -f pkgs.tar
rm -rf pkgs
mkdir -p pkgs

declare -a filenames=()
filenamesStr=""
cd pkgs
python_pkg=""
conda_pkg=""
for p in "${pkgdirs[@]}"; do
    cp -rf ${p} .
    xbase=${p##*/}
    if [[ ${xbase} == python-* ]]; then
	python_pkg="${xbase}"
    fi
    if [[ ${xbase} == conda-[[:digit:]]* ]]; then
	if [ -f "${p}.tar.bz2" ];then
	    conda_pkg=${xbase}
	fi       
    fi
    xfilename=${xbase}.tar.bz2
    tar -cjf ${xfilename} -C . ${xbase}
    #xfilename=${xbase%.*}
    #xfilename=${xfilename%.*}
    filenames+=(${xbase})
    rm -rf ${xbase}
done
echo "python_pkg={python_pkg}"
echo "conda_pkg=${conda_pkg}"
echo $filenames
filenamesStr="${filenames[@]}"

echo $filenamesStr
installername="Brilconda-${VERSION}-${OS}-${PATFORM}.sh"
cd ${THIS_DIR}
tar cvf pkgs.tar pkgs 

cat brilcondaheaderpy27.sh pkgs.tar | LC_ALL=C sed "s/__filenames_anchor__/filenamesStr=\"${filenamesStr}\"/g" | LC_ALL=C sed "s/__version_anchor__/${VERSION}/g" | LC_ALL=C sed "s/__python_pkg_anchor__/${python_pkg}/g" | LC_ALL=C sed "s/__conda_pkg_anchor__/${conda_pkg}/g" > $installername
chmod a+x ${installername}
echo "${installername} created" 

exit 0
