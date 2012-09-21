//
//  Limo.h
//  Limo
//
//  Created by 元飞 朱 on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTstackManager.h"

static NSString *kLimoConnected = @"kLimoConnected";
static NSString *kLimoDisconnected = @"kLimoDisconnected";

@interface Limo : NSObject<BTstackManagerDelegate> {
    
    BTstackManager *manager;
    
    bd_addr_t deviceAddress;
    
}

- (void)connect;


- (void)stopMove;
- (void)moveForward;
- (void)moveBackward;
- (void)moveRight;
- (void)moveLeft;

@end
