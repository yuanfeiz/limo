//
//  Limo.m
//  Limo
//
//  Created by 元飞 朱 on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Limo.h"

@implementation Limo

- (Limo *)init {
    self = [super init];
    
    manager = [BTstackManager sharedInstance];
    [manager setDelegate:self];
    
    deviceAddress[0] = (uint8_t)0x00;
    deviceAddress[1] = (uint8_t)0x10;
    deviceAddress[2] = (uint8_t)0x04;
    deviceAddress[3] = (uint8_t)0x08;
    deviceAddress[4] = (uint8_t)0x00;
    deviceAddress[5] = (uint8_t)0x27;
    
    return self;
}

- (void)connect {
    NSLog(@"connect!");
    
    if (![manager activated]) {
        [manager activate];
        NSLog(@"manager activated");
    }
    
    [manager createRFCOMMConnectionAtAddress:&deviceAddress withChannel:1 authenticated:YES];
    NSLog(@"manager activated - new connection");
}

- (void)btActivated {
    NSLog(@"BT activated!");
}

- (void)btActivationFailed {
    
}

- (void)btDeactivated {
    
}

- (void)btDeviceConnected {
    NSLog(@"BT deviceConnected");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLimoConnected object:self];
}

- (void)btDeviceDisconnected {
    NSLog(@"btDeviceDisconnected");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLimoDisconnected object:self];
}

- (void)btReceivedD1:(uint8_t)d1 andD2:(uint8_t)d2 fromSensor:(int)sn {
    
}

- (void)resetDirection {
    uint8_t command[1];
    
    command[0] = 05;
    
    [manager sendRFCOMMPacket:command withLength:1];
}

- (void)moveForward {
    uint8_t command[1];
    
    command[0] = 01;
    
    [manager sendRFCOMMPacket:command withLength:1];
}

- (void)moveBackward {
    uint8_t command[1];
    
    command[0] = 02;
    
    [manager sendRFCOMMPacket:command withLength:1];
}

- (void)moveRight {
    uint8_t command[1];
    
    command[0] = 04;
    
    [manager sendRFCOMMPacket:command withLength:1];
}

- (void)moveLeft {
    uint8_t command[1];
    
    command[0] = 03;
    
    [manager sendRFCOMMPacket:command withLength:1];
}

- (void)stopMove {
    uint8_t command[1];
    
    command[0] = 00;
    
    [manager sendRFCOMMPacket:command withLength:1];
}

- (void)dealloc {
    [manager closeRFCOMMConnection];
    [manager deactivate];
    
    [super dealloc];
}



@end
