#!/bin/bash
mkdir -p $PREFIX/lib
mkdir -p $PREFIX/lib/python$PY_VER
mkdir -p $PREFIX/include/root

cp -r  $SRC_DIR/fonts/. $PREFIX/fonts
cp -r  $SRC_DIR/icons/. $PREFIX/icons
cp -r  $SRC_DIR/include/. $PREFIX/include/root
cp -r  $SRC_DIR/cint/. $PREFIX/cint
cp -r  $SRC_DIR/bin/. $PREFIX/bin

find  $SRC_DIR/lib/ -name "libRFIO*" -print | while read filename
do
    rm "${filename}"
done
find  $SRC_DIR/lib/ -name "libProof*" -print | while read filename
do
    rm "${filename}"
done
find  $SRC_DIR/lib/ -name "libDCache*" -print | while read filename
do
    rm "${filename}"
done

find $SRC_DIR/lib/ -name "*.py*"  -print | while read filename
do
    cp "${filename}" $PREFIX/lib/python$PY_VER/
done

cp $SRC_DIR/lib/libPyROOT.so $PREFIX/lib/python$PY_VER/
rm $SRC_DIR/lib/libPyROOT.so

find $SRC_DIR/lib/ -name "*.so"  -print | while read filename
do
    cp "${filename}" $PREFIX/lib
done
find $SRC_DIR/lib/ -name "*.rootmap"  -print | while read filename
do
    cp "${filename}" $PREFIX/lib
done


# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
