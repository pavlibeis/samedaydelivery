//
//  AppDelegate.m
//  sameDayDelivery
//
//  Created by Pavlos Dimitriou on 2/27/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "FirstViewController.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate{
    CLLocationManager *locationManager;

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"ghJmCtSjTCYdsihfeZGtWTdaqMXmF5TJS1Uu629V"
                  clientKey:@"uXGyXFhfWsA2OHtwJ0p2GH75Jwu4tgKygh7NzOl8"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    // When users indicate they are Giants fans, we subscribe them to that channel.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:@"DelivererLocation" forKey:@"channels"];
    [currentInstallation saveInBackground];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    [locationManager startUpdatingLocation];
    [Fabric with:@[TwitterKit]];
    
    lgName=@"";

    return YES;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current Installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Just receive a notification");
    
    for (NSString *key in [[userInfo objectForKey:@"aps"] allKeys]) {
        NSLog(@"KEYS:%@",key);
    }
    
    if ([[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] isEqualToString:@"Your Pickup is Waiting for you!"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kDriverNotifRecieved" object:userInfo];
    } else {
        NSLog(@"LOCO");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCustomerNotifRecieved" object:userInfo];
    }
    
    
    

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"didUpdateToLocation: %@", newLocation);
 
    lgName = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"lgName"];
    
    if (!lgName) {
        lgName = @"";
    }
        
//        PFQuery *userQuery = [PFUser query];
//        
//        PFQuery *locationQuery = [PFQuery queryWithClassName:@"Delivers"];
//        [locationQuery whereKey:@"userName" equalTo:lgName];
//        
//
//        [userQuery findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
//            for (PFObject *user in users) {
//                PFObject *location = user[@"Delivers"];
//                NSLog(@"location %@",location);
//                // read user/car properties as needed
//            }
//        }];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Delivers"];
        [query whereKey:@"userName" equalTo:lgName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
           
            if ([objects count]<1) {
                
                NSLog(@"longitude %f",  newLocation.coordinate.longitude);
                NSLog(@"latitude %f",  newLocation.coordinate.latitude);
                PFObject *deliverer = [PFObject objectWithClassName:@"Delivers"];
                deliverer[@"locationNow"] = [PFGeoPoint geoPointWithLocation:newLocation];
                deliverer[@"userName"] = lgName;
                
                [deliverer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        // The object has been saved.
                    } else {
                        // There was a problem, check error.description
                    }
                }];

            } else {
                
                
                PFObject *object = [objects objectAtIndex:0];
                object[@"locationNow"] = [PFGeoPoint geoPointWithLocation:newLocation];
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        // The object has been saved.
                    } else {
                        // There was a problem, check error.description
                    }
                }];
            }
            
            
            
        }];
    

        
        

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
