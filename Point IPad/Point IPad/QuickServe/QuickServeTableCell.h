//
//  QuickServeTableCell.h
//  Point IPad
//
//  Created by Developer on 5/15/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickServeTableCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *qtyLabel;

@end
