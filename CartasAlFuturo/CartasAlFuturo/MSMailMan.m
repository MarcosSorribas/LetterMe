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
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Carta preparada" message:@"Tienes una carta lista para ser abierta" delegate:nil cancelButtonTitle:@"Cancelar" otherButtonTitles:nil];
        [alertView show];
    }
    [MSMailMan checkLettersPreparedAndUpdateThemInContext:document];
}
@end