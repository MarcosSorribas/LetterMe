//
//  NSDate+CustomizableDate.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "NSDate+CustomizableDate.h"

@implementation NSDate (CustomizableDate)

-(NSString *)dateWithMyFormat{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d 'de' MMMM 'de' YYYY"];
    NSString *dateString = [dateFormat stringFromDate:self];
    return dateString;
}

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return labs([difference day]);
}

@end