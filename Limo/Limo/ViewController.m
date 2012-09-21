//
//  ViewController.m
//  Limo
//
//  Created by 元飞 朱 on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Limo.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize limo;
@synthesize btStatusLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.limo = [[Limo alloc] init];
    [self.limo connect];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBTStatusLabel:) name:kLimoConnected object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBTStatusLabel:) name:kLimoDisconnected object:nil];
}

- (void)viewDidUnload
{
    [self setBtStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)sendControlCommand:(UIButton *)button {
    NSLog(@"%d", button.tag);
    switch (button.tag) {
        case kTLimoControlStopMove:
            [self.limo stopMove];
            break;
        case kTLimoControlMoveForward:
            [self.limo moveForward];
            break;
        case kTLimoControlMoveBackward:
            [self.limo moveBackward];
            break;
        case kTLimoControlMoveRight:
            [self.limo moveRight];
            break;
        case kTLimoControlMoveLeft:
            [self.limo moveLeft];
            break;
        default:
            break;
    }
}

- (void)updateBTStatusLabel:(NSNotification *)notifs {
    
    NSString *newStatus = nil;
    
    if (notifs) {
        newStatus = notifs.name;
    }
    
    [self.btStatusLabel setText:newStatus];
}

- (void)dealloc {
    [self.limo release];
    [btStatusLabel release];
    [super dealloc];
}

@end
