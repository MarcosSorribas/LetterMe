//
//  NSString+Styles.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 23/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "NSString+Styles.h"

@implementation NSString (Styles)
-(NSAttributedString*)addKernStyle:(NSNumber*)kern{
    return [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSKernAttributeName:kern}];
}
@end
