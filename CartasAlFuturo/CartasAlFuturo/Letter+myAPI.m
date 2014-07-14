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
    Letter *letter = [NSEntityDescription insertNewObjectForEntityForName:letterEntityName inManagedObjectContext:context];
    return letter;
}


- (void) awakeFromInsert
{
    [super awakeFromInsert];
    self.letterSendDate = [NSDate date];
    self.letterOpenDate = [NSDate dateWithTimeIntervalSinceNow:predeterminedTime];
}
@end