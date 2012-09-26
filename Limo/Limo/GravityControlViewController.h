//
//  GravityControlViewController.h
//  Limo
//
//  Created by stranbird on 9/25/12.
//
//

#import <UIKit/UIKit.h>

@interface GravityControlViewController : UIViewController<UIAccelerometerDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *joypadImageView;

- (IBAction)dismissMe:(id)sender;

- (void)configureAccelerometer;

@end
