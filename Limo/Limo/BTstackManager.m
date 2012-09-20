//
//  BtManager.m
//  NXTRemoteController
//
//  Created by naceka on 23.03.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BTstackManager.h"

static BTstackManager * btstackManager = nil;

static void packet_handler(uint8_t packet_type, uint8_t channel, uint8_t * packet, uint16_t size) {
	[btstackManager handlePacketWithType:packet_type forChannel:channel andData:packet withLen:size];
}

@implementation BTstackManager
@synthesize delegate;

-(BTstackManager *) init {
	self = [super init];		
	
	if(!self) 
		return self;
	
	state = kDeactivated;
	
	run_loop_init(RUN_LOOP_COCOA);
	bt_register_packet_handler(packet_handler);
	
	return self;
}

+(BTstackManager *)sharedInstance {
	NSLog(@"shared instance");
	if (!btstackManager) {
		btstackManager = [[BTstackManager alloc] init];
		NSLog(@"new manager");
	}
	
	NSLog(@"end of si");
	
	return btstackManager;
}

+ (void) killInstance {
	NSLog(@"kill instance");
	if(btstackManager) {
		[btstackManager release];
		btstackManager = nil;
	}
}

-(void) handlePacketWithType:(uint8_t) packet_type forChannel:(uint8_t) channel andData:(uint8_t *)packet withLen:(uint16_t) size {
	bd_addr_t event_addr;
	uint16_t mtu;
	int command_size = 0;
	int command_start = 2;
	
	switch (packet_type) {
			
		case RFCOMM_DATA_PACKET:
			NSLog(@"Received RFCOMM data on channel id %u, size %u\n", channel, size);
			hexdump(packet, size);
			//write infrmation for different situations and say to robot			
			do {
				command_size = packet[0] + 256*packet[1];

				switch (packet[command_start + 1]) {
					case 0x07:
						NSLog(@"GetInputValue - Data from sensor!");
						NSLog(@"Input port:%d data:%d%d", (int)packet[command_start + 3], (int)packet[command_start + 12], (int)packet[command_start + 13]);
						//send message to robot
						[delegate btReceivedD1: packet[command_start + 12] andD2: packet[command_start + 13] fromSensor:(int)packet[command_start + 3]];
						break;
					case 0x05:
						NSLog(@"SetInputValue - Status byte!");
						hexdump(packet, size);
						break;

					default:
						break;
				}
				
				command_start += command_size + 2;
			}
			while (size > command_start);
			break;
			
		case L2CAP_DATA_PACKET:
			NSLog(@"Received L2CAP data on channel id %u, size %u\n", channel, size);
			//hexdump(packet, size);
			break;
			
		case HCI_EVENT_PACKET:
			switch (packet[0]) {
					
				case BTSTACK_EVENT_POWERON_FAILED:
					// handle HCI init failure
					NSLog(@"HCI Init failed - make sure you have turned off Bluetooth in the System Settings\n");
					exit(1);
					break;		
					
				case BTSTACK_EVENT_STATE:
					// bt stack activated, get started
                    if (packet[2] == HCI_STATE_WORKING) {
						NSLog(@"HCI_STATE_WORKING");
						//
						state = kActivated;
						[delegate btActivated];
					}
					if (packet[2] == HCI_STATE_OFF) {
						NSLog(@"HCI_STATE_OFF");
						state = kDeactivated;
						[delegate btDeactivated];
					}
					else {
						NSLog(@"another state");
					}

					break;
					
				case HCI_EVENT_PIN_CODE_REQUEST:
					// inform about pin code request
					NSLog(@"Using PIN 1234\n");
					bt_flip_addr(event_addr, &packet[2]); 
					bt_send_cmd(&hci_pin_code_request_reply, &event_addr, 4, "1234");
					break;
					
				case RFCOMM_EVENT_OPEN_CHANNEL_COMPLETE:
					// data: event(8), len(8), status (8), address (48), handle(16), server channel(8), rfcomm_cid(16), max frame size(16)
					if (packet[2]) {
						NSLog(@"RFCOMM channel open failed, status %u\n", packet[2]);
					} else {
						connId = READ_BT_16(packet, 12);
						mtu = READ_BT_16(packet, 14);
						NSLog(@"RFCOMM channel open succeeded. New RFCOMM Channel ID %u, max frame size %u\n", connId, mtu);
						[delegate btDeviceConnected];
					}
					break;
					
				case HCI_EVENT_DISCONNECTION_COMPLETE:
					// connection closed -> quit test app
					NSLog(@"Basebank connection closed\n");
					[delegate btDeviceDisconnected];
					break;
					
				default:
					
					break;
			}
			break;
		default:
			NSLog(@"packet type %d", packet_type);
			break;
	}	
}

// activating
-(void) activate {
	if(bt_open()){
		NSLog(@"bt_open failed ");
		return;
	}
	
	//check system BT
	state = kW4SysBTState;
	
	bt_send_cmd(&btstack_set_power_mode, HCI_POWER_ON);
}

// deactivating
-(void) deactivate {
	state = kDeactivated;
	bt_send_cmd(&btstack_set_power_mode, HCI_POWER_OFF);
}

-(bool) activated {
	return state == kActivated;
}

//create connection
-(int) createRFCOMMConnectionAtAddress:(bd_addr_t*) address withChannel:(uint16_t)channel authenticated:(BOOL)authentication{
	// store params
	BD_ADDR_COPY(&connAddr, address);
	connChan = channel;
	connAuth = authentication;
	
	bt_send_cmd(&rfcomm_create_channel, connAddr, connChan);
	return 0;
}

- (int) closeRFCOMMConnection {
	NSLog(@"disconnect connid : %d", (uint8_t)connId);
	bt_send_cmd(&rfcomm_disconnect, (uint8_t)connId, 0);
	[delegate btDeviceDisconnected];
	return 0;
}
	
-(void) sendRFCOMMPacket:(uint8_t *)packet withLength:(uint8_t) len {
	if ([self activated]) {
		bt_send_rfcomm(connId, packet, len);
	}
}

-(void) setDelegate:(id <BTstackManagerDelegate>) d {
	delegate = d;
}

@end
