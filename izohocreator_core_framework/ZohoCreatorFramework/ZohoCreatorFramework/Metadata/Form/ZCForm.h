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

@class ZCApplication,ZCButton;

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

- (ZCForm*) initZCForm;
- (void) addZCField : (ZCField*) field;
- (ZCField*) getFieldByName:(NSString *)fieldLinkName;
- (void) addZCButton : (ZCButton*) button;
- (void) executeOnLoad;
- (NSArray*) getFileUploadFields;
- (NSArray*) getImageFields;
- (NSArray*) getFieldsByType : (NSInteger) fieldType;

@end
