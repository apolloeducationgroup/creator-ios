//
//  OpenUrlTask.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 06/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTask.h"
@class ZCApplication;
@interface OpenUrlTask : DelugeTask

@property (nonatomic,retain) NSString *urlString;
@property (nonatomic,retain) NSString *windowType;
@property (nonatomic,retain) NSString *windowParameters;
@property (nonatomic,retain) NSString *componentType;
@property (nonatomic,retain) NSString *urlParameters;
@property (nonatomic,retain) ZCApplication *application;
@end