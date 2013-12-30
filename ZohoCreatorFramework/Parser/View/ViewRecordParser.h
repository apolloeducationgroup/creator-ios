//
//  ViewRecordParser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCRecords.h"
#import "ZCRecord.h"
#import "ZCFieldData.h"
#import "ZCCalendarEvents.h"
#import "ZCViewFilter.h"
#import "ZCViewAction.h"
#import "ZCGroup.h"
#import "ZCGroups.h"
#import "ZCViewCustomFilter.h"

@class ZCRecords,ZCViewField,ZCView,ZCViewFilter,ZCViewAction;

@interface ViewRecordParser : NSObject <NSXMLParserDelegate>  {
    
@private
    NSXMLParser *_xmlParser;
    NSString *_xmlString;
    ZCFieldData *_zcFieldData;
    ZCViewField *_zcViewFied;
    ZCRecord *_zcRecord;
    ZCCalendarEvents *_zcCalendarEvents;
    BOOL _valueTagEnabled;
    BOOL _columnTagEnabled;
    BOOL _recordTagEnabled;
    BOOL _metaDataTagEnabled;
    BOOL _metaDataFieldsEnabled;
    BOOL _metaDataFiltersEnabled;
    BOOL _metaDataCustomFiltersEnabled;
    BOOL _metaDataActionsEnabled;
    BOOL _metaDataActionEnabled;
    BOOL _metaDataRowActionEnabled;
    BOOL _metaDataViewActionEnabled;
    BOOL _metaDataMenuActionEnabled;

    
    BOOL _groupNameEnabled;
    BOOL _viewTagEnabled;
    BOOL _fieldTagEnabled;
    BOOL _calendarTagEnabled;
    BOOL _eventTagEnabled;
    NSDateFormatter *_userDateFormat;
    NSDateFormatter *_userDateTimeFormat;
    ZCViewFilter *filter;
    ZCViewCustomFilter *customFilter;
    NSMutableArray *filterList;
    NSMutableArray *customFilterList;
    NSMutableArray *_filterValueList;
    NSMutableArray *_filterDisplayValueList;
    ZCViewAction *_viewAction;
    NSMutableArray *_rowActions;
    NSMutableArray *_headerActions;
    NSMutableArray *_menuAction;
    ZCGroup *_zcGroup;
    ZCGroups *_zcGroups;
    BOOL isGrouped;
    ZCFieldData *_groupByNameFields;
    NSString *_currentElementName;
    ZCCalendarEvent *_zcCalendarEvent;
    NSString* _currentEventTitle;
    NSMutableArray* _currentEventItems;
    
    NSString * filterNAMEKey;
}

@property (nonatomic,retain) ZCView *zcView;
@property (nonatomic,retain) ZCRecords* zcRecords;

- (ViewRecordParser*)  initViewRecordParser : (NSString*) xmlString : (ZCComponent*) component;

@end

