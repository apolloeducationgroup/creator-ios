//
//  MetaDataUtil.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 28/09/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCForm,ZCComponent;

@interface MetaDataUtil : NSObject

+ (ZCForm*) mergeFormWithComponent : (ZCForm*) formObject : (ZCComponent*) componentObject;

@end
