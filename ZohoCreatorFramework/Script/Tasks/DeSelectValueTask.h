//
//  DeSelectValueTask.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 11/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "DelugeTask.h"

@interface DeSelectValueTask : DelugeTask

@property (nonatomic,retain) NSString *formName;
@property (nonatomic,retain) NSString *fieldName;
@property (nonatomic,retain) NSMutableArray *deSelectValues;

@end
