#!/bin/bash

cp -r --preserve=links $SRC_DIR/bin/. $PREFIX/bin
cp -r --preserve=links $SRC_DIR/lib/. $PREFIX/lib 
#cp -r --preserve=links $SRC_DIR/include/. $PREFIX/include/oracle

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
