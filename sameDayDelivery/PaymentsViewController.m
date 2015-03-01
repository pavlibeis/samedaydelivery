//
//  PaymentsViewController.m
//  sameDayDelivery
//
//  Created by Boris  on 3/1/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "PaymentsViewController.h"

@interface PaymentsViewController ()

@end

@implementation PaymentsViewController

- (IBAction)back:(id)sender {
    
    
    NSLog(@"here");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
