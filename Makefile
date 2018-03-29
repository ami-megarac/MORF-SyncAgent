## MORF SyncAgent Makefile for installation.

PREFIX ?= /usr/local
INSTALL_MODULE= $(PREFIX)/sync-agent
APP_DIR ?= app
OUTPUT_DIR ?= output

all: clean build

build:
	for f in `find $(APP_DIR) -name "*.lua" -printf "%P\n"` ; do \
		mkdir -p $(OUTPUT_DIR)/`dirname "$$f"`; \
		luajit -b -s $(APP_DIR)/"$$f" $(OUTPUT_DIR)/"$$f"; \
	done

clean:
	rm -rf $(OUTPUT_DIR)

uninstall:
	@echo "==== Uninstalling sync agent. ===="
	rm -rf $(INSTALL_MODULE)
	@echo "==== sync agent uninstalled.===="

install:
	@echo "==== Installing sync agent. ===="
	install -d $(INSTALL_MODULE)
	install -d $(INSTALL_MODULE)/oem
	install -d $(INSTALL_MODULE)/extensions
	install -d $(INSTALL_MODULE)/extensions/ldbus

	cp -R $(OUTPUT_DIR)/* $(INSTALL_MODULE)

	@echo "==== Successfully installed sync agent to $(PREFIX) ===="
