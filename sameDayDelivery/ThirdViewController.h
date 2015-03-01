//
//  ThirdViewController.h
//  sameDayDelivery
//
//  Created by Boris  on 2/27/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewController.h"
#import <MapKit/MapKit.h>

@interface ThirdViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>  {
    
    CLLocationManager *locationManager;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;


@end
