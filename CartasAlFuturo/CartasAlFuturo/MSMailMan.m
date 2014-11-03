//
//  MSMailMan.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 17/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "MSMailMan.h"
#import "Letter+myAPI.h"

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
        [MSMailMan checkLettersPreparedAndUpdateThemInContext:document];
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"letter_received_alertView_title", nil) message:NSLocalizedString(@"letter_received_alertView_description", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"letter_received_alertView_accept_button", nil) otherButtonTitles:nil];
        [alertView show];
    }
}

@end