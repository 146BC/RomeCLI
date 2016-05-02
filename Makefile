PREFIX?=/usr/local
TEMPORARY_FOLDER=/tmp/RomeCLI.dst
BUILD_TOOL=xcodebuild

XCODEFLAGS=DSTROOT=$(TEMPORARY_FOLDER)

ROME_EXECUTABLE=$(TEMPORARY_FOLDER)/Applications/RomeCLI.app/Contents/MacOS/RomeCLI
FRAMEWORKS_BUNDLE=$(TEMPORARY_FOLDER)/Applications/RomeCLI.app/Contents/Frameworks/

BINARIES_FOLDER=$(PREFIX)/bin/romecli
FRAMEWORKS_FOLDER=$(PREFIX)/Frameworks/RomeCLI

clean:
	rm -rf "$(TEMPORARY_FOLDER)"
	$(BUILD_TOOL) $(XCODEFLAGS) clean

install:
	carthage bootstrap --platform OSX
	$(BUILD_TOOL) $(XCODEFLAGS) install
	mkdir -p "$(FRAMEWORKS_FOLDER)"
	cp -R "$(FRAMEWORKS_BUNDLE)" "$(FRAMEWORKS_FOLDER)"
	cp "$(ROME_EXECUTABLE)" "$(BINARIES_FOLDER)"
	install_name_tool -add_rpath "$(FRAMEWORKS_FOLDER)" "$(BINARIES_FOLDER)"

uninstall:
	rm -rf "$(FRAMEWORKS_FOLDER)"
	rm "$(BINARIES_FOLDER)"