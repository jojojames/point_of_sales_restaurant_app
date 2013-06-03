//
//  PaymentTableViewController.h
//  Point IPad
//
//  Created by Developer on 6/3/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Orders.h"

@interface PaymentTableViewController : UITableViewController
@property (nonatomic, strong) NSNumber *tableNumber;
@property (strong, nonatomic) Orders *order; // the model for orders, handles the logic behind orders
@property (nonatomic, strong) NSArray *paymentChoices;
@end
