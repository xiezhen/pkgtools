#!/bin/bash
declare -A driverpkgs
driverpkgs["cx_oracle"]="5.1.2"
driverpkgs["ipython-notebook"]="2.4.1"
driverpkgs["pandas"]="0.15.2"
driverpkgs["pytables"]="3.1.1"
driverpkgs["matplotlib"]="1.4.0"
driverpkgs["sqlalchemy"]="0.9.8"

echo "$0" | grep '\.sh$' >/dev/null
if (( $? )); then
    echo 'Please run using "bash" or "sh", but not "." or "source"' >&2
    return 1
fi

THIS_DIR=$(pwd)
CONDAINSTALLER="Miniconda-3.8.3-Linux-x86_64.sh"
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
