//
//  NSDate+CustomizableDate.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "NSDate+CustomizableDate.h"

@implementation NSDate (CustomizableDate)
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
   
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

-(NSString *)dateWithMyFormat{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:self];
    NSString *date = [NSString stringWithFormat:@"%ld del %ld del %ld",components.day,components.month,components.year];
    return date;
}

-(NSString*)countdownInDays{
    NSTimeInterval timeInterval = [self timeIntervalSinceNow];
    NSUInteger days = roundf(timeInterval/(60*60*24));
    return [NSString stringWithFormat:@"%ld",days];
}
@end