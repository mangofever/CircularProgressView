//
//  ViewController.m
//  CircularProgressViewSample
//
//  Created by Mangofever on 2015. 3. 12..
//  Copyright (c) 2015년 Mangofever. All rights reserved.
//

#import "ViewController.h"
#import "CircularProgressView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CircularProgressView *circularProgressView;
@property (nonatomic) BOOL animated;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.circularProgressView setProgressValue:0 animatedFromProgressValue:1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)click10:(id)sender {
    [self.circularProgressView setProgressValue:0.1 animated:self.animated];
}
- (IBAction)click70:(id)sender {
    [self.circularProgressView setProgressValue:0.7 animated:self.animated];
}
- (IBAction)click100:(id)sender {
    [self.circularProgressView setProgressValue:1.0 animated:self.animated];
}

- (IBAction)percentageStringToggled:(UISwitch *)toggleSwitch {
    if (toggleSwitch.isOn) {
        self.circularProgressView.percentageTextHidden = NO;
    } else {
        self.circularProgressView.percentageTextHidden = YES;
    }
}
- (IBAction)animatedSwitchToggled:(UISwitch *)animatedSwitch {
    self.animated = animatedSwitch.isOn;
}

@end
