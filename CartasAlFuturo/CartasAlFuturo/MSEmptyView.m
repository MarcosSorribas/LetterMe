//
//  MSEmptyView.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 24/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSEmptyView.h"
#import "NSString+Styles.h"

@interface MSEmptyView ()
@property (weak, nonatomic) IBOutlet UILabel *createLetterLabel;

@end

@implementation MSEmptyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    NSMutableAttributedString *attString = [self.createLetterLabel.text addKernStyle:@0.3].mutableCopy;
    
    NSDictionary *attPlus = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:45.0],NSForegroundColorAttributeName:[UIColor colorWithRed:0.845 green:0.708 blue:0.671 alpha:1.000]};
    
    
    [attString addAttributes:attPlus range:NSMakeRange(6, 1)];
    
    self.createLetterLabel.attributedText = attString;
}
@end
