//
//  ZCViewParam.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 22/01/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCViewParam.h"


@implementation ZCSort

@synthesize fieldName=_fieldName,sortBy=_sortBy;

@end


@implementation ZCGroupBy

@synthesize fieldName=_fieldName,sortBy=_sortBy;

@end

@implementation ZCViewParam

- (ZCViewParam*) initZCViewParam {
    
    self = [super init];
    if(self) {
        self->_filterDict = nil;
        self->_criteriaList = [[NSMutableArray alloc] init];
        self->_sortColumnList = [[NSMutableArray alloc] init];
        self->_groupByColumnList = [[NSMutableArray alloc] init];
        self->_calParams = nil;
        self->_startIndex=0;
        self->_recordCount=0;
        self->_pageSize = 50;
    }
    return self;
}

- (NSInteger) getPageSize {
    return self->_pageSize;
}

- (void) addCalendarCrit : (NSString *) startDate EndDate : (NSString *) endDate
{
    if(_calParams == nil) {
        _calParams = [[NSMutableDictionary alloc] init];
    }
    [_calParams setValue:startDate forKey:@"startDateStr"];
    [_calParams setValue:endDate forKey:@"endDateStr"];
}

- (NSDictionary*) getCalendarCriteria
{
    return _calParams;
}

- (void) setMobileViewType : (NSInteger) mobileViewType
{
    if(_calParams == nil) {
        _calParams = [[NSMutableDictionary alloc] init];
    }
    [_calParams setValue:[NSString stringWithFormat:@"%d",mobileViewType] forKey:@"mobileViewType"];
}

- (void) addGroupBy : (ZCGroupBy*) groupBy {
    
    [_groupByColumnList addObject:groupBy];
}

- (BOOL) removeAllGroupBy {
    [_groupByColumnList removeAllObjects];
    return YES;
}

- (BOOL) removeGroupByName : (NSString*) fieldName {
    
    for(NSInteger index=0;index<[_groupByColumnList count];index++) {
        
        ZCGroupBy *groupBy = [_groupByColumnList objectAtIndex:index];
        if([[groupBy fieldName] isEqualToString:fieldName]) {
            [_groupByColumnList removeObjectAtIndex:index];
            return YES;
        }
    }
    return NO;
}

- (BOOL) removeAllSortBy {
    
    [_sortColumnList removeAllObjects];
    return YES;
}

- (BOOL) removeSortByName : (NSString*) fieldName {
    
    for (NSInteger index=0; index<[_sortColumnList count]; index++) {
        ZCSort *sort = [_sortColumnList objectAtIndex:index];
        if([[sort fieldName] isEqualToString:fieldName])
        {
            [_sortColumnList removeObjectAtIndex:index];
            return YES;
        }
    }
    return NO;
}

- (void) addFilter : (NSString*) filterName  withValueList : (NSMutableArray*) filterValues {
    
    if(_filterDict == nil) {
        _filterDict = [[NSMutableDictionary alloc] init];
    }
    
    [_filterDict setObject:filterValues forKey:filterName];
}

- (BOOL) removeFilterByName : (NSString*) filterName {
    
    if(_filterDict != nil) {
        [_filterDict removeObjectForKey:filterName];
        return YES;
    }
    return NO;
}

- (BOOL) removeAllFilters {
    
    [_filterDict removeAllObjects];
    return YES;
}

- (NSString*) getSortByString {
    
    if([_sortColumnList count] > 0 ) {
        
        NSMutableString *returnString = [[NSMutableString alloc] initWithString:@"sortBy="];
        NSString *relationStr = @"";
        for(NSInteger index=0;index<[_sortColumnList count];index++) {
            ZCSort *sortColumn = [_sortColumnList objectAtIndex:index];
            NSString *columnName = [sortColumn fieldName];
            ZCCriteriaRelation relation = [sortColumn sortBy];
            if(relation == ZCViewAsending) {
                relationStr = @"true";
            }
            else if(relation == ZCViewDesending) {
                relationStr = @"false";
            }
            [returnString appendFormat:@"%@:%@",columnName,relationStr];
            if(index != [_sortColumnList count]-1) {
                [returnString appendString:@";"];
            }
        }
        return returnString;
    }
    else {
        return nil;
    }
}

- (NSDictionary*) getFilters {
    return _filterDict;
}

- (void) setCustomFilter:(NSString *)_filterID {
    _customFilterID = _filterID;
}

- (NSString*) getFilterString {
    
    if(_filterDict.count > 0) {
        
        
        NSMutableString *returnString = [[NSMutableString alloc] initWithString:@"filterVal="];
        NSEnumerator *keyEnum =   [self->_filterDict keyEnumerator];
        NSString *keyName;
        BOOL pre = NO;
        while((keyName=keyEnum.nextObject) != nil) {
            if(pre==YES) {
                [returnString appendFormat:@";%@:",keyName];
            }
            else {
                [returnString appendFormat:@"%@:",keyName];
                pre=YES;
            }
            NSMutableArray *keyValues = [self->_filterDict valueForKey:keyName];
            for(NSInteger index=0;index<[keyValues count];index++) {
                NSString *keyValue = [keyValues objectAtIndex:index];
                
                
                
                if(index == [keyValues count]-1) {
                    [returnString appendFormat:@"%@",keyValue];
                }
                else {
                    [returnString appendFormat:@"%@@zohocomma@",keyValue];
                }
            }
        }
        
        if(_customFilterID != nil) {
            
            [returnString appendFormat:@";CustomFilter:%@",_customFilterID];
        }
        return [returnString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else {
        if(_customFilterID != nil) {
            return [NSString stringWithFormat:@"filterVal=CustomFilter:%@",_customFilterID];
        }
        else
        {
            return @"";
        }
    }
}

- (NSString*) getCriteriaString {
    
    // Type_of_App=kumar&Type_of_App_op=26&searchCrit=true
    
    if([_criteriaList count] > 0) {
        
        NSMutableString *returnString = [[NSMutableString alloc] initWithString:@"searchCrit=true"];
        
        for(NSInteger index=0;index<[_criteriaList count];index++) {
            ZCCriteria *critera = [_criteriaList objectAtIndex:index];
            NSString *fieldName = [critera fieldName];
            NSInteger operator = [critera operator];
            NSString *searchValue = [critera value];
            if(searchValue != nil) {
                [returnString appendFormat:@"&%@=%@&%@_op=%d",fieldName,searchValue,fieldName,operator];
            }
            else {
                [returnString appendFormat:@"&%@_op=%d",fieldName,operator];
            }
        }
        return [returnString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else {
        return nil;
    }
}
- (NSString*) getCalParamString
{
    NSString *retString = @"";
    if (_calParams != nil) {
        for (NSString *paramName in _calParams) {
            retString = [retString stringByAppendingFormat:@"%@=%@&", paramName, [_calParams objectForKey:paramName]];
        }
    }
    return retString;
}
- (NSString*) getGroupByString {
    
    if([_groupByColumnList count] > 0) {
        
        NSMutableString *returnString = [[NSMutableString alloc] initWithString:@"groupBy="];
        for(NSInteger index=0;index<[_groupByColumnList count];index++) {
            ZCGroupBy *groupBy = [_groupByColumnList objectAtIndex:index];
            NSString *fieldName = [groupBy  fieldName];
            ZCViewSort sortBy = [groupBy sortBy];
            NSString *sortStr;
            if(sortBy == ZCViewAsending) {
                sortStr = @"true";
            }
            else {
                sortStr = @"false";
            }
            [returnString appendFormat:@"%@:%@",fieldName,sortStr];
            if(index != ([_groupByColumnList count]-1)) {
                [returnString appendString:@";"];
            }
        }
        return returnString;
    }
    else {
        return nil;
    }
}

- (void) addCriteria : (ZCCriteria*) criteria {
    
    [_criteriaList addObject:criteria];
}

- (void) criteriaList : (NSMutableArray*) criteriaList {
    
    _criteriaList = [criteriaList mutableCopy];
}

- (BOOL) removeAllCriteria {
    
    @try {
        _criteriaList = [[NSMutableArray alloc] init];
        return YES;
    }
    @catch (NSException *exception) {
        return NO;
    }
}


- (BOOL) removeCriteriaByName : (NSString*) fieldName {
    
    for(NSInteger index=0;index<[_criteriaList count];index++) {
        
        ZCCriteria *criteria = [_criteriaList objectAtIndex:index];
        if([[criteria fieldName] isEqualToString:fieldName]) {
            [_criteriaList removeObjectAtIndex:index];
            return YES;
        }
    }
    return NO;
}

- (void) clearCriteria {
    _criteriaList = nil;
}

- (void) criteriaRelation : (NSInteger) relation {
    
    if(relation==ZCCriteriaRelationAnd || ZCCriteriaRelationOr) {
        _criteriaRelation = relation;
    }
    else {
        _criteriaRelation = ZCCriteriaRelationOr;
    }
}

- (NSString*) criteriaString {
    
    NSMutableString *returnString = [[NSMutableString alloc] initWithString:@""];
    return returnString;
}

- (NSDictionary*) filterDictionary {
    return _filterDict;
}

- (NSArray*) criteriaList {
    return _criteriaList;
}

- (NSArray*) sortColumnList {
    return _sortColumnList;
}

- (NSArray*) groupByColumnList {
    return _groupByColumnList;
}

- (ZCCriteriaRelation) criteriaRelation {
    return _criteriaRelation;
}

- (NSInteger) startRecordIndex {
    return _startIndex;
}

- (void) startRecordIndex : (NSInteger) startRecordIndex {
    _startIndex = startRecordIndex;
}

- (NSInteger) recordCount {
    return _recordCount;
}

- (void) recordCount : (NSInteger) recordCount {
    _recordCount =recordCount;
}

- (void) addSort : (ZCSort*) sort {
    
    [_sortColumnList addObject:sort];
}
@end