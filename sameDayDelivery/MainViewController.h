//
//  MainViewController.h
//  sameDayDelivery
//
//  Created by Boris  on 2/28/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) IBOutlet UIView *addressContainerView;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) IBOutlet UIButton *gmsButton;
@property (nonatomic, strong) IBOutlet UIButton *bmsButton;
@property (nonatomic, strong) IBOutlet UIButton *getLiteButton;
@property (nonatomic, strong) IBOutlet UITextField *addressTExtField;
@property (nonatomic, strong) IBOutlet UILabel *onTheWayLabel;

@end
