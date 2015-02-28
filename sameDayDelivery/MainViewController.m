//
//  MainViewController.m
//  sameDayDelivery
//
//  Created by Boris  on 2/28/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize addressContainerView;

- (IBAction)select:(id)sender {
    
    UISegmentedControl *control = sender;
    
    if (control.selectedSegmentIndex == 0) {
        addressContainerView.hidden = YES;
    } else {
        addressContainerView.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    addressContainerView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
