//
//  NSDateTests.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+CustomizableDate.h"

@interface NSDateTests : XCTestCase

@end

@implementation NSDateTests

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

- (void)testCustomizableDateIsNotNil
{
    XCTAssertNotNil([NSDate dateWithYear:2014 month:5 day:28], @"Customizable date can't be NIL");
}
- (void) testCustomizbleDateIsCorrect{
    NSDate *hoy = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsHoy = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:hoy];
    
    NSDate *hoyConstruido = [NSDate dateWithYear:[componentsHoy year] month:[componentsHoy month] day:[componentsHoy day]];
    
    NSDateComponents *componentsHoyConstruido = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:hoyConstruido];
    
    XCTAssertTrue([componentsHoy second] == [componentsHoyConstruido second] , @"Both dates aren't the same");
    XCTAssertTrue([componentsHoy minute] == [componentsHoyConstruido minute] , @"Both dates aren't the same");
    XCTAssertTrue([componentsHoy hour] == [componentsHoyConstruido hour] , @"Both dates aren't the same");
    XCTAssertTrue([componentsHoy day] == [componentsHoyConstruido day] , @"Both dates aren't the same");
    XCTAssertTrue([componentsHoy month] == [componentsHoyConstruido month] , @"Both dates aren't the same");
    XCTAssertTrue([componentsHoy year] == [componentsHoyConstruido year] , @"Both dates aren't the same");
}


@end
