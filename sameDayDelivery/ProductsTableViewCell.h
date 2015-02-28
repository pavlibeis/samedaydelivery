//
//  ProductsTableViewCell.h
//  sameDayDelivery
//
//  Created by Boris  on 2/28/15.
//  Copyright (c) 2015 Pavlos Dimitriou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductsTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *productNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *productPriceLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
