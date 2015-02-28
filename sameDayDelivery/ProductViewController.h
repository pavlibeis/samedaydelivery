//
//  ProductViewController.h
//  sameDayDelivery
//
//  Created by Boris  on 2/28/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController <NSURLConnectionDelegate> {
    
    // HTTP Request Related Local Variables
    NSMutableData *receivedData;
    NSURLConnection *urlConnection;
    NSString *theResponse;
    
    //stores related arrays
    NSMutableArray *storesArray;
    NSMutableDictionary *store;
}


@property (nonatomic, strong) NSDictionary *product;

@end
