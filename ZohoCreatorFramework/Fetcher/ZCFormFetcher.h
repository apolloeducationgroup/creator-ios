//
//  ZCFormFetcher.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 03/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionChecker.h"
#import "ZCForm.h"
#import "URLConstructor.h"
#import "URLConnector.h"
#import "FormParser.h"
#import "ZCComponent.h"
#import "ArchiveUtil.h"
#import "EncodeObject.h"
#import "DecodeObject.h"
#import "ZOHOCreator.h"

@class ZCForm;

@interface ZCFormFetcher : NSObject  {
    
@private
    NSString *_appLinkName;
    NSString *_appOwner;
    ZCComponent *_component;
    NSString *_editViewLinkName;
    NSString *_viewLinkName;
    NSString *_recordLinkID;
    BOOL _isSubform;
    NSString *   mainAppLinkname_forSubform;
    
    NSString *    mainFormLinkname_forSubform;
    
    NSString *    subformFieldLinkname_forSubform;
    
}

@property (nonatomic,retain) ZCForm *zcForm;

- (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (ZCComponent*) component appOwner : (NSString *) appOwner;
+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName appOwner : (NSString *) appOwner;
+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName recordLinkID : (NSString*) _recLinkID appOwner : (NSString *) appOwner;
- (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (ZCComponent*) component recordLinkID : (NSString*) recordLinkID appOwner : (NSString *) appOwner;
+ (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (NSString*) formLinkName recordLinkID : (NSString*) _recLinkID appOwner : (NSString *) appOwner;
- (ZCFormFetcher*) initFormFetcher : (NSString*) appLinkName : (ZCComponent*) component viewLinkName : (NSString*) viewLinkName recordLinkID : (NSString*) recordLinkID appOwner : (NSString *) appOwner;
+(ZCFormFetcher *) initSubFormFetcher:(NSString *)appLinkName formLinkname:(NSString *)formLinkName subformmode:(BOOL)subformMode appOwner:(NSString *)appOwner  mainAppLinkname:(NSString *)mainAppLinkname mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname;

@end
