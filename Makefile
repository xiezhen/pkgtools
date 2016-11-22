WORK_DIR=$(shell pwd)
BUILD_HOME=$(WORK_DIR)/..
PACKAGE_VERSION=1.1.7
INSTALLER=Brilconda-${PACKAGE_VERSION}-Linux-x86_64.sh
DOWNLOAD_URL=http://cms-service-lumi.web.cern.ch/cms-service-lumi/installers/linux-64
SOURCE_DIR=$(BUILD_HOME)/rpm/SOURCES
RPMBUILD_DIR=$(BUILD_HOME)/rpm

.PHONY: all _all clean _cleanall
default: all

all: _all
_all:
	if [ ! -f ${SOURCE_DIR}/${INSTALLER} ]; then\
		wget ${DOWNLOAD_URL}/${INSTALLER} -P ${SOURCE_DIR}; \
	fi;
	rpmbuild -bb -vv  \
	--define "_topdir ${RPMBUILD_DIR}" \
	--define "installer ${INSTALLER}" \
	--define "version ${PACKAGE_VERSION}" \
	brilconda.spec

clean: _cleanall
_cleanall:
	rm -rf ${RPMBUILD_DIR}
