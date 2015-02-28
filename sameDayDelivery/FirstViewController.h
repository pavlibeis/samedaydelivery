//
//  FirstViewController.h
//  sameDayDelivery
//
//  Created by Pavlos Dimitriou on 2/27/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <NSURLConnectionDelegate, UITableViewDataSource, UITabBarDelegate> {
    
    // HTTP Request Related Local Variables
    NSMutableData *receivedData;
    NSURLConnection *urlConnection;
    NSString *theResponse;
    
    //products related arrays
    NSMutableArray *productsArray;
    NSMutableArray *imagesArray;
}


@property (nonatomic, strong) IBOutlet UITableView *theTableView;

@end

