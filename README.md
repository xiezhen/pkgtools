#### Installation from network
```
download Miniconda from from http://repo.continuum.io/miniconda/
git clone https://github.com/xiezhen/pkgtools.git
cd pkgtools
modify bootstrap_brilcondapy27.sh driverpkgs, CONDAINSTALLER,
./bootstrap_brilcondapy27.sh -t ../Miniconda-3.8.3-MacOSX-x86_64.sh -p install/brilconda
```
#### Build Standalone Installer

```
cd pkgtools
modify gen_brilcondainstallerpy27.sh edit python_pkg, conda_pkg
./gen_brilcondainstallerpy27.sh -v $VERSION -p install/brilconda 
```

#### Run Standalone Installer
fetch Brilconda installer Brilconda-xxxx.sh
$path/Brilconda-xxxx.sh -p $install_prefix

#### How to upgrade Bash in Mac OSX
bootstrap script requires bash v4x
```
brew install bash
sudo bash -c $(brew --prefix)/bin.basg >> /private/etc/shells"
if needed: system preferences -> Users & Groups (unlock pref pane) -> right
click on your account Advanced Options... and change Login shee option to
/usr/local/bin/bash
Robbot computer
if needed: sudo rm /bin/bash; ln -s /usr/local/bin/bash /bin/bash
```
