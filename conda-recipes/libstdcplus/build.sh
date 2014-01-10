#!/bin/bash
mkdir -p $PREFIX/lib

find  $SRC_DIR/lib64/ -name "libstdc++*" -print | while read filename
do
  cp -P --preserve=links "${filename}" $PREFIX/lib 
done

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
