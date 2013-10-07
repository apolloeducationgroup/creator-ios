//
//  ZCButton.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 25/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger ZCButtonType;

enum ZCButtonType {
    
    ZCButtonTypeSubmit=1,
    ZCButtonTypeReset=2,
    ZCButtonTypeCustom=3,
    
};

@interface ZCButton : NSObject

@property (nonatomic,retain) NSString *buttonName;
@property (nonatomic,retain) NSString *buttonDisplayName;
@property ZCButtonType buttonType;
@property NSInteger sequence;
@property NSInteger buttonActionType;

@end
