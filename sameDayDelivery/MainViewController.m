//
//  MainViewController.m
//  sameDayDelivery
//
//  Created by Boris  on 2/28/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "MainViewController.h"
#import "DestinationViewController.h"
#import "PaymentsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize addressContainerView, mapView, gmsButton,bmsButton, addressTExtField, onTheWayLabel, getLiteButton;
@synthesize upLabel,bottonLabel;

- (IBAction)call:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:19545536227"]];
}

- (IBAction)back:(id)sender {
    [self back];
}

- (void)back {
    
    gmsButton.hidden = NO;
    bmsButton.hidden = NO;
    addressTExtField.hidden = YES;
    getLiteButton.enabled = NO;
    getLiteButton.hidden = NO;
    onTheWayLabel.hidden = YES;
    upLabel.hidden = NO;
    bottonLabel.hidden = NO;
}

- (IBAction)getLite:(id)sender {
    
    onTheWayLabel.hidden = NO;
    getLiteButton.hidden = YES;
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"DelivererLocation"];
    [push setMessage:@"Your Pickup is Waiting for you!"];
    [push sendPushInBackground];
}

- (IBAction)getMyStuff:(id)sender {
    
    gmsButton.hidden = YES;
    bmsButton.hidden = YES;
    addressTExtField.hidden = NO;
    getLiteButton.enabled = YES;
    [getLiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

- (IBAction)bringMyStuff:(id)sender {
    
    gmsButton.hidden = YES;
    bmsButton.hidden = YES;
    addressTExtField.hidden = NO;
    getLiteButton.enabled = YES;
    [getLiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
}

- (IBAction)next:(id)sender {
    
    DestinationViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"destination"];
    [self.navigationController pushViewController:dvc animated:YES];

}

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
    
    // When users indicate they are Giants fans, we subscribe them to that channel.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:@"DelivererLocation" forKey:@"channels"];
    [currentInstallation saveInBackground];
    
    addressContainerView.hidden = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.desiredAccuracy =  kCLLocationAccuracyThreeKilometers;
    [locationManager startUpdatingLocation];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(triggerAction:) name:@"kCustomerNotifRecieved" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openConfig:(id)sender {
    
    PaymentsViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
    [self.navigationController pushViewController:pvc animated:YES];
    
    NSLog(@"WHAT>");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Notification
-(void) triggerAction:(NSNotification *) notification
{
    NSLog(@"WHOOOOHOOO");
    [self back];
}

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
