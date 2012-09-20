//
//  BtManager.h
//  NXTRemoteController
//
//  Created by naceka on 23.03.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <btstack/btstack.h>
#import <btstack/sdp_util.h>

//all bt events here
@protocol BTstackManagerDelegate
@optional
- (void) btActivated;
- (void) btActivationFailed;
- (void) btDeactivated;
- (void) btDeviceConnected;
- (void) btDeviceDisconnected;
- (void) btReceivedD1:(uint8_t) d1 andD2: (uint8_t) d2 fromSensor:(int) sn;
@end

typedef enum {
	kDeactivated = 1,
	kW4SysBTState,
	kW4SysBTDisabled,
	kW4Activated,
	kActivated,
	kW4Deactivated,
	kSleeping,
	kW4DisoveryStopped,
	kW4AuthenticationEnableCommand
} ManagerState;

@interface BTstackManager : NSObject {
	id <BTstackManagerDelegate> delegate;
	ManagerState state;
	
	bd_addr_t connAddr;
	uint16_t  connPSM;
	uint16_t  connChan;
	uint8_t   connAuth;
	uint16_t  connId;
	
}

@property(retain, nonatomic) id<BTstackManagerDelegate> delegate;

- (BTstackManager *) init;
+ (BTstackManager *) sharedInstance;
- (void) handlePacketWithType:(uint8_t) packet_type forChannel:(uint8_t) channel andData:(uint8_t *)packet withLen:(uint16_t) size;
- (void) activate;
- (void) deactivate;
- (bool) activated;
- (int) createRFCOMMConnectionAtAddress:(bd_addr_t*) address withChannel:(uint16_t)channel authenticated:(BOOL)authentication;
- (int) closeRFCOMMConnection;
- (void) sendRFCOMMPacket:(uint8_t *)packet withLength:(uint8_t) len;
- (void) setDelegate:(id <BTstackManagerDelegate>) d;
@end