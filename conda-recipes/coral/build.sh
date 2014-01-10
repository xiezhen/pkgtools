#!/bin/bash
mkdir -p $PREFIX/lib
cp $SRC_DIR/lib/liblcg_ConnectionService.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_CoralBase.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_CoralCommon.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_CoralKernel.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_EnvironmentAuthenticationService.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_FrontierAccess.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_OracleAccess.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_RelationalAccess.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_RelationalService.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_SQLiteAccess.so $PREFIX/lib
cp $SRC_DIR/lib/liblcg_XMLAuthenticationService.so $PREFIX/lib

mkdir -p $PREFIX/lib/python$PY_VER
cp $SRC_DIR/lib/liblcg_PyCoral.so $PREFIX/lib/python$PY_VER
cp $SRC_DIR/python/coral.py $PREFIX/lib/python$PY_VER

# See
# http://docs.continuum.io/conda/build.html
# for a list of environment variables that are set during the build process.
