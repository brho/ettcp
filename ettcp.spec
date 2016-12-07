Name: ettcp
Version: 1.0
Release: bpn
Source0: %{name}-%{version}.tar.gz
Summary: A tool for testing TCP connections.
Group: Applications/Internet
License: Public Domain
BuildRoot: %{_tmppath}/%{name}-root

%description
ettcp is an updated version of ttcp. It supports the suck and blow xinetd severs.
suck and blow and the associated xinetd.d files are included in the package.
ttcp is a tool for testing the throughput of TCP connections.  Unlike other
tools which might be used for this purpose (such as FTP clients), ttcp does
not read or write data from or to a disk while operating, which helps ensure
more accurate results.

%prep
rm -rf $RPM_BUILD_ROOT
%setup -c
%build
cd %{name}-%{version}; make
%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -fr $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/local/man/man1
mkdir -p $RPM_BUILD_ROOT/usr/local/bin
mkdir -p $RPM_BUILD_ROOT/etc/xinetd.d	
cd %{name}-%{version}
make RPM_INSTALL_DIR=$RPM_BUILD_ROOT/usr/local/bin RPM_MAN_DIR=$RPM_BUILD_ROOT/usr/local/man RPM_ETC_DIR=$RPM_BUILD_ROOT/etc install
%files
%defattr(-,root,root)
%doc README
/usr/local/bin/*
/usr/local/man/*/*
/etc/xinetd.d/*

%changelog
* Thu Mar 21 2002 David Boreham <dboreham@bozemanpass.com>
- branch from redhat srpm version.

* Tue May 15 2001 Nalin Dahyabhai <nalin@redhat.com>
- fix defattr

* Thu May 10 2001 Nalin Dahyabhai <nalin@redhat.com>
- build initial package
