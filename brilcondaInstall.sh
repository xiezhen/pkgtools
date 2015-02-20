#!/bin/bash

#
#Install packages of specific version selected by bril via network
#The installation directory will be created each time
#

echo "$0" | grep '\.sh$' >/dev/null
if (( $? )); then
    echo 'Please run using "bash" or "sh", but not "." or "source"' >&2
    return 1
fi

THIS_DIR=$(pwd)
INSTALLER=
PREFIX=$HOME/brilconda

#Parse command line flags
#If an option should be followed by an argument, it should be followed by a ":".
#Notice there is no ":" after "h". The leading ":" suppresses error messages from getopts. 
while getopts ":t:p:h" x; do
    case "$x" in
	h)
	    echo "usage: $0 [options]
Install brilconda via network
    -h               print this help message and exit
    -t INSTALLER     conda installer 
    -p PREFIX        install prefix, defaults to $PREFIX
"
	    exit 2
	    ;;
	t)
	    INSTALLER="$OPTARG"
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
echo $INSTALLER
if [ -z "$INSTALLER" ]; then
    echo "-t INSTALLER is required" >&2
    exit 1
fi
   
declare -A driverpkgs
driverpkgs["cx_oracle"]="5.1.2"
driverpkgs["ipython-notebook"]="2.4.1"
driverpkgs["pandas"]="0.15.2"
driverpkgs["pytables"]="3.1.1"
driverpkgs["matplotlib"]="1.3.0"

echo "Installing $INSTALLER in $PREFIX"

rm -rf $PREFIX
mkdir -p $PREFIX

bash $INSTALLER -bf -p $PREFIX

cd $PREFIX
for pkg in "${!driverpkgs[@]}"
do
    echo "Installing $pkg ${driverpkgs[$pkg]} in $PREFIX"
    ./bin/conda install -ymq "$pkg"="${driverpkgs[$pkg]}" -p ${PREFIX}
done
tot=`du -ch|grep total`
echo "Total space used $tot"
cd $THIS_DIR
exit 0
