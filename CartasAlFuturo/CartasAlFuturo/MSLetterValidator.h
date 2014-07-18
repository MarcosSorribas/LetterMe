//
//  MSLetterValidator.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Letter.h"
@interface MSLetterValidator : NSObject
-(BOOL)isAValidLetter:(Letter*)letter;
-(BOOL)isAValidLetterTitle:(NSString*)letterTitle;
-(BOOL)isAValidLetterOpenDate:(NSDate*)letterOpenDate;
-(BOOL)isAValidLetterContent:(NSString*)letterContent;
@end
