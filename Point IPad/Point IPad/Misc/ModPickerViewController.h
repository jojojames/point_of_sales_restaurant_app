//
//  ModPickerViewController.h
//  Point IPad
//
//  Created by Developer on 5/8/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"

@interface ModPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *modNames;
- (id)initWithStyle:(UITableViewStyle)style withDB:(DatabaseAccess *)db usingItem:(NSNumber *)itemId;
@end
