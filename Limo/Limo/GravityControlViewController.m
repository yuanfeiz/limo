//
//  GravityControlViewController.m
//  Limo
//
//  Created by stranbird on 9/25/12.
//
//

#import "GravityControlViewController.h"

#define kAccelerometerFrequency 50
#define kFilteringFactor 0.1
#define kTLimoControlStopMove       100
#define kTLimoControlMoveForward    101
#define kTLimoControlMoveBackward   102
#define kTLimoControlMoveLeft       103
#define kTLimoControlMoveRight      104

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

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    accelX = (acceleration.x * kFilteringFactor) + (accelX * (1.0 - kFilteringFactor));
    accelY = (acceleration.y * kFilteringFactor) + (accelY * (1.0 - kFilteringFactor));
    accelZ = (acceleration.z * kFilteringFactor) + (accelZ * (1.0 - kFilteringFactor));
    
    NSLog(@"%f, %f, %f", accelX , accelY, accelZ);
}

//- (IBAction)sendControlCommand {
//    switch (1) {
//        case kTLimoControlMoveForward:
//            [limo moveForward];
//            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_up"]];
//            break;
//        case kTLimoControlMoveBackward:
//            [limo moveBackward];
//            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_down"]];
//            break;
//        case kTLimoControlMoveRight:
//            [limo moveRight];
//            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_right"]];
//            break;
//        case kTLimoControlMoveLeft:
//            [limo moveLeft];
//            [self.joypadImageView setImage:[UIImage imageNamed:@"nav_left"]];
//            break;
//        default:
//            break;
//    }
//}

@end
