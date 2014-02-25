Build Standalone Installer
====

cd $workdir

wget https://github.com/xiezhen/pkgtools/archive/<tag>.tar.gz

tar zxvf <tag>

cd pkgtools-<tag>

./buildinstaller.sh

Build Installer in rpm
====



Run Standalone Installer
====
./lumiconda.run -p <install_prefix>
