//
//  Time.h
//  Login
//
//  Created by Developer on 3/12/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject

- (NSString *)getYearMonthDay;
- (NSString *)getYearMonthDayTime;
- (NSTimeInterval)getTimeIntervalBetweenFirstDate:(NSString *)firstDate andSecondDate:(NSString *)secondDate;

@end
