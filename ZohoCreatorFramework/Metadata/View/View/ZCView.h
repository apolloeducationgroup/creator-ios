//
//  ZCView.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCViewField.h"
#import "ZCRecordCountFetcher.h"
#import "ZCGroups.h"

@class ZCRecords,ZCComponent,ZCCalendarEvents,ZCViewField,ZCApplication, ZCRecord,ZCIssueReporter,ZCViewCustomFilter;

@interface ZCView : NSObject  {
@private ZCCalendarEvents *_events;
@private NSInteger _recordCount;
@private ZCIssueReporter *reporter;
    
}

@property (nonatomic,retain) NSString *viewLinkName;
@property (nonatomic,retain) NSString *viewDisplayName;
@property (nonatomic,retain) NSString *dateFormat;
@property (nonatomic,retain) NSString *baseForm;
@property (nonatomic,retain,getter = getBaseFormObject) ZCForm *baseFormObject;
@property (nonatomic,retain) NSString *baseCriteria;
//@property (nonatomic,retain) NSString *viewDisplayField;
@property (nonatomic) BOOL automaticFetch;
@property (nonatomic,retain) ZCRecords *records;
@property (nonatomic,retain) ZCCalendarEvents *events;
@property (nonatomic,retain) ZCGroups *zcGroups;
@property (nonatomic,retain) NSMutableDictionary *viewFieldDict;
@property (nonatomic,retain) ZCApplication *application;
@property (nonatomic,retain) NSMutableArray *customFilterList;
@property (nonatomic,retain) NSMutableArray *filterList;
@property (nonatomic,retain,getter = headerAction) NSMutableArray *headerAction;
@property (nonatomic,retain,getter = rowAction) NSMutableArray *rowAction;
@property (nonatomic,retain) ZCViewParam *viewParam;
@property (nonatomic, retain) NSString* baseField;
@property BOOL hasAddPermission;
@property BOOL hasEditPermission;
@property BOOL hasDeletePermission;
@property BOOL hasDupplicatePermission;
@property BOOL hasBulkEditPermission;


- (void) addZCViewField : (ZCViewField*) viewField;
- (ZCRecords*) fetchRecords : (NSInteger) startingIndex :(NSInteger) endIndex;
- (NSMutableArray*) getOrderedField;
- (ZCView*) initZCView;
- (ZCCalendarEvents*) fetchCalendarEvents;
- (ZCViewField*) getField : (NSString*) fieldLinkName;
- (ZCRecord *)getRecordAtIndex : (NSIndexPath*) indexPath;
- (NSInteger)getRecordIndex : (ZCRecord *) record;
- (ZCRecord *) getRecord: (NSString *) recordID;
- (NSInteger) recordCount : (BOOL) fromServer;
- (BOOL)hasNextRecord : (NSIndexPath*) indexPath;
-(void)submitIssue;
@end
