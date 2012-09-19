NAME = SpringBoardAccess

CC = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin10-llvm-gcc-4.2
OBJC     = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin10-llvm-g++-4.2
LDFLAGS  =  -framework CoreFoundation -framework Foundation -framework Foundation -framework CoreFoundation -lobjc -L/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/System/Library/Frameworks/IOKit.framework/Versions/A -lIOKit /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk/System/Library/PrivateFrameworks/BluetoothManager.framework/BluetoothManager
CPPFLAGS =  -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.1.sdk -Werror -Wall -Wpointer-arith
prefix = /usr/local

LIB_LDFLAGS = -lobjc \
              -multiply_defined suppress \
			  -framework CoreFoundation \
			  -framework Foundation \
			  -framework UIKit \
			  -L../3rdparty -lsubstrate

APP_LDFLAGS = -framework CoreFoundation

all: $(NAME).dylib $(NAME)-test

clean:
	rm -f $(NAME).dylib $(NAME)-test
	
$(NAME).dylib: $(NAME)Extension.mm
	$(OBJC) $(CPPFLAGS) -dynamiclib -o $@ $(NAME)Extension.mm -init _$(NAME)Initialize $(LDFLAGS) $(LIB_LDFLAGS)
	# export CODESIGN_ALLOCATE=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate ; ldid -S $@

$(NAME)-test: $(NAME)-test.c $(NAME).c
	$(OBJC) $(CPPFLAGS) -o $@  $(NAME).c $(NAME)-test.c $(LDFLAGS) $(APP_LDFLAGS)
	# export CODESIGN_ALLOCATE=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/codesign_allocate ; ldid -S $@

install:
	echo "SpringBoardAccess is not installed. Use .deb package"
