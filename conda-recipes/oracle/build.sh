#!/bin/bash

cp --preserve=links $SRC_DIR/bin/sqlplus $PREFIX/bin
find  $SRC_DIR/lib/ -name "libclntsh.so*" -print | while read filename
do
  cp --preserve=links "${filename}" $PREFIX/lib 
done
cp --preserve=links $SRC_DIR/lib/libsqlplus.so $PREFIX/lib
cp --preserve=links $SRC_DIR/lib/libnnz11.so $PREFIX/lib

#cp -r --preserve=links $SRC_DIR/include/. $PREFIX/include/oracle

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
