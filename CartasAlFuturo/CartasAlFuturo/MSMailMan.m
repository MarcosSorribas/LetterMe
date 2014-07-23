//
//  MSMailMan.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 17/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSMailMan.h"
#import "Letter+myAPI.h"
#import "MSPendingTableViewController.h"

@implementation MSMailMan

+(void)checkLettersPreparedAndUpdateThemInContext:(UIManagedDocument*)document{
    NSArray *letters = [Letter checkReadyToOpenLettersInContext:document.managedObjectContext];
    for (Letter *letter in letters) {
        [document.managedObjectContext.undoManager beginUndoGrouping];
        letter.letterStatus = [NSNumber numberWithInt:MSReadyToOpen];
        [document.managedObjectContext.undoManager endUndoGrouping];
    }
}

-(void)showAlertViewIfLettersArePrepared:(UIManagedDocument*)document{
     NSArray *letters = [Letter checkReadyToOpenLettersInContext:document.managedObjectContext];
    if (letters.count) {
       //Crear AlertView
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"¡Te ha llegado una carta!" message:@"Una de tus cartas pendientes ya se puede abrir. ¡No esperes más y leela!" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [alertView show];
    }
    [MSMailMan checkLettersPreparedAndUpdateThemInContext:document];
}

@end