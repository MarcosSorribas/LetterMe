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

+(Letter*)createLetterInContext:(NSManagedObjectContext*)context;
{
    
    Letter *letter = [NSEntityDescription insertNewObjectForEntityForName:letterEntityName inManagedObjectContext:context];
    letter.letterSendDate = [NSDate date];
    return letter;
}

@end