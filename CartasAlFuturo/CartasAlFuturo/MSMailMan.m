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
    //Fetch de las cartas ya listas
    
    NSArray *letters = [Letter checkReadyToOpenLettersInContext:document.managedObjectContext];
    
    //Cambiar su status a readyToOpen
    
    for (Letter *letter in letters) {
        [document.managedObjectContext.undoManager beginUndoGrouping];
        letter.letterStatus = [NSNumber numberWithInt:MSReadyToOpen];
        [document.managedObjectContext.undoManager endUndoGrouping];
    }

    if (letters.count != 0) {
        //Avisar al usuario
    }
}
@end