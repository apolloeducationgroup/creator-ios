//
//  ZCCriteria.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 23/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//


#import <Foundation/Foundation.h>

enum ZCCriteriaOperator {
    
    ZCCriteriaIsOperator = 18,
    ZCCriteriaIsNotOperator = 19,
    ZCCriteriaIsEmptyOperartor = 29,
    ZCCriteriaIsNotEmptyOperator = 30,
    ZCCriteriaContainsOperator=26,
    ZCCriteriaNotContainsOperator=27,
    ZCCriteriaLikeOperator=28,
    ZCCriteriaLessThanOperator=20,
    ZCCriteriaGreaterThanOperator=21,
    ZCCriteriaLessThanEqualOperator=22,
    ZCCriteriaGreaterThanEqualOperator=23,
    
    ZCCriteriaTrueOperator = 49,
    ZCCriteriaFalseOperator = 50,
    
    //date
    ZCCriteriaBeforeOperator=20,
    ZCCriteriaAfterOperator=21,
    ZCCriteriaBetweenOperator=58,
    
    ZCCriteriaYesterdayOperator=31,
    ZCCriteriaTodayOperator=32,
    ZCCriteriaTomorrowOperator=33,
    ZCCriteriaLast7DaysOperator=34,
    ZCCriteriaLast30DaysOperator=35,
    ZCCriteriaLast60DaysOperator=36,
    ZCCriteriaLast90DaysOperator=37,
    ZCCriteriaLast120DaysOperator=38,
    ZCCriteriaLastNDaysOperator= 64,
    ZCCriteriaNext7DaysOperator=39,
    ZCCriteriaNext30DaysOperator=40,
    ZCCriteriaNext60DaysOperatpr=41,
    ZCCriteriaNext90DaysOperator=42,
    ZCCriteriaNext120DaysOperator=43,
    ZCCriteriaNextNDaysOperator=65,
    
    ZCCriteriaLastWeekOperator=60,
    ZCCriteriaThisWeekOperator=59,
    ZCCriteriaNextWeekOperator=61,
    ZCCriteriaCurrentAndPreviousWeekOperator=62,
    ZCCriteriaCurrentAndNextWeekOperator=63,
    ZCCriteriaLastNWeekOperator=66,
    ZCCriteriaNextNWeekOperator=67,
    
    ZCCriteriaLastMonthOperator=44,
    ZCCriteriaThisMonthOperator=45,
    ZCCriteriaNextMonthOperator=46,
    ZCCriteriaCurrentAndPreviousMonthOperator=47,
    ZCCriteriaCurrerntAndNextMonthOperator=48,
    ZCCriteriaLastNMonthOperator=68,
    ZCCriteriaNextNMonthOperator=69,
    
    ZCCriteriaLastYearOperator=51,
    ZCCriteriaNextYearOperator=53,
    ZCCriteriaThisYearOperator=52,
    ZCCriteriaLast2YearOperator=54,
    ZCCriteriaNext2YearOperator=55,
    ZCCriteriaCurrentAndPreviousYearOperator=56,
    ZCCriteriaCurrentAndNextYearOperator=57,
    ZCCriteriaLastNYearOperator=70,
    ZCCriteriaNextNYearOperator=71,
    
};

@interface ZCCriteria : NSObject

@property (nonatomic,retain) NSString *fieldName;
@property (nonatomic, retain) NSString* fieldDisplayName;
@property NSInteger operator;
@property (nonatomic,retain) id value;


@end
