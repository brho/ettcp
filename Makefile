
MODULENAME=ettcp
MAJORVERSION=1
MINORVERSION=0
TARDIR=$(MODULENAME)-$(MAJORVERSION).$(MINORVERSION)
TARFILE=$(TARDIR).tar.gz
MACHINE=i686
RPMSTAGE=rpm/SOURCES/$(TARFILE)
RPMDIRS=rpmdir

ifndef RPM_INSTALL_DIR
RPM_INSTALL_DIR = /usr/local/bin
endif

ifndef RPM_MAN_DIR
RPM_MAN_DIR = /usr/share/man
endif

ifndef RPM_ETC_DIR
RPM_ETC_DIR = /etc
endif

all: suck blow ettcp

suck: suck.c
	gcc -o suck suck.c
ettcp: ettcp.c
	gcc -o ettcp ettcp.c
blow: blow.c
	gcc -o blow blow.c

install: all
	install -m755 ettcp $(RPM_INSTALL_DIR)
	install -m755 speedfrom $(RPM_INSTALL_DIR)
	install -m755 speedto $(RPM_INSTALL_DIR)
	install -m755 suck $(RPM_INSTALL_DIR)
	install -m755 blow $(RPM_INSTALL_DIR)
	install -m644 blow.1 $(RPM_MAN_DIR)/man1
	install -m644 suck.1 $(RPM_MAN_DIR)/man1
	install -m644 speedfrom.1 $(RPM_MAN_DIR)/man1
	install -m644 speedto.1 $(RPM_MAN_DIR)/man1
	install -m644 ettcp.1 $(RPM_MAN_DIR)/man1
	install -m644 xinetd.d/suck $(RPM_ETC_DIR)/xinetd.d
	install -m644 xinetd.d/blow $(RPM_ETC_DIR)/xinetd.d

clean:
	rm -f ettcp suck blow $(TARFILE)
	rm -rf $(RPMDIRS) $(TARDIR)
	rm -f *~
	
tarfile: $(TARFILE)

$(TARFILE):	ettcp.c suck.c blow.c xinetd.d speedfrom speedto *.1 README TODO Makefile ettcp.spec
	rm -rf $@ $(TARDIR)
	mkdir $(TARDIR)
	cp -a $^ $(TARDIR)
	tar zcvf $@ $(TARDIR)
	
rpm:	$(RPMSTAGE)
	rpm --define "_topdir $(CURDIR)/$(RPMDIRS)" -ba ettcp.spec

$(RPMSTAGE):	$(RPMDIRS) $(TARFILE)
	cp $(TARFILE) $(RPMDIRS)/SOURCES/$(TARFILE)

$(RPMDIRS):
	mkdir $(RPMDIRS)
	mkdir $(RPMDIRS)/BUILD
	mkdir $(RPMDIRS)/RPMS
	mkdir $(RPMDIRS)/RPMS/$(MACHINE)
	mkdir $(RPMDIRS)/SOURCES
	mkdir $(RPMDIRS)/SPECS
	mkdir $(RPMDIRS)/SRPMS
	
