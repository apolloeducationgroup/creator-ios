//
//  ZCView.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCView.h"
#import "ZCIssueReporter.h"

@interface ZCView (hidden)

- (NSMutableArray*) initalizeList : (NSInteger) count;
- (NSInteger) recordCountFromServer;

@end

@implementation ZCView

@synthesize baseCriteria=_baseCriteria,baseForm=_baseForm,baseFormObject=_baseFormObject,viewDisplayName=_viewDisplayName,dateFormat=_dateFormat;
@synthesize viewLinkName=_viewLinkName,records=_records,viewFieldDict=_viewFieldDict,application=_application,events=_events,filterList=_filterList, zcGroups=_zcGroups;
@synthesize hasAddPermission=_hasAddPermission,hasBulkEditPermission=_hasBulkEditPermission,hasDeletePermission=_hasDeletePermission;
@synthesize hasDupplicatePermission=_hasDupplicatePermission,hasEditPermission=_hasEditPermission;
@synthesize headerAction=_headerAction,rowAction=_rowAction,menuAction=_menuAction,viewParam=_viewParam,customFilterList=_customFilterList;
@synthesize baseField=_baseField;

- (ZCView*) initZCView  {
    
    self = [super init];
    if(self)  {
        self->_viewFieldDict = [[NSMutableDictionary alloc] init];
        
        
        
        
    }
    return self;
}

- (NSMutableArray*) rowAction {
    return _rowAction;
}

- (NSMutableArray*) headerAction {
    return _headerAction;
}
-(NSMutableArray *) menuAction
{
    return  _menuAction;
}
- (void) addZCViewField : (ZCViewField*) viewField {
    
//    if ([viewField fieldType] !=[ZCFieldList ZCAutoNumber ])
    [_viewFieldDict setObject:viewField forKey:[viewField fieldLinkName]];
    
}

- (ZCRecords*) fetchRecords: (NSInteger) startingIndex :(NSInteger) endIndex {
    return nil;
}

- (ZCViewField*) getField : (NSString*) fieldLinkName {
    
    NSEnumerator *keyEnum = [_viewFieldDict keyEnumerator];
    NSString *fieldName;
    while ((fieldName=[keyEnum nextObject])!=nil) {
        if([fieldName isEqualToString:fieldLinkName] == YES) {
            return [_viewFieldDict valueForKey:fieldLinkName];
        }
    }
    return nil;
}

- (NSInteger) recordCount : (BOOL) fromServer {
    
    if(fromServer == YES) {
        return [self recordCountFromServer];
    }
    else {
        if(_recordCount == -1)
        {
            return [self recordCountFromServer];
        }
        else {
            return _recordCount;
        }
    }
}

- (ZCForm*) getBaseFormObject {
    
    if (_baseFormObject==nil) {
        
        if ([_application appLinkName]&&[_application appOwner]) {
            _baseFormObject = [ZOHOCreator getForm:[_application appLinkName] :_baseForm appOwner:[_application appOwner]urlParameters:nil];
        }
    }
    return _baseFormObject;
}

- (NSMutableArray*) getOrderedField {
    
    NSMutableArray *valueList = [[NSMutableArray alloc] initWithArray:[_viewFieldDict allValues]];
    for(NSInteger index=0;index<[valueList count];index++) {
        
        for(NSInteger jndex=index+1;jndex<[valueList count];jndex++) {
            
            ZCViewField *viewField1 = [valueList objectAtIndex:index];
            ZCViewField *viewField2 = [valueList objectAtIndex:jndex];
            if([viewField1 sequenceNumber] > [viewField2 sequenceNumber]) {
                [valueList replaceObjectAtIndex:jndex withObject:viewField1];
                [valueList replaceObjectAtIndex:index withObject:viewField2];
            }
        }
    }
    //    [self filterCount];
    
    return valueList;
    
    /*    NSMutableArray *fieldList = [[NSMutableArray alloc] initWithArray:[_viewFieldDict allKeys]];
     NSString *fieldName ;
     NSEnumerator *keyEnum =  [_viewFieldDict keyEnumerator];
     while(fieldName = [keyEnum nextObject] ) {
     ZCViewField *viewField = [_viewFieldDict objectForKey:fieldName];
     
     NSInteger viewOrder =  [viewField sequenceNumber];
     
     @try {
     [fieldList replaceObjectAtIndex:viewOrder-1 withObject:viewField];
     }
     @catch (NSException *exception) {
     
     // //NSLog(@"exp zcview  %@  %@",[exception name],[exception description]);
     reporter = [[ZCIssueReporter alloc] initZCIssueReporter:self exception:exception];
     [[[UIApplication sharedApplication] keyWindow] addSubview:reporter.view];
     }
     @finally {
     
     }
     }
     
     //// //NSLog(@"flerelist %@",fieldList);
     return fieldList;*/
}

- (ZCRecord *)getRecordAtIndex : (NSIndexPath*) indexPath
{
    ZCRecord *_zcRecord;
    if (_zcGroups != nil) {
        ZCGroup *zcGroup = [[_zcGroups zcGroups] objectAtIndex:[indexPath section]];
        _zcRecord = [zcGroup.zcRecords objectAtIndex:[indexPath row]];
    }
    else
    {
        _zcRecord = [[_records records] objectAtIndex:indexPath.row];
    }
    return _zcRecord;
}

- (NSInteger)getRecordIndex : (ZCRecord *) record
{
    NSInteger index = 0;
    for (ZCRecord *zcRerd in _records.records) {
        
        if (record.recordID == zcRerd.recordID) {
            return index;
        }
        index ++;
    }
    return -1;
}

- (ZCRecord *) getRecord: (NSString *) recordID
{
    
    for (ZCRecord *zcRerd in _records.records) {
        
        if ([recordID isEqualToString:zcRerd.recordID]) {
            return zcRerd;
        }
    }
    return nil;
}

- (BOOL)hasNextRecord : (NSIndexPath*) indexPath
{
    if (_zcGroups != nil) {
        ZCGroup *zcGroup = [[_zcGroups zcGroups] objectAtIndex:[indexPath section]];
        if (indexPath.row == zcGroup.zcRecords.count - 1) {
            return NO;
        }
    }
    else
    {
        if (indexPath.row == [_records records].count - 1) {
            return NO;
        }
    }
    return YES;
}

- (ZCCalendarEvents*) fetchCalendarEvents
{
    return self.events;
}
-(void)submitIssue
{
    //// //NSLog(@"EXEPTION OCCURED IN ZCVIEW report issue");
    
    [reporter.view removeFromSuperview];
    
}
-(id) copyWithZone:(NSZone *)zone {
    
    ZCView *View = [[[self class] alloc] initZCView];
    if(View) {
        
        [View setViewDisplayName:[_viewDisplayName mutableCopy]];
        [View setBaseCriteria:[_baseCriteria mutableCopy]];
        [View setDateFormat:[_dateFormat mutableCopy]];
        [View setBaseForm:[_baseForm mutableCopy]];
        [View setBaseFormObject:[[self getBaseFormObject]copy]];
        [View setAutomaticFetch:_automaticFetch ];
        [View setRecords:[_records copy]];
        [View setEvents:[_events copy]];
        [View setZcGroups:[_zcGroups copy]];
        [View  setViewFieldDict:[_viewFieldDict copy]];
        [View setApplication:[_application copy]];
        [View setFilterList:[_filterList copy]];
        [View setCustomFilterList:[_customFilterList copy]];
        [View setHeaderAction:[[self headerAction]copy] ];
        [View setRowAction:[[self rowAction]copy]];
        [View setViewParam:[_viewParam copy]];
        [View setHasAddPermission:_hasAddPermission ];
        [View setHasEditPermission:_hasEditPermission];
        [View setHasDupplicatePermission:_hasDupplicatePermission];
        [View setHasBulkEditPermission:_hasBulkEditPermission];
        
        
    }
    return View;
}
@end

@implementation ZCView(hidden)

- (NSMutableArray*) initalizeList : (NSInteger) count {
    
    NSMutableArray *fieldList = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger index=0; index<count; index++) {
        [fieldList addObject: @""];
    }
    return fieldList;
}

- (NSInteger) recordCountFromServer {
    
    ZCRecordCountFetcher *recordCount = [ZCRecordCountFetcher initRecordCountFetcher:[_application appLinkName] withViewLinkName:_viewLinkName viewParams : _viewParam appOwner:_application.appOwner];
    _recordCount = [recordCount  recordCount];
    
    return _recordCount;
}


@end
