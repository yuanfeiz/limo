//
//  AppDelegate.h
//  Limo
//
//  Created by 元飞 朱 on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModeSelectionViewController;
@class Limo;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ModeSelectionViewController *viewController;

@property (retain, nonatomic) Limo *limo;


@end
