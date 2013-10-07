//
//  ZCRecordError.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 29/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCRecordError.h"

@implementation ZCRecordError

@synthesize errorCode=_errorCode,errorMessage=_errorMessage,fieldErrorList=_fieldErrorList,subFormFieldErrorList=_subFormFieldErrorList,generalErrorList=_generalErrorList;

- (ZCRecordError*) init {

    self = [super init];
    if(self) {
        self->_errorMessage = @"";
        self->_errorCode = @"";
        self->_fieldErrorList = [[NSMutableArray alloc] init];
        self->_subFormFieldErrorList=[[NSMutableArray alloc]init];
        self->_generalErrorList=[[NSMutableArray alloc]init];

    }
    return self;
}

- (ZCRecordError*) initZCRecordError : (NSString*) errCode : (NSString*) errMessage {

    self = [super init];
    if(self) {
        self->_errorMessage = errMessage;
        self->_errorCode = errCode;
        self->_fieldErrorList = [[NSMutableArray alloc] init];
        self->_subFormFieldErrorList=[[NSMutableArray alloc]init];
        self->_generalErrorList=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void) addFieldError : (ZCFieldError*) fieldError {
 
    [_fieldErrorList addObject:fieldError];
    
}
-(void) addSubFormFieldFieldError:(ZCSubFormFieldError *)subformFieldError
{

    [_subFormFieldErrorList addObject:subformFieldError];
    ////// //NSLog(@"subform errorlist  %@",_subFormFieldErrorList);
    
}
@end
