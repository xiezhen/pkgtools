#### Download miniconda
```
    http://repo.continuum.io/miniconda/
```

#### Install miniconda and constructor
```
    git clone https://github.com/xiezhen/pkgtools.git
    cd pkgtools
    ~/Download/Miniconda2-xxx.sh -b -f -p ./miniconda
    ./miniconda/bin/conda install constructor -y

```

#### (Optional) check the private packages against the python version in miniconda, rebuild/upload packages if needed
```
    Rebuild package use lumiconda-receipes
```

#### Run constructor against current construct.yaml to build the installer
```
    ./miniconda/bin/constructor .
```

#### Run Standalone Installer
```
    bash Brilcondaxxx.sh -b -f -p /install/prefix
```

#### Remove miniconda
```
    rm -rf ./miniconda
```
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
