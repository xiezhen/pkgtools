#
# rpm spec wrap for brilconda installer
#
Summary: bril anaconda environment
Name:  Brilconda
Version: %{version}
Release: 1
Source: http://cms-service-lumi.web.cern.ch/cms-service-lumi/installers/linux-64/Brilconda-%{version}-Linux-x86_64.sh
License: MIT

%define _prefix /opt
Prefix: %{_prefix}

%define _unpackaged_files_terminate_build 0
%define _missing_doc_files_terminate_build 0

%description
anaconda virtual environment for BRIL

%install
mkdir -p $RPM_BUILD_ROOT/%{_prefix}
cp %{_sourcedir}/%{installer} $RPM_BUILD_ROOT/%{_prefix}/%{installer}

%files
%defattr(-,root,root,-)
%{_prefix}/%{installer}

%post
rm -rf $RPM_INSTALL_PREFIX/brilconda
bash $RPM_INSTALL_PREFIX/%{installer} -p  $RPM_INSTALL_PREFIX//brilconda
rm -f $RPM_INSTALL_PREFIX/%{installer}

%postun
rm -rf $RPM_INSTALL_PREFIX/brilconda

%doc

%changelog
* Mon Nov 21 2016 Zhen Xie <Zhen.Xie@cern.ch>
- Initial build
