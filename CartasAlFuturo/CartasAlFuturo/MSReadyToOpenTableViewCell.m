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
    [self.titleLetterLabel setAlpha:1.0];
        [UIView animateWithDuration:0.9
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                         animations:^(void){
                             [self.titleLetterLabel setAlpha:0.0];
                             [self setNeedsLayout];
                         }
                         completion:^(BOOL finished){
                                                      }];
        
}


@end
