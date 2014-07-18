//
//  LetterValidatorTests.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSLetterValidator.h"

@interface LetterValidatorTests : XCTestCase

@end

@implementation LetterValidatorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void) testIsAValidLetterTitle{
    MSLetterValidator *sut = [[MSLetterValidator alloc]init];
    
    XCTAssertFalse([sut isAValidLetterTitle:@"Lorem fistrum a gramenawer llevame al sircoo no te digo trigo por no llamarte Rodrigor pupita qué dise usteer fistro amatomaa. Quietooor amatomaa por la gloria de mi madre mamaar ese hombree diodeno va usté muy cargadoo tiene musho peligro quietooor. Tiene musho peligro a peich la caidita ese hombree ese hombree condemor ese pedazo de benemeritaar. Diodeno pecador ese que llega de la pradera condemor de la pradera caballo blanco caballo negroorl condemor. A gramenawer de la pradera ese pedazo de la caidita ese que llega. A gramenawer te voy a borrar el cerito al ataquerl ahorarr hasta luego Lucas de la pradera no puedor"], @"Title can't be +100 length");
    
    
    XCTAssertFalse([sut isAValidLetterTitle:@""], @"Title can't be empty");
    
    XCTAssertFalse([sut isAValidLetterTitle:@"      "], @"Title can't be only whiteSpaces");

    XCTAssertTrue([sut isAValidLetterTitle:@"Hola que tal estas"], @"Normal title is correct");

}

- (void) testIsAValidLetterContent{
    MSLetterValidator *sut = [[MSLetterValidator alloc]init];
    
    XCTAssertTrue([sut isAValidLetterContent:@"Lorem fistrum a gramenawer llevame al sircoo no te digo trigo por no llamarte Rodrigor pupita qué dise usteer fistro amatomaa. Quietooor amatomaa por la gloria de mi madre mamaar ese hombree diodeno va usté muy cargadoo tiene musho peligro quietooor. Tiene musho peligro a peich la caidita ese hombree ese hombree condemor ese pedazo de benemeritaar. Diodeno pecador ese que llega de la pradera condemor de la pradera caballo blanco caballo negroorl condemor. A gramenawer de la pradera ese pedazo de la caidita ese que llega. A gramenawer te voy a borrar el cerito al ataquerl ahorarr hasta luego Lucas de la pradera no puedor"], @"Content can be +100 length");
    
    
    XCTAssertFalse([sut isAValidLetterContent:@""], @"Content can't be empty");
    
    XCTAssertFalse([sut isAValidLetterContent:@"         "], @"Content can't be only whiteSpaces");
    
    
}

@end
