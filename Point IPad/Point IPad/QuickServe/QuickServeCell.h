//
//  QuickServeCell.h
//  Point IPad
//
//  Created by Developer on 4/22/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickServeCell : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UILabel *itemLabel;

- (void)changeBorders:(CGRect)frame;


@end
