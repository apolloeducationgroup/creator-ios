//
//  CustomActionResponse.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 23/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTasks.h"

@interface CustomActionResponse : NSObject

@property (nonatomic,retain) NSString *executionType;
@property (nonatomic,retain) NSString *successMessage;
@property (nonatomic,retain) NSMutableArray *successRecordList;
@property (nonatomic,retain) NSMutableArray *failureRecordList;
@property (nonatomic,retain) DelugeTasks *delugeTasks;

@end
