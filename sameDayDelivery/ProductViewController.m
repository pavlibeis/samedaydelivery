//
//  ProductViewController.m
//  sameDayDelivery
//
//  Created by Boris  on 2/28/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

@synthesize product;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self connectBestBuyAPI];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    NSString *placeString = [NSString stringWithFormat:@"http://api.remix.bestbuy.com/v1/stores((postalCode=94103))+products(sku%%20in%%20(%@))?format=json&apiKey=k6r8ewx7theybxb5xn3hzvkj&show=products.sku,products.name,products.shortDescription,products.salePrice,products.regularPrice,products.addToCartURL,products.url,products.image,products.customerReviewCount,products.customerReviewAverage,address,city,hours,hoursAmPm,lat,lng,name,fullPostalCode,region,storeId&callback=JSON_CALLBACK",[product objectForKey:@"sku"]];
    
    
    [self URLConnect:placeString withMethod:@"GET"];
    
}

#pragma mark - NSURL Delegate Methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection success.");
    
    theResponse = [[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding: NSUTF8StringEncoding];
    
    NSString *jsonString = [theResponse stringByReplacingOccurrencesOfString:@"JSON_CALLBACK(" withString:@""];
    jsonString = [jsonString substringToIndex:[jsonString length] - 1];
    
    //NSLog(@"theResponse:%@",jsonString);
    
    NSError *error;
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    storesArray = [[NSMutableArray alloc] init];
    storesArray = [json objectForKey:@"stores"];
    
    if ([storesArray count] > 0) {
        store = [[NSMutableDictionary alloc] init];
        store = [storesArray objectAtIndex:0];
        NSLog(@"FOUND IT");
    } else {
        NSLog(@"NOOOOO!!!");
    }
    
    
    
    
    
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
