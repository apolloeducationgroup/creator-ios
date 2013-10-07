//
//  OpenUrlTask.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 06/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTask.h"

@interface OpenUrlTask : DelugeTask

@property (nonatomic,retain) NSString *urlString;
@property (nonatomic,retain) NSString *windowType;
@property (nonatomic,retain) NSString *windowParameters;

@end