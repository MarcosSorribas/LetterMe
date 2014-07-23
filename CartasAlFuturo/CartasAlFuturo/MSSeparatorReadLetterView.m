//
//  MSSeparatorReadLetterView.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 24/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSSeparatorReadLetterView.h"

@implementation MSSeparatorReadLetterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)awakeFromNib{
    [self drawDottedLineSeparator];
}


-(void)drawDottedLineSeparator{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithWhite:1.000 alpha:0.600] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width,0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[self layer] addSublayer:shapeLayer];
}

@end
