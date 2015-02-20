#!/bin/bash

#
# Build a standalone installer from a installed area
#

echo "$0" | grep '\.sh$' >/dev/null
if (( $? )); then
    echo 'Please run using "bash" or "sh", but not "." or "source"' >&2
    return 1
fi

CONDAREPO_BASE="http://repo.continuum.io/pkgs/free"
OS=`uname`
PATFORM=`uname -m`
THIS_DIR=$(pwd)
PKGDIR=""
PREFIX=""
VERSION=""

if [ ${OS}="Linux" ]; then
    PKGDIR="linux-64"
else
    PKGDIR="osx-64" 
fi
CONDAREPO="${CONDAREPO_BASE}/${PKGDIR}"
echo $CONDAREPO

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

pkgfiles=( $(find ${PREFIX}/pkgs -name "*.tar.bz2" -type f) )
echo $( printf "%s " ${pkgfiles[@]} )
rm -f tmps.tar
rm -rf tmps
mkdir -p tmps

filenames=()
filenamesStr=""
cd tmps
for p in "${pkgfiles[@]}"; do
    echo $p 
    #echo "/usr/bin/curl -O $CONDAREPO/$p"
    #/usr/bin/curl -O "$CONDAREPO/$p"
    cp ${p} .
    xbase=${p##*/}
    xfilename=${xbase%.*}
    xfilename=${xfilename%.*}
    filenames+=${xfilename}
done
filenamesStr=$( printf "%s " ${filenames[@]} )

echo $filenamesStr

installername="Brilconda-${VERSION}-${OS}-${PATFORM}.sh"
cd ..
tar -cvf tmps.tar tmps

#cat brilcondaheader.sh pkgs.tar.gz > $installername
cat brilcondaheader.sh tmps.tar | sed "s/__filenames_anchor__/filenamesStr=\"${filenamesStr}\"\\nfilenames=(\$filenamesStr)/" | sed "s/__version_anchor__/$VERSION/g" > $installername
chmod a+x ${installername}
echo "${installername} created" 

exit 0
