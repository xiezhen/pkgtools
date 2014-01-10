#!/bin/bash
mkdir -p  $PREFIX/bin
mkdir -p  $PREFIX/lib
cp $SRC_DIR/bin/sqlplus $PREFIX/bin
find  $SRC_DIR/lib/ -name "libclntsh.so*" -print | while read filename
do
  cp -P --preserve=links "${filename}" $PREFIX/lib 
done
cp -P $SRC_DIR/lib/libsqlplus.so $PREFIX/lib
cp -P $SRC_DIR/lib/libnnz11.so $PREFIX/lib

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
