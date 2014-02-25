#### Build Standalone Installer

cd $workdir

wget https://github.com/xiezhen/pkgtools/archive/$tag.tar.gz

tar zxvf $tag

cd pkgtools-$tag

./buildinstaller.sh

#### Build Installer in rpm

%prep
wget https://github.com/xiezhen/pkgtools/archive/$tag.tar.gz

tar zxvf $tag

%build
./buildinstaller.sh

%install
$RPM_BUILD_ROOT/lumiconda.run -p %{_prefix}

#### Run Standalone Installer

./lumiconda.run -p $install_prefix
