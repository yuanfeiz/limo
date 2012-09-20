//
//  Limo.h
//  Limo
//
//  Created by 元飞 朱 on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTstackManager.h"

@interface Limo : NSObject<BTstackManagerDelegate> {
    
    BTstackManager *manager;
    
    bd_addr_t deviceAddress;
    
}

- (void)connect;

@end
