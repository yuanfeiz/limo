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
    
//    deviceAddress[0] = (uint8_t)0xec;
//    deviceAddress[1] = (uint8_t)0x55;
//    deviceAddress[2] = (uint8_t)0xf9;
//    deviceAddress[3] = (uint8_t)0xd5;
//    deviceAddress[4] = (uint8_t)0x8b;
//    deviceAddress[5] = (uint8_t)0x5d;
    
    deviceAddress[0] = (uint8_t)0x00;
    deviceAddress[1] = (uint8_t)0x10;
    deviceAddress[2] = (uint8_t)0x04;
    deviceAddress[3] = (uint8_t)0x08;
    deviceAddress[4] = (uint8_t)0x00;
    deviceAddress[5] = (uint8_t)0x10;
    
//    deviceAddress[0] = (uint8_t)0x00;
//    deviceAddress[1] = (uint8_t)0x00;
//    deviceAddress[2] = (uint8_t)0x00;
//    deviceAddress[3] = (uint8_t)0x00;
//    deviceAddress[4] = (uint8_t)0x00;
//    deviceAddress[5] = (uint8_t)0x11;
    
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

    [self checkStatus];
}

- (void)btDeviceDisconnected {
    NSLog(@"btDeviceDisconnected");
}

- (void)btReceivedD1:(uint8_t)d1 andD2:(uint8_t)d2 fromSensor:(int)sn {
    
}

- (void)checkStatus {
    uint8_t command[1];
    
    command[0] = 02;
//    command[1] = 'T';
    
    [manager sendRFCOMMPacket:command withLength:1];
    NSLog(@"RUN!!");
}

@end
