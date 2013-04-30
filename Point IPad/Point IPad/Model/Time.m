//
//  Time.m
//  Login
//
//  Created by Developer on 3/12/13.
//  Copyright (c) 2013 Developer. All rights reserved.
//

#import "Time.h"

@implementation Time

- (NSString *)yearMonthDay
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd"]; // format example : 1999-03-12
    NSString *dateString = [formatter stringFromDate:date];
    [formatter release];
    return dateString;
}

- (NSString *)yearMonthDayTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"]; // with time now
    NSString *dateString = [formatter stringFromDate:date];
    [formatter release];
    return dateString;
}

- (NSTimeInterval)timeBetweenDate:(NSString *)firstDate andSecondDate:(NSString *)secondDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSDate *date1 = [formatter dateFromString:firstDate];
    NSDate *date2 = [formatter dateFromString:secondDate];
    NSTimeInterval diff = [date2 timeIntervalSinceDate:date1];
    [formatter release];
    return diff;
}


@end
