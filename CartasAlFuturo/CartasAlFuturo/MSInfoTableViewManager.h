//
//  MSInfoTableViewManager.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 31/10/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSInfoTableViewManager : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *infoTableView;

@end
