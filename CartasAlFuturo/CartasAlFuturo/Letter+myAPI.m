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


+(NSFetchedResultsController*)pendingLettersToShowInContext:(NSManagedObjectContext *)context{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:letterEntityName];
    NSSortDescriptor *orderByDate = [NSSortDescriptor sortDescriptorWithKey:@"letterOpenDate" ascending:YES];
    fetch.sortDescriptors = @[orderByDate];
    NSPredicate *onlyPendingLettersQuery = [NSPredicate predicateWithFormat:@"(letterStatus == %d) OR (letterStatus == %d)",MSPending,MSReadyToOpen];
    fetch.predicate =onlyPendingLettersQuery;
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
}

+(NSFetchedResultsController*)openedLettersToShowInContext:(NSManagedObjectContext *) context{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:letterEntityName];
    NSSortDescriptor *orderByDate = [NSSortDescriptor sortDescriptorWithKey:@"letterOpenDate" ascending:YES];
    fetch.sortDescriptors = @[orderByDate];
    NSPredicate *onlyOpenedLettersQuery = [NSPredicate predicateWithFormat:@"(letterStatus == %d)",MSRead];
    fetch.predicate = onlyOpenedLettersQuery;
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
}


@end