//
//  ViewController.h
//  Limo
//
//  Created by 元飞 朱 on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Limo.h"

#define kTLimoControlStopMove       100
#define kTLimoControlMoveForward    101
#define kTLimoControlMoveBackward   102
#define kTLimoControlMoveLeft       103
#define kTLimoControlMoveRight      104

@interface ViewController : UIViewController

@property (retain, nonatomic) Limo *limo;

@property (retain, nonatomic) IBOutlet UILabel *btStatusLabel;

- (IBAction)sendControlCommand:(id)sender;

@end