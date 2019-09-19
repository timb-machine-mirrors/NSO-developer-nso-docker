NSO_INSTALL_FILES_DIR?=nso-install-files/
NSO_INSTALL_FILES=$(shell ls $(NSO_INSTALL_FILES_DIR)/*.bin)
NSOS=$(NSO_INSTALL_FILES:nso-install-files/%=%)
NSO_DEV=$(NSOS:%=development/%)
NSO_DEV=
NSO_PROD=$(NSOS:%=production/%)

.PHONY: build $(NSO_DEV) $(NSO_PROD)

# build all (both development and production images)
build: $(NSO_DEV) $(NSO_PROD)

$(NSO_DEV):
	rm -f development/*.bin
	cp $(@:development/%=nso-install-files/%) development/
	$(MAKE) -C development FILE=$(@:development/%=%) build
	rm -f development/*.bin

$(NSO_PROD):
	$(MAKE) -C production FILE=$(@:production/%=%) build