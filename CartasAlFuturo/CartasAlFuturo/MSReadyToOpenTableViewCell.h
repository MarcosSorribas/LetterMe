//
//  MSReadyToOpenTableViewCell.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Letter.h"
@interface MSReadyToOpenTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *blackBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLetterLabel;

@end
