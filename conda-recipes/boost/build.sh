#!/bin/bash
mkdir -p $PREFIX/lib
#mkdir -p $PREFIX/bin
#mkdir -p $PREFIX/include/boost

find  $SRC_DIR/lib/ -name "libboost*" -print | while read filename
do
  cp -P --preserve=links "${filename}" $PREFIX/lib 
done
#cp -r $SRC_DIR/include/boost/. $PREFIX/include/boost

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
