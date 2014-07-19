//
//  NSNumber+MSStatusLetter.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "NSNumber+MSStatusLetter.h"

@implementation NSNumber (MSStatusLetter)

-(MSStatusLetter)statusValue{
    if ([self integerValue] == MSPending) {
        return MSPending;
    }else if ([self integerValue] == MSReadyToOpen){
        return MSReadyToOpen;
    }else if ([self integerValue] == MSRead){
        return MSRead;
    }
    return MSUnknow;
}
@end
