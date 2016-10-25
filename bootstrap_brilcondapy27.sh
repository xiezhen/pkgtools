#!/bin/bash
declare -A driverpkgs
driverpkgs["cx_oracle"]="5.1.2"
driverpkgs["ipython"]="5.1.0"
driverpkgs["pandas"]="0.19.0"
driverpkgs["pytables"]="3.2.3.1"
driverpkgs["h5py"]="2.6.0"
driverpkgs["matplotlib"]="1.5.3"
driverpkgs["scipy"]="0.18.1"
driverpkgs["sqlalchemy"]="1.1.2"
driverpkgs["zeromq"]="4.1.5"
#driverpkgs["libtiff"]="4.0.6"
driverpkgs["docopt"]="0.6.2"
driverpkgs["prettytable"]="0.7.2"
driverpkgs["schema"]="0.3.1"
driverpkgs["frontier_client"]="2.8.19"
driverpkgs["sqlalchemy_frontier"]="0.2"

ARCH="$(uname 2>/dev/null)"
#if [ "$ARCH" == "Linux" ];then  
#    driverpkgs["root"]="5.99.05"
#fi

echo "$0" | grep '\.sh$' >/dev/null
if (( $? )); then
    echo 'Please run using "bash" or "sh", but not "." or "source"' >&2
    return 1
fi

THIS_DIR=$(pwd)
CONDAINSTALLER="Miniconda2-4.1.11-Linux-x86_64.sh"
PREFIX=$HOME/brilconda

#Parse command line flags
#If an option should be followed by an argument, it should be followed by a ":".
#Notice there is no ":" after "h". The leading ":" suppresses error messages from getopts. 
while getopts ":t:p:h" x; do
    case "$x" in
	h)
	    echo "usage: $0 [options]
Bootstrap Miniconda
    -h          print this help message and exit
    -t          Miniconda installer 
    -p PREFIX   install prefix, defaults to $PREFIX
"
	    exit 2
	    ;;
	t)
	    CONDAINSTALLER="$OPTARG"
	    echo "-t = $CONDAINSTALLER"
	    ;;
        p)
	    PREFIX="$OPTARG"
	    echo "-p = $PREFIX"
	    ;;
	\?)
	    echo "Error: did not recognize option, please try -h"
	    exit 1
	    ;;
    esac
done
echo "Installing $CONDAINSTALLER in $PREFIX"

rm -rf $PREFIX
mkdir -p $PREFIX

bash $CONDAINSTALLER -bf -p $PREFIX

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
