//
//  PopUpModDescriptionViewController.h
//  Point IPad
//
//  Created by Developer on 6/3/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpModDescriptionViewController : UITableViewController
@property (strong, nonatomic) NSArray *stringModArray;
- (id)initWithStyle:(UITableViewStyle)style andArray:(NSArray *)_stringModArray;
@end
