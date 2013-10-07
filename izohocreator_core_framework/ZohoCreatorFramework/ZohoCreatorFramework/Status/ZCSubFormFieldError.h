//
//  ZCSubFormFieldError.h
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 28/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCFieldError.h"
@class ZCComponent;
@interface ZCSubFormFieldError : ZCFieldError

@property (nonatomic,retain) NSString *subFormLinkname;
@property (nonatomic,assign) int recordRowinSubform;
@property (nonatomic,retain) ZCComponent * relatedComponent;
@end
