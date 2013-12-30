//
//  ZCViewAction.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 01/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger ZCViewActionType;

enum
{
    ZCViewActionTypeRecord=1,
    ZCViewActionTypeHeader=2,
    ZCViewActionTypeMenu=3,
};

@interface ZCViewAction : NSObject

@property (nonatomic,retain) NSString *actionName;
@property (nonatomic,retain) NSString *functionName;
@property ZCViewActionType actionType;

@end
