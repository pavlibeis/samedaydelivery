//
//  FirstViewController.m
//  sameDayDelivery
//
//  Created by Pavlos Dimitriou on 2/27/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import "FirstViewController.h"
#import "ProductsTableViewCell.h"
#import "ProductViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize theTableView;

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
    
    //NSLog(@"theResponse:%@",jsonString);
    
    NSError *error;
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    productsArray = [[NSMutableArray alloc] init];
    productsArray = [json objectForKey:@"products"];
    
    imagesArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *product in productsArray) {
        NSURL *url = [NSURL URLWithString:[product objectForKey:@"image"]];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [[UIImage alloc] initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imagesArray addObject:[[UIImageView alloc] initWithImage:img]];
                [theTableView reloadData];
            });
        });
    }
    
    [self.theTableView reloadData];
    
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

#pragma mark - Table view data source & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [productsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.productNameLabel.text = [[productsArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.productPriceLabel.text = [NSString stringWithFormat:@"Price: $%@",[[productsArray objectAtIndex:indexPath.row] objectForKey:@"salePrice"]];
    
    NSURL *url = [NSURL URLWithString:[[productsArray objectAtIndex:indexPath.row] objectForKey:@"image"]];
    
    if (url) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[cell imageView] setImage:image];
                    [cell setNeedsLayout];
                });
            });
    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"LOCO");
    ProductViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"product"];
    pvc.product = [productsArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:pvc animated:YES];

    
}


@end
