#!/bin/bash
echo ""
echo "Lumiconda Installer. Customized Miniconda"
echo ""

#export TMPDIR=`mktemp -d /tmp/selfextract.XXXXXX`
ARCHIVE=`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' $0`

unset LD_LIBRARY_PATH
echo "$0" | grep '\.sh$' >/dev/null
echo "$0"
if (( $? )); then
    echo 'Please run using "bash" or "sh", but not "." or "source"' >&2
    return 1
fi

THIS_DIR=$(cd $(dirname $0); pwd)
THIS_FILE=$(basename $0)
THIS_PATH="$THIS_DIR/$THIS_FILE"
PREFIX=$HOME/lumiconda

while getopts "hp:" x; do
    case "$x" in
       h) 
          echo "usage: $0 [options]
Installs Lumiconda2 0.0.1
    -h           run install in batch mode (without manual intervention),
                 it is expected the license terms are agreed upon
    -p PREFIX    install prefix, defaults to $PREFIX
"
            exit 2
            ;;
       p)
            PREFIX="$OPTARG"
            ;;
       ?)  
             echo "Error: did not recognize option, please try -h"
            exit 1
            ;;
    esac
done

if [[ `uname -m` != 'x86_64' ]]; then
    echo -n "WARNING:
    Your operating system appears not to be 64-bit, but you are trying to
    install a 64-bit version of Miniconda.
    Are sure you want to continue the installation? [yes|no]
[no] >>> "
    read ans
    if [[ ($ans != "yes") && ($ans != "Yes") && ($ans != "YES") &&
                ($ans != "y") && ($ans != "Y") ]]
    then
        echo "Aborting installation"
        exit 2
    fi
fi

case "$PREFIX" in
    *\ * )
        echo "ERROR: Cannot install into directories with spaces" >&2
        exit 1
        ;;
esac

if [ -e $PREFIX ]; then
    echo "ERROR: File or directory already exists: $PREFIX" >&2
    exit 1
fi

mkdir -p $PREFIX
if (( $? )); then
    echo "ERROR: Could not create directory: $PREFIX" >&2
    exit 1
fi

PREFIX=$(cd $PREFIX; pwd)
export PREFIX

echo "PREFIX=$PREFIX"

cd $PREFIX
echo $THIS_PATH
tail -n+$ARCHIVE $THIS_PATH | tar xf -
if (( $? )); then
    echo "ERROR: could not extract tar starting at line 321" >&2
    exit 1
fi

extract_dist()
{
    echo "installing: $1 ..."
    DIST=$PREFIX/pkgs/$1
    mkdir -p $DIST
    tar xjf ${DIST}.tar.bz2 -C $DIST || exit 1
    rm -f ${DIST}.tar.bz2
}

__filenames_anchor__
for filename in  "${filenames[@]}"
do
    extract_dist ${filename}
done

mkdir $PREFIX/envs

PYTHON="$PREFIX/pkgs/python-2.7.6-1/bin/python -E"
$PYTHON -V
if (( $? )); then
    echo "ERROR:
cannot execute native linux-64 binary, output from 'uname -a' is:" >&2
    uname -a
    exit 1
fi

echo "creating default lumi environment..."
CONDA_INSTALL="$PREFIX/pkgs/conda-3.0.0-py27_0/lib/python2.7/site-packages/conda/install.py"
$PYTHON $CONDA_INSTALL --prefix=$PREFIX --pkgs-dir=$PREFIX/pkgs --link-all || exit 1
echo "installation finished."

if [[ $PYTHONPATH != "" ]]; then
    echo "WARNING:
    You current have a PYTHONPATH environment variable set. This may cause
    unexpected behavior when running the Python interpreter in Miniconda.
    For best results, please verify that your PYTHONPATH only points to
    directories of packages that are compatible with the Python interpreter
    in Miniconda: $PREFIX"
fi

exit 0

__ARCHIVE_BELOW__
