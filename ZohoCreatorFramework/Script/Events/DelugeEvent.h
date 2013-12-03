//
//  DelugeEvent.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 08/02/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConnector.h"
#import "ScriptParser.h"
#import "CustomActionParser.h"
#import "ZCForm.h"
#import "ZCRecord.h"
#import "CustomActionResponse.h"
#import "ScriptJSONParser.h"
enum ZCRecType { //for onload and onedit "recType"
    
    FORM_ALONE =1,
    VIEW_ADD_FORM =2,
    VIEW_EDIT_FORM =3,
    FORM_LOOKUP_ADD_FORM =5
    
};
@class ZCApplication,ZCForm;

@protocol DelugeDelegate <NSObject>



@required -(void) showAlert : (NSString*) message;
@required -(void) enableField : (NSString*) formName : (NSString*) fieldName subformName:(NSString *)subformname;
@required -(void) disableField: (NSString*) formName : (NSString*) fieldName subformName:(NSString *)subformname;
@required -(void) showField: (NSString*) formName : (NSString*) fieldName subformName:(NSString *)subformname;
@required -(void) hideField: (NSString*) formName : (NSString*) fieldName subformName:(NSString *)subformname;
@required -(void) addValues : (NSString*) formName : (NSString*) fieldName : (NSMutableArray*) valueList rowNumberForSubform:(int)rownumber subformName:(NSString *)subformname;
@required -(void) clearValue : (NSString*) formName : (NSString*) fieldName rowNumberForSubform:(int)rownumber subformName:(NSString *)subformname;
@required -(void) noScript : (NSString*) message;
@required -(void) setFieldValue : (NSString*) formName  : (NSString*) fieldName : (id) fieldValue rowNumberForSubform:(int)rownumber subformName:(NSString *)subformname;
@required -(void) openUrl : (NSString*) urlString withWindowType : (NSString*) windowsType andParameter : (NSString*) parameter;
@required -(void) reloadForm : (NSString*) formName;
@required -(void) selectValue : (NSString*) formName withFieldName : (NSString*) fieldName andValues : (NSMutableArray*) selectValues rowNumberForSubform:(int)rownumber subformName:(NSString *)subformname;
@required -(void) selectAllValues : (NSString*) formName withFieldName : (NSString*) fieldName rowNumberForSubform:(int)rownumber subformName:(NSString *)subformname;
@required -(void) deSelectValue : (NSString*) formName withFieldName : (NSString*) fieldName andValues : (NSMutableArray*) selectValues rowNumberForSubform:(int)rownumber subformName:(NSString *)subformname;
@required -(void) deSelectAllValues : (NSString*) formName withFieldName : (NSString*) fieldName rowNumberForSubform:(int)rownumber subformName:(NSString *)subformname;

@end

@interface DelugeEvent : NSObject {
@private DelugeTasks *_delugeTasks;
    
}

@property (nonatomic,retain) NSString *delugeURL;
@property (nonatomic,retain) NSString *delugeParams;
@property (nonatomic,retain) ZCRecord *parameter;
@property (nonatomic,retain) id<DelugeDelegate> callerDelegate;

- (DelugeEvent*) initDelugeEvent : (ZCApplication*) _app withForm : (ZCForm*) _zcForm : (id) delegate;
- (DelugeEvent*) initDelugeEvent : (NSString*) appLinkName withFormLinkName : (NSString*) formLinkName;
- (DelugeTasks*)  execute;
- (CustomActionResponse*) executeCustomAction;


+ (NSString*) getParamXMLString : (ZCRecord*) _record : (NSString*) sharerdBy;
+ (NSString*) getParamStringByZCRecord  : (ZCRecord*) _record;
+ (NSString*) getParamStringByDict : (NSMutableDictionary*) _dictionary;
+ (NSString*) getParamString: (ZCRecord*) _zcRecord;

@end
