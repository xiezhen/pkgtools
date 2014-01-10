#!/bin/bash
mkdir -p $PREFIX/lib/root/lib
mkdir -p $PREFIX/lib/root/lib/fonts
mkdir -p $PREFIX/lib/root/lib/icons
mkdir -p $PREFIX/include/root
mkdir -p $PREFIX/lib/python$PY_VER
mkdir -p $PREFIX/bin

cp -r  $SRC_DIR/fonts/. $PREFIX/lib/root/fonts
cp -r  $SRC_DIR/icons/. $PREFIX/lib/root/icons
cp -r  $SRC_DIR/include/. $PREFIX/include/root

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
    cp "${filename}" $PREFIX/lib/root/lib
done
find $SRC_DIR/lib/ -name "*.rootmap"  -print | while read filename
do
    cp "${filename}" $PREFIX/lib/root/lib
done
cp $SRC_DIR/bin/root $PREFIX/bin/
cp $SRC_DIR/bin/root.exe $PREFIX/bin/
cp $SRC_DIR/bin/roots.exe $PREFIX/bin/
cp $SRC_DIR/bin/rootn.exe $PREFIX/bin/
cp $SRC_DIR/bin/rootcint $PREFIX/bin/
cp $SRC_DIR/bin/hadd $PREFIX/bin/
cp $SRC_DIR/bin/rlibmap $PREFIX/bin/

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
