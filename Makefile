TEMPORARY_FOLDER=/tmp/RomeCLI.dst
BUILD_TOOL=xcodebuild

XCODEFLAGS=DSTROOT=$(TEMPORARY_FOLDER)

ROME_EXECUTABLE=$(TEMPORARY_FOLDER)/Applications/RomeCLI.app/Contents/MacOS/RomeCLI
FRAMEWORKS_BUNDLE=$(TEMPORARY_FOLDER)/Applications/RomeCLI.app/Contents/Frameworks/

BINARIES_FOLDER=/usr/local/bin/romecli
FRAMEWORKS_FOLDER=/usr/local/Frameworks/RomeCLI

clean:
	rm -rf "$(TEMPORARY_FOLDER)"
	$(BUILD_TOOL) $(XCODEFLAGS) clean

install:
	-rm -rf "$(FRAMEWORKS_FOLDER)"
	-rm "$(BINARIES_FOLDER)"
	carthage bootstrap --platform OSX
	$(BUILD_TOOL) $(XCODEFLAGS) install
	mkdir -p "$(FRAMEWORKS_FOLDER)"
	cp -R "$(FRAMEWORKS_BUNDLE)" "$(FRAMEWORKS_FOLDER)"
	cp "$(ROME_EXECUTABLE)" "$(BINARIES_FOLDER)"

uninstall:
	rm -rf "$(FRAMEWORKS_FOLDER)"
	rm "$(BINARIES_FOLDER)"