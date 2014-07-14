//
//  Letter+myAPI.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "Letter+myAPI.h"

@implementation Letter (myAPI)

NSString *const letterEntityName = @"Letter";
NSTimeInterval const predeterminedTime = 2592000; //Segundos de 1 mes.

+(Letter*)createLetterInContext:(NSManagedObjectContext*)context;
{
    return [NSEntityDescription insertNewObjectForEntityForName:letterEntityName inManagedObjectContext:context];
}

-(NSDate*)letterOpenDate{
    NSString *key = @"letterOpenDate";
    if ([self primitiveValueForKey:key] == nil) {
        [self setPrimitiveValue:[NSDate dateWithTimeIntervalSinceNow:predeterminedTime] forKey:key];
    }
    return [self primitiveValueForKey:key];
}

-(NSDate *)letterSendDate{
    NSString *key = @"letterSendDate";
    if ([self primitiveValueForKey:key] == nil) {
        [self setPrimitiveValue:[NSDate date] forKey:key];
    }
    return [self primitiveValueForKey:key];
}

@end