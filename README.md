Build Standalone Installer
===
tag=v0.0.1
cd $workdir
wget https://github.com/xiezhen/pkgtools/archive/.zip 
upzip master
cd pkgtools-master
./buildinstaller.sh
lumiconda.run -p <install_prefix>

Build Installer in rpm
==

