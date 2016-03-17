//
//  UIView+Animations.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 24/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "UIView+Animations.h"

@implementation UIView (Animations)
-(void)shakeAnimate{
    CAKeyframeAnimation * anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
    anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f) ], [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f) ] ] ;
    anim.autoreverses = YES ;
    anim.repeatCount = 2.0f ;
    anim.duration = 0.07f ;
    [self.layer addAnimation:anim forKey:nil ] ;
}
@end
