//
//  ZCRecordError.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 29/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZCFieldError;
@class ZCSubFormFieldError;
@interface ZCRecordError : NSObject

@property (nonatomic,retain) NSString *errorCode;
@property (nonatomic,retain) NSString *errorMessage;
@property (nonatomic,retain) NSMutableArray *fieldErrorList;
@property (nonatomic,retain) NSMutableArray * subFormFieldErrorList;
@property (nonatomic,retain) NSMutableDictionary * subFormFieldErrorsDictionary;

@property (nonatomic,retain) NSMutableArray * generalErrorList;
- (ZCRecordError*) initZCRecordError : (NSString*) errorCode : (NSString*) errorMessage;
- (ZCRecordError*) init;
- (void) addFieldError : (ZCFieldError*) fieldError;
- (void) addSubFormFieldFieldError : (ZCSubFormFieldError*) subformFieldError;
@end
