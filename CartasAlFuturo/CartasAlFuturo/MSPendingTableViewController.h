//
//  MSPendingTableViewController.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 14/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface MSPendingTableViewController : CoreDataTableViewController
@property (nonatomic,strong,readwrite) UIManagedDocument *manageDocument;
@end
