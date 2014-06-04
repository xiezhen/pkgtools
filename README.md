#### Build Standalone Installer

```
cd $workdir

wget https://github.com/xiezhen/pkgtools/archive/$tag.tar.gz

tar zxvf $tag

cd pkgtools-$tag

./gen_xxx_installer.sh
```

#### Build Installer in rpm

```
%prep
wget https://github.com/xiezhen/pkgtools/archive/$tag.tar.gz
tar zxvf $tag

%build
./gen_xxx_installer.sh

%install
$RPM_BUILD_ROOT/xxx.run -p %{_prefix}
```

#### Run Standalone Installer

./xxx.run -p $install_prefix
