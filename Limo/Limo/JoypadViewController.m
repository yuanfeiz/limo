//
//  ViewController.m
//  Limo
//
//  Created by 元飞 朱 on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JoypadViewController.h"
#import "AppDelegate.h"
#import "Limo.h"

@interface JoypadViewController ()

@end

@implementation JoypadViewController

@synthesize btStatusLabel;
@synthesize joypadImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    limo = appDelegate.limo;
    
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
    switch (button.tag) {
        case kTLimoControlMoveForward:
            [limo moveForward];
            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_up"]];
            break;
        case kTLimoControlMoveBackward:
            [limo moveBackward];
            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_down"]];
            break;
        case kTLimoControlMoveRight:
            [limo moveRight];
            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_right"]];
            break;
        case kTLimoControlMoveLeft:
            [limo moveLeft];
            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_left"]];
            break;
        default:
            break;
    }
}

- (IBAction)cancelControlCommand:(UIButton *)button forEvent:(UIEvent *)event {
    [limo stopMove];
    [self.joypadImageView setImage:[UIImage imageNamed:@"nav_inactive.png"]];
    
}

- (IBAction)dismissMe:(UISwipeGestureRecognizer *)sender {
    [limo stopMove];
    [self dismissModalViewControllerAnimated:YES];
}


- (void)updateBTStatusLabel:(NSNotification *)notifs {
    
    NSString *newStatus = nil;
    
    if (notifs) {
        newStatus = notifs.name;
    }
    
    [self.btStatusLabel setText:newStatus];
}

- (void)dealloc {
    [btStatusLabel release];
    [joypadImageView release];
    [super dealloc];
}

@end
