//
//  ZCExpection.h
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 02/01/14.
//  Copyright (c) 2014 mathankumar vv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCException : NSException
@property (nonatomic,strong ) NSString * inClassName;
@property (nonatomic,strong) NSException *exception;
-(id)initWithException:(NSException *)exeption inClass:(NSString *)class;
@end
