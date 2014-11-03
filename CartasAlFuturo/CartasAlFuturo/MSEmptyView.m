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

-(void)awakeFromNib{
    NSMutableAttributedString *attString = [NSLocalizedString(@"create_first_letter_notice", nil) addKernStyle:@0.3].mutableCopy;
    NSDictionary *attPlus = @{NSFontAttributeName:[UIFont fontWithName:FONT_HELVETICA_NEUE_THIN size:45.0],NSForegroundColorAttributeName:MAIN_COLOR};
    
    //Only + character.
    [attString addAttributes:attPlus range:NSMakeRange(6, 1)];
    
    self.createLetterLabel.attributedText = attString;
}

@end
