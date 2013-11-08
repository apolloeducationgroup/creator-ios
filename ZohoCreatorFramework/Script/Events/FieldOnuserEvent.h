//
//  FieldOnuserEvent.h
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 12/09/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FieldOnUser.h"
#import "SubFormOnUser.h"
@interface FieldOnuserEvent : NSObject
{
    SubFormOnUser * subformOnuser;
    FieldOnUser * fieldonuser;
    BOOL _subform;
}
//- (FieldOnuserEvent*) initFieldOnUserEventWithFieldAppname: (NSString*) _appLocal fieldFormName: (NSString*) _formLocal fieldName:(NSString*) _fieldLocal parmString:(NSString*) paramString delegate:(id) delegate  fieldBElongToSubForm:(BOOL)_subform mainAppLinkname:(NSString *)mainAppLinkname mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname appOwner:(NSString *)appowner;
- (FieldOnuserEvent*) initFieldOnUserEventWithFieldAppname: (NSString*) _appLocal fieldFormName: (NSString*) _formLocal fieldName:(NSString*) _fieldLocal parmString:(NSString*) paramString delegate:(id) delegate rowNumberincaseOFsubofrmField:(int)rownum subformFieldName:(NSString *)subformFieldname appOwner:(NSString *)appowner;

- (DelugeTasks*) execute;
@end
