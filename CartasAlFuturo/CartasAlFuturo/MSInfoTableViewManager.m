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
    _infoTableView.contentInset = UIEdgeInsetsMake(56, 0, 0, 0);
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
            cellHeight = 80;
            break;
        default:
            cellHeight = 90;
            break;
    }
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:FONT_HELVETICA_NEUE_LIGHT size:17];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textColor = [UIColor whiteColor];

    switch (indexPath.row) {
        case addLetterInfoCell:
            cell.imageView.image = [UIImage imageNamed:@"addButton"];
            cell.textLabel.text = @"Crea una carta para enviarla al futuro.";
            break;
        case PendingLettersInfoCell:
            cell.imageView.image = [UIImage imageNamed:@"PendientesImage"];
            cell.textLabel.text = @"Listado de cartas que aún no puedes abrir.";
            break;
        case ReadLettersInfoCell:
            cell.imageView.image = [UIImage imageNamed:@"LeidasImage"];
            cell.textLabel.text = @"Listado de cartas ya abiertas que puedes volver a leer.";
            cell.textLabel.numberOfLines = 3;
            break;
        case authorInfoCell:
        {
            cell.textLabel.font = [UIFont fontWithName:FONT_HELVETICA_NEUE_LIGHT_ITALIC size:17];
            cell.textLabel.text = @"Aplicación creada y liberada en GitHub por: Marcos Sorribas López.";
        }
            break;
    }
    return cell;
}

@end
