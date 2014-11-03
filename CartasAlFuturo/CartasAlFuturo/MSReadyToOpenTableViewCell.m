//
//  MSReadyToOpenTableViewCell.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSReadyToOpenTableViewCell.h"

@interface MSReadyToOpenTableViewCell ()
@end

@implementation MSReadyToOpenTableViewCell

- (void)animate{
    [self.titleLetterLabel.layer removeAllAnimations];
    CGFloat finalAlpha = 0.0;
    if (self.titleLetterLabel.alpha == 0) {
        finalAlpha = 1.0;
    }
    [UIView animateWithDuration:0.9
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationCurveEaseIn
                     animations:^(void){
                         [self.titleLetterLabel setAlpha:finalAlpha];
                         [self setNeedsLayout];
                     }
                     completion:^(BOOL finished){
                     }];
}


@end
