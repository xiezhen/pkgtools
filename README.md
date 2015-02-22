#### Installation from network
```
download Miniconda
git clone https://github.com/xiezhen/pkgtools.git
cd pkgtools
./bootstrap_brilcondapy27.sh -t ../Miniconda-3.8.3-MacOSX-x86_64.sh -p install/brilconda
```
#### Build Standalone Installer

```
cd pkgtools
./gen_xxx_installer.sh -v $VERSION -p install/brilconda 
```

#### Run Standalone Installer
fetch Brilconda installer Brilconda-xxxx.sh
$path/Brilconda-xxxx.sh -p $install_prefix
