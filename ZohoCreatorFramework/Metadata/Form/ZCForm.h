//
//  ZCForm.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCComponent.h"
#import "ZCField.h"
#import "ZCFieldList.h"
#import "OpenUrlTask.h"
@class ZCApplication,ZCButton;


enum UPCOMING_FIELDS {
    
    UPCOMING_CRM = 1,
    UPCOMING_PAYMENT=2,
    UPCOMING_NONE = -1,
};


@interface ZCForm : ZCComponent <NSCopying> {
    
 
}

@property BOOL hasOnLoad;
@property BOOL hasEditOnLoad;
@property BOOL isStateful;
@property (nonatomic,retain) ZCApplication *application;
@property (nonatomic,retain) NSMutableArray *fields;
@property (nonatomic,retain) NSMutableArray *buttons;
@property (nonatomic,retain) NSString *successMessage;
@property (nonatomic,retain) NSString *dateFormat;
@property (nonatomic,retain) NSMutableArray *errorList;
@property BOOL hasError;

@property BOOL isNotSupported;

//@property (nonatomic,retain)NSDictionary *nextUrl;
@property (nonatomic,retain) OpenUrlTask *nextUrl;
- (ZCForm*) initZCForm;
- (void) addZCField : (ZCField*) field;
- (ZCField*) getFieldByName:(NSString *)fieldLinkName;
- (void) addZCButton : (ZCButton*) button;
- (void) executeOnLoad;
- (NSArray*) getFileUploadFields;
- (NSArray*) getImageFields;
- (NSArray*) getFieldsByType : (NSInteger) fieldType;
- (NSInteger) hasUpComingField;

@end
