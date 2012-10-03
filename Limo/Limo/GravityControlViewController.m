//
//  GravityControlViewController.m
//  Limo
//
//  Created by stranbird on 9/25/12.
//
//

#import "GravityControlViewController.h"
#import "Limo.h"
#import "AppDelegate.h"

#define kAccelerometerFrequency 50
#define kFilteringFactor 0.1

#define kTLimoControlResetDirection 100
#define kTLimoControlMoveForward    101
#define kTLimoControlMoveBackward   102
#define kTLimoControlMoveLeft       103
#define kTLimoControlMoveRight      104
#define kTLimoControlStopMove       105


@interface GravityControlViewController () {
    UIAccelerationValue accelX, accelY, accelZ;
}
@end

@implementation GravityControlViewController

@synthesize joypadImageView;

- (void)configureAccelerometer {
    UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
    theAccelerometer.updateInterval = 1 / kAccelerometerFrequency;
    
    theAccelerometer.delegate = self;
}

- (IBAction)stopLimo:(id)sender {
    UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
    if (accelerometer.delegate == nil) {
        accelerometer.delegate = self;
    } else
        accelerometer.delegate = nil;
    
    [limo stopMove];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    limo = appDelegate.limo;
    
    
    [self configureAccelerometer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)dismissMe:(UIGestureRecognizer *)sender {    
    [self dismissModalViewControllerAnimated:YES];
}

#define kAccelXMoveForwardThreshold -0.8
#define kAccelXMoveBackwardThreshold -0.8
#define kAccelYMoveLeftThreshold 0.20
#define kAccelYMoveRightThreshold -0.20

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    accelX = (acceleration.x * kFilteringFactor) + (accelX * (1.0 - kFilteringFactor));
    accelY = (acceleration.y * kFilteringFactor) + (accelY * (1.0 - kFilteringFactor));
    accelZ = (acceleration.z * kFilteringFactor) + (accelZ * (1.0 - kFilteringFactor));
    
    NSLog(@"%f, %f, %f", accelX , accelY, accelZ);
    
    if (accelX > kAccelXMoveForwardThreshold)
        [self sendControlCommand:kTLimoControlMoveForward];
    else if (accelX < kAccelXMoveBackwardThreshold)
        [self sendControlCommand:kTLimoControlMoveBackward];
    
    if (accelY > kAccelYMoveLeftThreshold)
        [self sendControlCommand:kTLimoControlMoveLeft];
    else if (accelY < kAccelYMoveRightThreshold)
        [self sendControlCommand:kTLimoControlMoveRight];
    else
        [self sendControlCommand:kTLimoControlResetDirection];
}

- (IBAction)sendControlCommand:(int)command {
    switch (command) {
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
        case kTLimoControlResetDirection:
            [limo resetDirection];
            break;
        default:
            break;
    }
}

@end
