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
@synthesize joypadImageView;

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
    [self setJoypadImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)sendControlCommand:(UIButton *)button forEvent:(UIEvent *)event {
    NSLog(@"%d, %@", button.tag, event);
    switch (button.tag) {
        case kTLimoControlMoveForward:
            [self.limo moveForward];
            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_up"]];
            break;
        case kTLimoControlMoveBackward:
            [self.limo moveBackward];
            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_down"]];
            break;
        case kTLimoControlMoveRight:
            [self.limo moveRight];
            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_right"]];
            break;
        case kTLimoControlMoveLeft:
            [self.limo moveLeft];
            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_left"]];
            break;
        default:
            break;
    }
}

- (IBAction)cancelControlCommand:(UIButton *)button forEvent:(UIEvent *)event {
//    switch (button.tag) {
//        case kTLimoControlStopMove:
//            break;        
//        default:
//            break;
//    }
    [self.limo stopMove];
    [self.joypadImageView setImage:[UIImage imageNamed:@"nav_inactive.png"]];
    
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
    [joypadImageView release];
    [super dealloc];
}

@end
