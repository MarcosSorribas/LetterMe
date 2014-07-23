//
//  LetterTests.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <XCTest/XCTest.h>
//#import <OCMock/OCMock.h>
#import "Letter.h"
#import "Letter+myAPI.h"

@interface LetterTests : XCTestCase {
    // Core Data stack objects.
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
    // Object to test.
    Letter *sut;
}

@end

@implementation LetterTests

#pragma mark - Set up and tear down

- (void) setUp {
    [super setUp];
    
    [self createCoreDataStack];
    [self createFixture];
    [self createSut];
}

- (void) createCoreDataStack {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    model = [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType: NSInMemoryStoreType
                                      configuration: nil
                                                URL: nil
                                            options: nil
                                              error: NULL];
    context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = coordinator;
}

- (void) createFixture {
    // Test data
}

- (void) createSut {
    sut = [Letter createLetterInContext:context];
}

- (void) tearDown {
    [self releaseSut];
    [self releaseFixture];
    [self releaseCoreDataStack];
    
    [super tearDown];
}

- (void) releaseSut {
    sut = nil;
}

- (void) releaseFixture {
    
}

- (void) releaseCoreDataStack {
    context = nil;
    store = nil;
    coordinator = nil;
    model = nil;
}

#pragma mark - Basic test

- (void) testCanCreateALetter {
    sut = [NSEntityDescription insertNewObjectForEntityForName:@"Letter" inManagedObjectContext:context];
    XCTAssertNotNil(sut, @"The Letter can't be nil");
}

- (void) testCanCreateALetterWithNotNilNotOptionalValues{
    XCTAssertNotNil(sut.letterSendDate, @"Letter sendDate can't be nil");
    XCTAssertNotNil(sut.letterOpenDate, @"Letter OpenDate can't be nil");
    XCTAssertNotNil(sut.letterStatus, @"Letter Status can't be nil");
}

- (void) testCanCreateALetterWithConvenienceConstructor{
    sut = [Letter createLetterInContext:context];
    XCTAssertNotNil(sut, @"The Letter can't be nil");
}
- (void) testCanCreateAletterAndSetHisTitle{
    NSString *tituloPrueba = @"Mi titulo de prueba";
    sut.letterTitle = tituloPrueba;
    XCTAssertEqualObjects(sut.letterTitle, tituloPrueba, @"Letter title should be equal to tituloPrueba");
}
- (void) testCanCreateAletterAndSetHisContent{
    NSString *contenidoPrueba = @"Este es mi contenido de prueba.";
    sut.letterContent = contenidoPrueba;
    XCTAssertEqualObjects(sut.letterContent, contenidoPrueba, @"Letter content should be equal to contenidoPrueba");
}
- (void) testCanCreateAletterAndSetHisOpenDate{
    NSDate *date = [NSDate date];
    sut.letterOpenDate = date;
    XCTAssertEqualObjects(sut.letterOpenDate, date, @"Letter openDate should be equal to date");
}
- (void)testCanCreateAletterAndSetHisSendDate{
    NSDate *date = [NSDate date];
    sut.letterOpenDate = date;
    XCTAssertEqualObjects(sut.letterOpenDate, date, @"Letter openDate should be equal to date");
}


- (void)testCanCreateAletterAndSetHisStatus{
    sut.letterStatus = [NSNumber numberWithInt:MSReadyToOpen];
    XCTAssertTrue([sut.letterStatus isEqualToNumber:[NSNumber numberWithInt:MSReadyToOpen]], @"Letter status should be equtal to MSReadyToOpen");
}

- (void) testFetchPendingLettersIsCorrect{
    
    //Inserto 7 cartas en el contexto.
    for (int i = 0; i < 7; i++) {
        Letter *letter = [Letter createLetterInContext:context];
        letter.letterStatus = [NSNumber numberWithInt:arc4random()%3];
    }
    
    NSFetchedResultsController *pendingFetch = [Letter pendingLettersToShowInContext:context];
    NSMutableArray *pendingLetters = [[NSMutableArray alloc]initWithArray:[context executeFetchRequest:pendingFetch.fetchRequest error:nil]];
    
    
    NSFetchRequest *allFetch = [NSFetchRequest fetchRequestWithEntityName:letterEntityName];
    allFetch.predicate = nil;
    NSArray *allLetters = [context executeFetchRequest:allFetch error:nil];
    
    for (Letter *letter in allLetters) {
        if ([letter.letterStatus isEqualToNumber:[NSNumber numberWithInt:MSReadyToOpen]] || [letter.letterStatus isEqualToNumber:[NSNumber numberWithInt:MSPending]]) {
            XCTAssertTrue([pendingLetters containsObject:letter], @"Pending and readyToOpen Letters must be in a pendingLetter fetch");
            [pendingLetters removeObject:letter];
        }else{
            XCTAssertFalse([pendingLetters containsObject:letter], @"Other status Letter can't be in a pendingLetter");
        }
    }
    XCTAssertTrue(pendingLetters.count == 0, @"All pending Letters must be analyzed");
    
}
- (void)testFetchOpenedLettersIsCorrect{
    //Inserto 7 cartas en el contexto.
    for (int i = 0; i < 7; i++) {
        Letter *letter = [Letter createLetterInContext:context];
        letter.letterStatus = [NSNumber numberWithInt:arc4random()%3];
    }
    
    NSFetchedResultsController *openedFetch = [Letter openedLettersToShowInContext:context];
    NSMutableArray *openedLetters = [[NSMutableArray alloc]initWithArray:[context executeFetchRequest:openedFetch.fetchRequest error:nil]];
    
    
    NSFetchRequest *allFetch = [NSFetchRequest fetchRequestWithEntityName:letterEntityName];
    allFetch.predicate = nil;
    NSArray *allLetters = [context executeFetchRequest:allFetch error:nil];
    
    for (Letter *letter in allLetters) {
        if ([letter.letterStatus isEqualToNumber:[NSNumber numberWithInt:MSRead]]) {
             XCTAssertTrue([openedLetters containsObject:letter], @"read Letters must be in a openedLetter fetch");
            [openedLetters removeObject:letter];
        }else{
            XCTAssertFalse([openedLetters containsObject:letter], @"Other status Letter can't be in a openedLetter fetch");
        }
    }
    
    XCTAssertTrue(openedLetters.count == 0, @"All opened Letters must be analyzed");

}


- (void)testFetchNextReadyToOpenLettersIsCorrect{
    //Inserto 7 cartas en el contexto.
    for (int i = 0; i < 7; i++) {
        Letter *letter = [Letter createLetterInContext:context];
        letter.letterStatus = [NSNumber numberWithInt:MSPending];
        //3 cartas listas para abrir y 4 todavia no.
        letter.letterOpenDate = [NSDate dateWithTimeInterval:i*24*60*60 sinceDate:[NSDate dateWithTimeIntervalSinceNow:-3*24*60*60]];
    }
    
    NSMutableArray *readyToOpen = [Letter checkReadyToOpenLettersInContext:context].mutableCopy;

    
    
    NSFetchRequest *allFetch = [NSFetchRequest fetchRequestWithEntityName:letterEntityName];
    allFetch.predicate = nil;
    NSArray *allLetters = [context executeFetchRequest:allFetch error:nil];
    
    for (Letter *letter in allLetters) {
        if ([letter.letterStatus isEqualToNumber:[NSNumber numberWithInt:MSPending]] && [letter.letterOpenDate compare:[NSDate date]] == NSOrderedAscending) {
            XCTAssertTrue([readyToOpen containsObject:letter], @"past time Letters must be in a readyToOpen fetch");
            [readyToOpen removeObject:letter];
        }else{
            XCTAssertFalse([readyToOpen containsObject:letter], @"Other status Letter can't be in a openedLetter fetch");
        }
    }
    
    XCTAssertTrue(readyToOpen.count == 0, @"All opened Letters must be analyzed");
    
}

@end