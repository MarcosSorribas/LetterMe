//
//  MSCustomTabBar.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 22/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSCustomTabBar.h"

@implementation MSCustomTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




-(void)awakeFromNib{    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:0.845 green:0.708 blue:0.671 alpha:1]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
