//
//  Letter+DrawerItem.m
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 19/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import "Letter+DrawerItem.h"
#import "NSNumber+MSStatusLetter.h"

#import "MSCellDrawerProtocol.h"
#import "MSLetterItemProtocol.h"


#import "MSPendingLetterDrawer.h"
#import "MSReadyToOpenLetterDrawer.h"
#import "MSOpenedLetterDrawer.h"

@implementation Letter (DrawerItem)

-(id<MSCellDrawerProtocol>)cellDrawer{
    switch ([self.letterStatus statusValue]) {
        case MSPending:
            return [[MSPendingLetterDrawer alloc]init];
            break;
        case MSReadyToOpen:
            return [[MSReadyToOpenLetterDrawer alloc]init];
            break;
        case MSRead:
            return [[MSOpenedLetterDrawer alloc]init];
            break;
        default:
            break;
    }
    return nil;
}
@end