//
//  ZCRecordError.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 29/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCRecordError.h"
#import "ZCSubFormFieldError.h"
@implementation ZCRecordError

@synthesize errorCode=_errorCode,errorMessage=_errorMessage,fieldErrorList=_fieldErrorList,subFormFieldErrorList=_subFormFieldErrorList,subFormFieldErrorsDictionary=_subFormFieldErrorsDictionary,generalErrorList=_generalErrorList;

- (ZCRecordError*) init {

    self = [super init];
    if(self) {
        self->_errorMessage = @"";
        self->_errorCode = @"";
        self->_fieldErrorList = [[NSMutableArray alloc] init];
        self->_subFormFieldErrorList=[[NSMutableArray alloc]init];
        self->_generalErrorList=[[NSMutableArray alloc]init];
        self->_subFormFieldErrorsDictionary=[[NSMutableDictionary alloc]init];

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
        self->_subFormFieldErrorsDictionary=[[NSMutableDictionary alloc]init];

    }
    return self;
}

- (void) addFieldError : (ZCFieldError*) fieldError {
 
    [_fieldErrorList addObject:fieldError];
    
}
-(void) addSubFormFieldFieldError:(ZCSubFormFieldError *)subformFieldError
{

    [_subFormFieldErrorList addObject:subformFieldError];
    
    NSString * rowNum=[NSString stringWithFormat:@"%i",[subformFieldError recordRowinSubform]];
    NSString * fieldSubFormname=[subformFieldError subFormLinkname];
    
    
    NSMutableDictionary * errorDictInField=[_subFormFieldErrorsDictionary objectForKey:fieldSubFormname];

    if(errorDictInField != nil)
    {
        if([errorDictInField objectForKey:rowNum])

        {
        
            [ [errorDictInField objectForKey:rowNum]addObject:subformFieldError];
        
        }
        
        
        else
        {
            [errorDictInField setObject:[NSMutableArray arrayWithObject:subformFieldError] forKey:rowNum];

            
        }

        [_subFormFieldErrorsDictionary setObject:errorDictInField forKey:fieldSubFormname];

    }
    else
    {
        
        errorDictInField =[[NSMutableDictionary alloc]init];
//        if([errorDictInField objectForKey:rowNum])
//        {
//            
//            [ [errorDictInField objectForKey:rowNum]addObject:subformFieldError];
//            
//        }
//        else
//        {
//            
            [errorDictInField setObject:[NSMutableArray arrayWithObject:subformFieldError] forKey:rowNum];
//        }
        
        [_subFormFieldErrorsDictionary setObject:errorDictInField forKey:fieldSubFormname];

    
    }

    
    
//    if([_subFormFieldErrorsDictionary objectForKey:rowNum])
//    {
//    
//       [ [_subFormFieldErrorsDictionary objectForKey:rowNum]addObject:subformFieldError];
//    
//    }
//    else
//    {
//    
//        [_subFormFieldErrorsDictionary setObject:[NSMutableArray arrayWithObject:subformFieldError] forKey:rowNum];
//    }
    ////// //NSLog(@"subform errorlist  %@",_subFormFieldErrorList);
    
}
@end
