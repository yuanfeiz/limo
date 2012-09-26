//
//  ModeSelectionViewController.m
//  Limo
//
//  Created by stranbird on 9/25/12.
//
//

#import "ModeSelectionViewController.h"
#import "JoypadViewController.h"
#import "GravityControlViewController.h"

@interface ModeSelectionViewController ()

@end

@implementation ModeSelectionViewController

@synthesize controlViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc {
    [controlViewController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)modeChosen:(UIButton *)sender {
    switch (sender.tag) {
        case 201:
            controlViewController = [[JoypadViewController alloc] initWithNibName:@"JoypadViewController" bundle:nil];
            break;
        case 202:
            controlViewController = [[GravityControlViewController alloc] initWithNibName:@"GravityControlViewController" bundle:nil];
            break;
        default:
            break;
    }
    [self presentModalViewController:controlViewController animated:YES];
}


@end
