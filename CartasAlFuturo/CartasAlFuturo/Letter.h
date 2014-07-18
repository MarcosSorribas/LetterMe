//
//  Letter.h
//  CartasAlFuturo
//
//  Created by Marcos Sorribas Lopez on 18/07/14.
//  Copyright (c) 2014 MarcosSorribas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Letter : NSManagedObject

@property (nonatomic, retain) NSString * letterContent;
@property (nonatomic, retain) NSDate * letterOpenDate;
@property (nonatomic, retain) NSDate * letterSendDate;
@property (nonatomic, retain) NSNumber * letterStatus;
@property (nonatomic, retain) NSString * letterTitle;

@end
