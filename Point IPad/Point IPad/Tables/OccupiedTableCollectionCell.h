//
//  OccupiedTableCollectionCell.h
//  Point IPad
//
//  Created by Developer on 6/3/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OccupiedTableCollectionCell : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UILabel *optionLabel;
- (void)changeBorders:(CGRect)frame;
@end
