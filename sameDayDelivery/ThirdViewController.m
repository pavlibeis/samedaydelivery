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

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"kDriverNotifRecieved" object:nil];
    
    /*
    for (NSString *key in [receivedNotification allKeys]) {
        NSLog(@"KEY:%@",key);
    }
     */
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.desiredAccuracy =  kCLLocationAccuracyThreeKilometers;
    [locationManager startUpdatingLocation];
    
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

#pragma mark - CLLocation Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = newLocation.coordinate.latitude;
    location.longitude = newLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
    
}

@end
