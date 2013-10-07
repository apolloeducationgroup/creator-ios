//
//  ZOHOCreator.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 27/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZOHOUser.h"
#import "ZCApplicationList.h"
#import "ZCApplicationFetcher.h"
#import "ZCSharedAppListFetcher.h"
#import "ZCAppListFetcher.h"
#import "ZCSectionFetcher.h"
#import "ZCWorkSpaceAppListFetcher.h"
#import "ZCAppsCategoryListFetcher.h"
#import "ZCAllAppsCategory.h"

@class ZOHOUser,ZCForm,ZCView,ZCApplication,ZCViewParam;

@interface ZOHOCreator : NSObject {
    
@private ZOHOUser *_zohoUser;
@private ZCApplicationList *_appList;
@private ZCAllAppsCategory *_sharedCategoryList;
@private NSMutableDictionary *_formContainer;
@private ZCApplication *_currentApp;
}

@property BOOL resultFromServer;

+ (ZOHOCreator*) getObject;
- (ZOHOCreator *) initZOHOCreator : (NSString*) userName : (NSString*) password;
- (ZOHOCreator*) initZOHOCreator : (ZOHOUser*) zohoUser;
- (ZCApplication*) getApplication : (NSString*) appLinkName;
- (ZCApplicationList*) getApplicationList;
- (ZCApplicationList*) getApplicationList : (BOOL) fromServer;
- (ZCApplicationList*) getSharedApplicationList;
- (ZCApplicationList*) getSharedApplicationList : (BOOL) fromServer;
- (ZCApplicationList*) getSharedApplicationList : (BOOL) fromServer GroupID:(NSString *)groupId;
- (ZCApplicationList*) getWorkSpaceApplicationList : (NSString *) workspaceowner;
- (ZCApplicationList*) getWorkSpaceApplicationList : (BOOL) fromServer workspaceowner:(NSString *) workspaceowner;
- (ZCAllAppsCategory*) getSharedCategoryList : (BOOL) fromServer;
- (ZCAllAppsCategory*) getSharedCategoryList;
- (ZCApplication*) lastAccessedApp;
- (ZOHOUser*) userObject;

+ (void) constructZOHOCreator : (ZOHOUser*) zohoUser;
+ (ZOHOUser*) login : (NSString*) userName : (NSString*) password;
+ (ZOHOUser*) userObject;
+ (NSArray*) getApplicationList;
+ (NSArray*) getSharedApplicationList;
+ (NSArray*) getSectionList : (NSString*) appLinkName appOwner : (NSString *) appOwner;
+ (ZCForm*) getForm : (NSString*) appLinkName : (NSString*) formLinkName appOwner : (NSString *) appOwner;

+(ZCForm*) getSubForm : (NSString*) appLinkName : (NSString*) formLinkName appOwner : (NSString *) appOwner   mainAppLinkname:(NSString *)mainAppLinkname mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname;

+ (ZCView*) getView : (NSString*) appLinkName : (NSString*) viewLinkName appOwner : (NSString *) appOwner;
+ (ZCView*) getView : (NSString*) appLinkName : (NSString*) viewLinkName withParameter : (ZCViewParam*) viewParam appOwner : (NSString *) appOwner;
+ (NSDictionary*) submitRecordForForm : (NSString*) formLinkName  WithApplication: (NSString*) appLinkName AndDataDictionary : (NSDictionary*) dataDict;
+ (NSDictionary*) updateRecordForView : (NSString*) viewLinkName  WithApplication: (NSString*) appLinkName AmdDataDictionary : (NSMutableArray*) dataDict;
+ (BOOL) deleteRecordWithID : (NSString*) recordLinkID withViewName : (NSString*) viewName andApplication : (ZCApplication*) application;
+ (NSMutableArray*) deleteRecordWithIDs : (NSMutableArray*) recordLinkIDs withFormName : (NSString*) formName andAppName : (NSString*) appLinkName;
+ (void) submitRecordsForForm : (NSString*) formLinkName  WithApplication: (NSString*) appLinkName AndRecords : (NSMutableArray*) records;
+ (NSMutableArray*) deleteRecordWithIDs : (NSMutableArray*) recordLinkIDs withViewName : (NSString*) viewName andAppName : (NSString*) appLinkName;
+ (BOOL) deleteRecordWithID : (NSString*) recordLinkID withViewName : (NSString*) viewName andAppName : (NSString*) appLinkName;
+ (void) logout;
+ (NSMutableArray*) updateRecordWithIDs : (ZCForm*) form : (NSMutableArray*) records;
+ (NSMutableArray*) updateRecordWithIDs:(NSMutableArray *)records withViewLinkName :(NSString*) viewLinkName andApplicationName : (NSString*) applicationName;
+ (ZCForm*) getIssueReportForm;
+ (void) duplicateRecordsForView : (NSString*) viewLinkName  WithApplication: (NSString*) appLinkName AndRecords : (NSMutableArray*) records AndAppOwner : (NSString*) appOwner;
+ (ZCForm*) getEditForm : (NSString*) appLinkName : (NSString*) formLinkName recordLinkID : (NSString*) recordLinkID appOwner : (NSString *) appOwner;
+ (NSArray*) newDuplicateRecordForView : (NSString*) viewLinkName  WithApplication: (NSString*) appLinkName AndRecords : (NSMutableArray*) records AndAppOwner : (NSString*) appOwner;
+ (ZCForm*) getEditFormWithView : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName recordLinkID : (NSString*) recordLinkID appOwner : (NSString *) appOwner;

@end
