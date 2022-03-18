PLATFORM_IOS = iOS Simulator,name=iPhone 11 Pro Max
SCHEME = StargazersKit

default: test

archive-ios: archive-ios-release archive-ios-debug
archive-simulator: archive-simulator-release archive-simulator-debug
archive-all: clean archive-ios archive-simulator

framework: framework-release framework-debug

distribute: archive-all framework zip

test:
	xcodebuild test \
		-scheme $(SCHEME) \
		-destination platform="$(PLATFORM_IOS)"

clean:
	rm -f StargazersKit-*.zip
	rm -rf ./build

archive-ios-release:
	xcodebuild archive \
		-scheme $(SCHEME) \
		-configuration Release \
		-destination 'generic/platform=iOS' \
		-archivePath './build/$(SCHEME)-Release.framework.xcarchive' \
		SKIP_INSTALL=NO \
		BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

archive-simulator-release:
	xcodebuild archive \
		-scheme $(SCHEME) \
		-configuration Release \
		-destination 'generic/platform=iOS Simulator' \
		-archivePath './build/$(SCHEME)-Release.framework-iphonesimulator.xcarchive' \
		SKIP_INSTALL=NO \
		BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
		
archive-ios-debug:
	xcodebuild archive \
		-scheme $(SCHEME) \
		-configuration Debug \
		-destination 'generic/platform=iOS' \
		-archivePath './build/$(SCHEME)-Debug.framework.xcarchive' \
		SKIP_INSTALL=NO \
		BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

archive-simulator-debug:
	xcodebuild archive \
		-scheme $(SCHEME) \
		-configuration Debug \
		-destination 'generic/platform=iOS Simulator' \
		-archivePath './build/$(SCHEME)-Debug.framework-iphonesimulator.xcarchive' \
		SKIP_INSTALL=NO \
		BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

framework-release:
	xcodebuild -create-xcframework \
		-framework './build/$(SCHEME)-Release.framework.xcarchive/Products/Library/Frameworks/$(SCHEME).framework' \
		-framework './build/$(SCHEME)-Release.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/$(SCHEME).framework' \
		-output './build/$(SCHEME)-Release.xcframework'
framework-debug:
	xcodebuild -create-xcframework \
		-framework './build/$(SCHEME)-Debug.framework.xcarchive/Products/Library/Frameworks/$(SCHEME).framework' \
		-framework './build/$(SCHEME)-Debug.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/$(SCHEME).framework' \
		-output './build/$(SCHEME)-Debug.xcframework'

zip:
	zip -qq -r $(SCHEME).xcframework.zip ./build/$(SCHEME)-Relese.xcframework ./build/$(SCHEME)-Debug.xcframework

format:
	swift format \
		--ignore-unparsable-files \
		--in-place \
		--recursive \
		./$(SCHEME) ./StargazersExample ./$(SCHEME)Tests \
		--configuration swift-format.json