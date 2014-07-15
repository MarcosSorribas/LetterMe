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
    XCTAssertNotNil(sut.letterTitle, @"Letter title can't be nil");
    XCTAssertNotNil(sut.letterSendDate, @"Letter sendDate can't be nil");
    XCTAssertNotNil(sut.letterOpenDate, @"Letter OpenDate can't be nil");
    XCTAssertNotNil(sut.letterContent, @"Letter Content can't be nil");
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
- (void)testCanCreateAletterAndSetHisDescription{
    NSString *descripcionPrueba = @"Esta es mi descripcion de prueba.";
    sut.letterDescription = descripcionPrueba;
    XCTAssertEqualObjects(sut.letterDescription, descripcionPrueba, @"Letter description should be equal to descripcionPrueba");
}

- (void)testCanCreateAletterAndSetHisStatus{
    sut.letterStatus = [NSNumber numberWithInt:MSReadyToOpen];
    XCTAssertTrue([sut.letterStatus isEqualToNumber:[NSNumber numberWithInt:MSReadyToOpen]], @"Letter status should be equtal to MSReadyToOpen");
}


@end