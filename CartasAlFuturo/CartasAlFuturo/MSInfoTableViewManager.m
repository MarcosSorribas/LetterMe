//
//  MSInfoTableViewManager.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 31/10/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSInfoTableViewManager.h"

@implementation MSInfoTableViewManager



-(void)setInfoTableView:(UITableView *)infoTableView{
    _infoTableView = infoTableView;
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    
    //regiter cells

}
@end
