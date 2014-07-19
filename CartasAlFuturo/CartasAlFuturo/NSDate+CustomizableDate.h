//
//  NSDate+CustomizableDate.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CustomizableDate)
+(NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
//-(NSString*)dateWithMyFormat;
@end
