//
//  ZCExpection.m
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 02/01/14.
//  Copyright (c) 2014 mathankumar vv. All rights reserved.
//

#import "ZCExpection.h"

@implementation ZCExpection
@synthesize inClassName=_inClassName,exception=_exception;
-(id)initWithException:(NSException *)exeption inClass:(NSString *)class
{
    self=[super init];
    if (self) {
        
        _exception=exeption;
        _inClassName=class;
    }

    return self;
}
@end
