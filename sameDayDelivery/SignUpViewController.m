//
//  SignUpViewController.m
//  sameDayDelivery
//
//  Created by Pavlos Dimitriou on 2/28/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "SignUpViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Objective-C
    TWTRLogInButton *logInButton =  [TWTRLogInButton
                                     buttonWithLogInCompletion:
                                     ^(TWTRSession* session, NSError* error) {
                                         if (session) {
                                             NSLog(@"signed in as %@", [session userName]);
                                             NSString *twitterUserName = [session userName];
                                             [[NSUserDefaults standardUserDefaults] setObject:twitterUserName forKey:@"lgName"];
                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                             
                                         } else {
                                             NSLog(@"error: %@", [error localizedDescription]);
                                         }
                                     }];
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];
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
