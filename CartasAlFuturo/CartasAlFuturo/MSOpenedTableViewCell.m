//
//  MSOpenedTableViewCell.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 15/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSOpenedTableViewCell.h"

@interface MSOpenedTableViewCell ()

@end

@implementation MSOpenedTableViewCell

-(void)awakeFromNib{
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.sendDateLabel.adjustsFontSizeToFitWidth = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
@end
