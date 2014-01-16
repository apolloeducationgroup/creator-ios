//
//  ZCForm.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCForm.h"

@implementation ZCForm

@synthesize fields=_fields,application=_application,hasEditOnLoad=_hasEditOnLoad,hasOnLoad=_hasOnLoad,isStateful=_isStateful,buttons=_buttons,successMessage=_successMessage,dateFormat=_dateFormat,nextUrl=_nextUrl,isNotSupported=_isNotSupported,exceptionOccuredInFetching=_exceptionOccuredInFetching;

- (ZCForm*) initZCForm  {
    
    self = [super init];
    if(self)  {
        self->_fields = [[NSMutableArray alloc] init];
        self->_buttons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addZCField:(ZCField *)field {
    
    [_fields addObject:field];
}

- (void) addZCButton : (ZCButton*) button {
    
    [_buttons addObject:button];
}

- (ZCField*) getFieldByName:(NSString *)fieldLinkName {
    
    for(NSInteger index=0;index<[_fields count];index++) {
        ZCField *field = [_fields objectAtIndex:index];
        if([[field fieldName] isEqualToString:fieldLinkName]) {
            return field;
        }
    }
    return nil;
}

- (NSArray*) getFieldsByType : (NSInteger) fieldType {
    
    NSMutableArray *returnList = [[NSMutableArray alloc] init];
    for(NSInteger index=0;index<[_fields count];index++) {
        ZCField *field = [_fields objectAtIndex:index];
        if([field fieldType] == fieldType) {
            [returnList addObject:field];
        }
    }
    return returnList;
}

- (NSArray*) getImageFields {
    
    NSMutableArray *imageFields = [[NSMutableArray alloc] init];
    for(NSInteger index=0;index<[_fields count];index++) {
        ZCField *field = [_fields objectAtIndex:index];
        if([field fieldType] == [ZCFieldList ZCImage]) {
            [imageFields addObject:field];
        }
    }
    return imageFields;
}

- (NSArray*) getFileUploadFields {
    
    NSMutableArray *imageFields = [[NSMutableArray alloc] init];
    for(NSInteger index=0;index<[_fields count];index++) {
        ZCField *field = [_fields objectAtIndex:index];
        if([field fieldType] == [ZCFieldList ZCFileupload]) {
            [imageFields addObject:field];
        }
    }
    return imageFields;
}

- (NSInteger) hasUpComingField {
    
    for(NSInteger index=0;index<[_fields count];index++) {
        ZCField *_field = [_fields objectAtIndex:index];
        //NSLog@"Field typeeeeeeeeeeeeeee %d",[_field fieldType]);
        if([_field fieldType] == [ZCFieldList ZCCrm]) {
            //NSLog@"returning field type  CRM");
            return UPCOMING_CRM;
        }
        else if([_field fieldType] == [ZCFieldList ZCPayment]) {
            return UPCOMING_PAYMENT;
        }
    }
    return UPCOMING_NONE;
}


- (id) copyWithZone:(NSZone *)zone {
    ZCForm *copyForm = [[ZCForm alloc] initZCForm];
    return copyForm;
}

- (void) executeOnLoad {
    
    //    FormOnLoad *load = [[FormOnLoad alloc] initFormOnLoad:_application :self];
    //    [load execute];
}

@end
