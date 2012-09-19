CC = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin10-llvm-gcc-4.2
LDFLAGS  =  -framework CoreFoundation -framework Foundation -framework Foundation -framework CoreFoundation -lobjc -L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/System/Library/Frameworks/IOKit.framework/Versions/A -lIOKit /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/System/Library/PrivateFrameworks/BluetoothManager.framework/BluetoothManager
CPPFLAGS =  -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk -Werror -Wall -Wpointer-arith
prefix = /usr/local

all: PatchBlueTool

PatchBlueTool: PatchBlueTool.c
	$(CC) $(CPPFLAGS) -o $@ $< $(LDFLAGS)
	# export CODESIGN_ALLOCATE=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate ; ldid -S $@

clean:
	rm -f PatchBlueTool
	
install:    
	echo "nothing to be done"

