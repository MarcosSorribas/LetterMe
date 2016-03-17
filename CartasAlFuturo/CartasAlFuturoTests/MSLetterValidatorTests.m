//
//  MSLetterValidatorTests.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//


#import <XCTest/XCTest.h>
//#import <OCMock/OCMock.h>
#import "MSLetterValidator.h"
#import "Letter+myAPI.h"

@interface MSLetterValidatorTests : XCTestCase {
    // Core Data stack objects.
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
    // Object to test.
    MSLetterValidator *sut;
}

@end


@implementation MSLetterValidatorTests

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
    sut = [[MSLetterValidator alloc] init];
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

- (void) testIsAValidLetterTitle{
    
    XCTAssertFalse([sut isAValidLetterTitle:@"Lorem fistrum a gramenawer llevame al sircoo no te digo trigo por no llamarte Rodrigor pupita qué dise usteer fistro amatomaa. Quietooor amatomaa por la gloria de mi madre mamaar ese hombree diodeno va usté muy cargadoo tiene musho peligro quietooor. Tiene musho peligro a peich la caidita ese hombree ese hombree condemor ese pedazo de benemeritaar. Diodeno pecador ese que llega de la pradera condemor de la pradera caballo blanco caballo negroorl condemor. A gramenawer de la pradera ese pedazo de la caidita ese que llega. A gramenawer te voy a borrar el cerito al ataquerl ahorarr hasta luego Lucas de la pradera no puedor"], @"Title can't be +100 length");
    
    
    XCTAssertFalse([sut isAValidLetterTitle:@""], @"Title can't be empty");
    
    XCTAssertFalse([sut isAValidLetterTitle:@"      "], @"Title can't be only whiteSpaces");
    
    XCTAssertTrue([sut isAValidLetterTitle:@"Hola que tal estas"], @"Normal title is correct");
    
}

- (void) testIsAValidLetterContent{
    
    XCTAssertTrue([sut isAValidLetterContent:@"Lorem fistrum a gramenawer llevame al sircoo no te digo trigo por no llamarte Rodrigor pupita qué dise usteer fistro amatomaa. Quietooor amatomaa por la gloria de mi madre mamaar ese hombree diodeno va usté muy cargadoo tiene musho peligro quietooor. Tiene musho peligro a peich la caidita ese hombree ese hombree condemor ese pedazo de benemeritaar. Diodeno pecador ese que llega de la pradera condemor de la pradera caballo blanco caballo negroorl condemor. A gramenawer de la pradera ese pedazo de la caidita ese que llega. A gramenawer te voy a borrar el cerito al ataquerl ahorarr hasta luego Lucas de la pradera no puedor"], @"Content can be +100 length");
    
    
    XCTAssertFalse([sut isAValidLetterContent:@""], @"Content can't be empty");
    
    XCTAssertFalse([sut isAValidLetterContent:@"         "], @"Content can't be only whiteSpaces");
}
- (void) testIsAValidLetterOpenDate{
    
    XCTAssertTrue([sut isAValidLetterOpenDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24*30]], @"This date should be a correct date");
    XCTAssertFalse([sut isAValidLetterOpenDate:[NSDate date]], @"This date can't be a correct date ");
    
    
}
- (void) testIsAValidLetter{
    
    Letter *letter = [Letter createLetterInContext:context];
    letter.letterTitle = @"Titulo de prueba";
    letter.letterOpenDate = [NSDate dateWithTimeIntervalSinceNow:60*60*24*60];
    letter.letterContent = @" al sircoo no te digo trigo por no llamarte Rodrigor pupita qué dise usteer fistro amatomaa. Quietooor amatomaa por la gloria de mi madre mamaar ese hombree diodeno va usté muy cargadoo tiene musho peligro quietooor. Tiene musho peligro a peich la caidita ese hombree ese hombree condemor ese pedazo ";
    XCTAssertTrue([sut isAValidLetter:letter], @"Should be a valid letter");
    
    letter.letterOpenDate = [NSDate dateWithTimeIntervalSinceNow:20];
    XCTAssertFalse([sut isAValidLetter:letter], @"Shouldnt be a valid letter");
    
}

@end
