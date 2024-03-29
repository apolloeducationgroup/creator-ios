//
//  SetVariableTask.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTask.h"

@interface SetVariableTask : DelugeTask

@property (nonatomic,retain) NSString *formName;
@property (nonatomic,retain) NSString *fieldName;
@property (nonatomic,retain) id fieldValue;

@property (nonatomic,assign) int rowNumber_Subform;

@end
