//
//  MSLetterValidator.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSLetterValidator.h"
#import "Letter+myAPI.h"

@implementation MSLetterValidator

#pragma mark -
#pragma mark - Contantes

static NSInteger const maxCharactersTitle = 50;
static NSInteger const minCharactersTitle = 1;
static NSInteger const secondsDay = 55*50*24;

#pragma mark -
#pragma mark - Validator methods


-(BOOL)isAValidLetter:(Letter*)letter{
    if (![self isAValidLetterTitle:letter.letterTitle]){
        return NO;
    }
    if (![self isAValidLetterOpenDate:letter.letterOpenDate]) {
        return NO;
    }
    if (![self isAValidLetterContent:letter.letterContent]) {
        return NO;
    }
    if (![self isAValidLetterSendDate:letter.letterSendDate]) {
        return NO;
    }
    return YES;
}

-(BOOL)isAValidLetterTitle:(NSString*)letterTitle{
    if (letterTitle.length > maxCharactersTitle || letterTitle.length < minCharactersTitle) {
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
    if (!letterOpenDate) {
        return NO;
    }
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:secondsDay];
    if ([now compare:letterOpenDate] == NSOrderedDescending) {
        return NO;
    }
    return YES;
}

-(BOOL)isAValidLetterContent:(NSString*)letterContent{
    if (letterContent.length < minCharactersTitle) {
        return NO;
    }
    NSString *aux = letterContent;
    aux = [aux stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (aux.length == 0) {
        return NO;
    }
    return YES;
}

-(BOOL)isAValidLetterSendDate:(NSDate*)date{
    if (date == nil) {
        return NO;
    }
    return YES;
}
@end