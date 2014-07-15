//
//  MSOpenedLettersTableViewController.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 15/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface MSOpenedLettersTableViewController : CoreDataTableViewController
@property (nonatomic,strong,readwrite) UIManagedDocument *manageDocument;
@end
