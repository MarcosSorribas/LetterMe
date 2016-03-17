//
//  MSCellDrawerProtocol.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSLetterItemProtocol;

@protocol MSCellDrawerProtocol <NSObject>

-(UITableViewCell*)cellForTableView:(UITableView*)tableView atIndexPath:(NSIndexPath*)indexPath;
-(void)drawCell:(UITableViewCell *)cell withItem:(id<MSLetterItemProtocol>)item;

@end
