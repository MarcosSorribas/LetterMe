//
//  MSInfoTableViewManager.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 31/10/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSInfoTableViewManager.h"


typedef enum : NSUInteger {
    addLetterInfoCell,
    PendingLettersInfoCell,
    ReadLettersInfoCell,
    authorInfoCell,
} InfoCellType;

@implementation MSInfoTableViewManager


-(void)setInfoTableView:(UITableView *)infoTableView{
    _infoTableView = infoTableView;
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _infoTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight;
    switch (indexPath.row) {
        case authorInfoCell:
            cellHeight = 40;
            break;
        default:
            cellHeight = 80;
            break;
    }
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    
    switch (indexPath.row) {
        case addLetterInfoCell:
            cell.selectionStyle = UITableViewCellStyleDefault;
            cell.imageView.image = [UIImage imageNamed:@"closeButton"];
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
            cell.imageView.clipsToBounds = YES;
            cell.textLabel.text = @"Pulsa para crear carta";
            cell.textLabel.textColor = [UIColor whiteColor];
            break;
        case PendingLettersInfoCell:
            cell.selectionStyle = UITableViewCellStyleDefault;
            cell.imageView.image = [UIImage imageNamed:@"closeButton"];
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
            cell.imageView.clipsToBounds = YES;
            cell.textLabel.text = @"Pulsa para crear carta";
            cell.textLabel.textColor = [UIColor whiteColor];
            break;
        case ReadLettersInfoCell:
            cell.selectionStyle = UITableViewCellStyleDefault;
            cell.imageView.image = [UIImage imageNamed:@"closeButton"];
            cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/2;
            cell.imageView.clipsToBounds = YES;
            cell.textLabel.text = @"Pulsa para crear carta";
            cell.textLabel.textColor = [UIColor whiteColor];
            break;
        case authorInfoCell:
            cell.selectionStyle = UITableViewCellStyleDefault;
            cell.textLabel.text = @"Pulsa para crear carta";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        default:
            cell = nil;
            break;
    }
    return cell;
}

@end
