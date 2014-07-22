//
//  MSOpenedTableViewCell.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 15/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Letter.h"
@interface MSOpenedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sendDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
