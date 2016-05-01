TEMPORARY_FOLDER=/tmp/RomeCLI.dst
BUILD_TOOL=xcodebuild

XCODEFLAGS=-scheme 'RomeCLI' DSTROOT=$(TEMPORARY_FOLDER)

ROME_EXECUTABLE=$(TEMPORARY_FOLDER)/Applications/RomeCLI.app/Contents/MacOS/RomeCLI
FRAMEWORKS_BUNDLE=$(TEMPORARY_FOLDER)/Applications/RomeCLI.app/Contents/Frameworks/

BINARIES_FOLDER=/usr/local/bin
FRAMEWORKS_FOLDER=/usr/local/Frameworks

clean:
	rm -rf "$(TEMPORARY_FOLDER)"
	$(BUILD_TOOL) $(XCODEFLAGS) clean

install:
	carthage bootstrap --platform OSX
	$(BUILD_TOOL) $(XCODEFLAGS) install
	mkdir -p "$(FRAMEWORKS_FOLDER)/RomeCLI"
	cp -Rf "$(FRAMEWORKS_BUNDLE)" "$(FRAMEWORKS_FOLDER)/RomeCLI"
	cp "$(ROME_EXECUTABLE)" "$(BINARIES_FOLDER)/romecli"

uninstall:
	rm -rf "$(FRAMEWORKS_FOLDER)/RomeCLI"
	rm "$(BINARIES_FOLDER)/romecli"