//
//  FirstViewController.m
//  sameDayDelivery
//
//  Created by Pavlos Dimitriou on 2/27/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectBestBuyAPI];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)URLConnect:(NSString *)urlString withMethod:(NSString *)method {
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:method];
    
    NSURLConnection *Connection =[[NSURLConnection alloc]
                                  initWithRequest:request
                                  delegate:self];
    
    if (Connection) {
        receivedData = [NSMutableData data];
    }
    
}

-(void)connectBestBuyAPI {
    
    //NSString *placeString  = [NSString stringWithFormat:@"https://api.flightstats.com/flex/airports/rest/v1/json/withinRadius/%f/%f/50?appId=%s&appKey=%s",coordinate.longitude,coordinate.latitude,FlightStatsAppId,FlightStatsAppKey];
    
    NSString *placeString  = @"https://api.remix.bestbuy.com/v1/products((search=iPhone&search=6)&inStoreAvailability=true)?apiKey=k6r8ewx7theybxb5xn3hzvkj&callback=JSON_CALLBACK&format=json";
    
    
    [self URLConnect:placeString withMethod:@"GET"];
    
}

#pragma mark - NSURL Delegate Methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection success.");
    
    theResponse = [[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding: NSUTF8StringEncoding];
    
    NSString *jsonString = [theResponse stringByReplacingOccurrencesOfString:@"JSON_CALLBACK(" withString:@""];
    jsonString = [jsonString substringToIndex:[jsonString length] - 1];
    
    NSLog(@"theResponse:%@",jsonString);
    
    NSError *error;
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    for (NSString *key in [json allKeys]) {
        NSLog(@"Key:%@",key);
    }
    
    
    productsArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *product in [json objectForKey:@"products"]) {
        
        NSString *sku = [product objectForKey:@"sku"];
        
        NSLog(@"SKU:%@",sku);
        /*
        if (classifications < 5 && active) {
            [productsArray addObject:airport];
        }
         */
        
    }
    
    [self.tableView reloadData];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failure.:%@",error);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
    
    theResponse = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
    
    /*
     If the request is being made from the requestRandomPassword method it will request a new random password
     and create a new PFObject with the password and singly user id then it will log the PFObject id in the
     users default with the singly user as a key, then it registers the user to ejabberd
     */
    
}


@end
