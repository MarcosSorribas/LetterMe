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
NSTimeInterval const predeterminedTime = 24*60*60; //Segundos de 1 dia.

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
    NSSortDescriptor *orderByDate = [NSSortDescriptor sortDescriptorWithKey:@"letterOpenDate" ascending:YES];
    NSPredicate *onlyPendingLettersQuery = [NSPredicate predicateWithFormat:@"(letterStatus == %d) OR (letterStatus == %d)",MSPending,MSReadyToOpen];
    NSFetchRequest *fetch = [Letter configureFetchWithSortDescriptor:orderByDate andPredicate:onlyPendingLettersQuery];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
}

+(NSFetchedResultsController*)openedLettersToShowInContext:(NSManagedObjectContext *) context{
    
    NSSortDescriptor *orderByDate = [NSSortDescriptor sortDescriptorWithKey:@"letterOpenDate" ascending:YES];
    NSPredicate *onlyOpenedLettersQuery = [NSPredicate predicateWithFormat:@"(letterStatus == %d)",MSRead];
    NSFetchRequest *fetch = [Letter configureFetchWithSortDescriptor:orderByDate andPredicate:onlyOpenedLettersQuery];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
}

+(NSArray*)checkReadyToOpenLettersInContext:(NSManagedObjectContext *) context{
    NSDate *now = [NSDate date];
    NSPredicate *onlyNextReadyToOpenLetters = [NSPredicate predicateWithFormat:@"(letterStatus == %d AND letterOpenDate <= %@)",MSPending,now];
    NSSortDescriptor *orderByDate = [NSSortDescriptor sortDescriptorWithKey:@"letterOpenDate" ascending:YES];

    NSFetchRequest *fetch = [Letter configureFetchWithSortDescriptor:orderByDate andPredicate:onlyNextReadyToOpenLetters];
    
    NSArray *result = [context executeFetchRequest:fetch error:nil];

    return result;
}

#pragma mark -
#pragma mark - Private Methods

+(NSFetchRequest*)configureFetchWithSortDescriptor:(NSSortDescriptor*)descriptor andPredicate:(NSPredicate*)predicate{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:letterEntityName];
    NSSortDescriptor *sortDescriptor = descriptor;
    if(sortDescriptor) {
        fetch.sortDescriptors = @[sortDescriptor];
    }
    fetch.predicate = predicate;
    return fetch;
}

@end