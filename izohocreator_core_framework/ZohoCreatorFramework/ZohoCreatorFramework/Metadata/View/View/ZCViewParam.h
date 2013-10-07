//
//  ZCViewParam.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 22/01/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCCriteria.h"

@class ZCCriteria;

typedef NSInteger ZCCriteriaRelation;
typedef BOOL ZCViewSort;

enum ZCCriteriaRelation {
    ZCCriteriaRelationOr=0,
    ZCCriteriaRelationAnd=1,
};

enum ZCViewSory {
    ZCViewAsending=1,
    ZCViewDesending=0,
};

@interface ZCSort : NSObject

@property (nonatomic,retain) NSString *fieldName;
@property ZCViewSort sortBy;

@end

@interface ZCGroupBy : NSObject

@property (nonatomic,retain) NSString *fieldName;
@property ZCViewSort sortBy;

@end


@interface ZCViewParam : NSObject  {
    
@private NSMutableDictionary *_filterDict;
@private NSString *_customFilterID;
@private NSMutableArray *_criteriaList;
@private ZCCriteriaRelation _criteriaRelation;
@private NSMutableArray *_groupByColumnList;
@private NSInteger _startIndex;
@private NSInteger _recordCount;
@private NSInteger _pageSize;
@private
    NSMutableArray *_sortColumnList;
    NSMutableDictionary *_calParams;
}

- (ZCViewParam*) initZCViewParam;
- (void) addFilter : (NSString*) filterName  withValueList : (NSMutableArray*) filterValues;
- (void) addCalendarCrit : (NSString *) startDate EndDate : (NSString *) endDate;
- (void) setMobileViewType : (NSInteger) mobileViewType;
- (BOOL) removeFilterByName : (NSString*) filterName;
- (BOOL) removeAllFilters;
- (void) addCriteria : (ZCCriteria*) criteria;
- (void) criteriaList : (NSMutableArray*) criteriaList;
- (void) clearCriteria;
- (void) criteriaRelation : (NSInteger) relation;
- (void) setCustomFilter : (NSString*) _filterID;
- (NSDictionary*) filterDictionary;
- (NSArray*) criteriaList;
- (NSArray*) sortColumnList;
- (NSArray*) groupByColumnList;
- (void) recordCount : (NSInteger) recordCount;
- (NSInteger) startRecordIndex;
- (NSInteger) recordCount;
- (void) startRecordIndex : (NSInteger) startRecordIndex;
- (void) addSort : (ZCSort*) sort;
- (void) addGroupBy : (ZCGroupBy*) groupBy;
- (BOOL) removeAllGroupBy;
- (BOOL) removeGroupByName : (NSString*) fieldName;
- (BOOL) removeAllSortBy;
- (BOOL) removeSortByName : (NSString*) fieldName;
- (NSString*) getFilterString;
- (NSString*) getSortByString;
- (NSString*) criteriaString;
- (NSString*) getGroupByString;
- (NSString*) getCriteriaString;
- (NSString*) getCalParamString;
- (BOOL) removeCriteriaByName : (NSString*) fieldName;
- (BOOL) removeAllCriteria;
- (NSDictionary*) getFilters;
- (NSDictionary*) getCalendarCriteria;
- (NSInteger) getPageSize;

@end
