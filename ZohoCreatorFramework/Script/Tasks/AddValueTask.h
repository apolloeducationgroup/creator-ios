//
//  AddValueTask.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTask.h"

@interface AddValueTask : DelugeTask;

@property (nonatomic,retain) NSString *fieldName;
@property (nonatomic,retain) NSMutableArray *fieldValues;
@property (nonatomic,retain) NSString *formName;

@end