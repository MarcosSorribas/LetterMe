//
//  MSLetterValidator.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSLetterValidator.h"

@implementation MSLetterValidator

-(BOOL)isAValidLetter:(Letter*)letter{
    
    return YES;
}
-(BOOL)isAValidLetterTitle:(NSString*)letterTitle{
    if (letterTitle.length > 100 || letterTitle.length < 1) {
        return NO;
    }
    NSString *aux = letterTitle;
     aux = [aux stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (aux.length == 0) {
        return NO;
    }
    return YES;
}
-(BOOL)isAValidLetterOpenDate:(NSDate*)letterOpenDate{
    //Minimo un dia
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    if ([now compare:letterOpenDate] == NSOrderedDescending) {
        return NO;
    }
    return YES;
}
-(BOOL)isAValidLetterContent:(NSString*)letterContent{
    if (letterContent.length < 1) {
        return NO;
    }
    NSString *aux = letterContent;
    aux = [aux stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (aux.length == 0) {
        return NO;
    }
    return YES;
}

@end
