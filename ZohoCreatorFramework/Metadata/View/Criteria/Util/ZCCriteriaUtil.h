//
//  ZCCriteriaUtil.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 23/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "EditRecordParser.h"

enum RELATIONAL_OPER {
    AND_OPERATOR=1,
    OR_OPERATOR=2,
    NONE_OPERATOR=-1,
};

enum CONDITIONAL_OPER {
    EQUALS_OPERATOR=1,
};

@interface ZCCriteriaUtil : NSObject

+ (NSInteger) AND_OPERATOR;
+ (NSInteger) OR_OPERATOR;
+ (NSInteger) NONE_OPERATOR;
+ (NSInteger) EQUALS_OPERATOR;
+ (NSInteger) getOperatorNumber : (NSString*) operator;

@end


