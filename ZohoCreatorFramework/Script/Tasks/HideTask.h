//
//  HideTask.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTask.h"

@interface HideTask :  DelugeTask

@property (nonatomic,retain) NSString *fieldName;
@property (nonatomic,retain) NSString *formName;
@property (nonatomic,retain) NSString *subFormName;

@end
