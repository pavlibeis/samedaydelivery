//
//  ThirdViewController.m
//  sameDayDelivery
//
//  Created by Boris  on 2/27/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "ThirdViewController.h"
#import "ModalViewController.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"kDriverNotifRecieved" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkButton:(id)sender {
    //    ModalViewController *aModalViewController = [[ModalViewController alloc] init];
    ModalViewController *aModalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"modal"];
    
    
    //This will be the size you want
    
    [self presentViewController:aModalViewController animated:YES completion:nil];
    
    //    [self presentModalViewController:aModalViewController animated:YES];
    
}

#pragma mark - Notification
-(void) triggerAction:(NSNotification *) notification
{
    ModalViewController *aModalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"modal"];
    
    [self presentViewController:aModalViewController animated:YES completion:nil];
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
