//
//  QuickCollectionFlow.m
//  Point IPad
//
//  Created by Developer on 4/24/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "QuickCollectionFlow.h"

@implementation QuickCollectionFlow

- (id)init
{
    if (!(self = [super init])) return nil;
    
    // change insets later, they're already set in storyboard
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    return self;
}

@end
