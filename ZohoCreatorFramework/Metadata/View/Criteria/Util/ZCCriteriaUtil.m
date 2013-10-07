//
//  ZCCriteriaUtil.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 23/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCCriteriaUtil.h"
#import <mach/mach.h>
#import <mach/mach_host.h>


@implementation ZCCriteriaUtil

+ (NSInteger) AND_OPERATOR {
    return AND_OPERATOR;
}

+ (NSInteger) OR_OPERATOR {
    return OR_OPERATOR;
}

+ (NSInteger) NONE_OPERATOR {
    return NONE_OPERATOR;
}

+ (NSInteger) EQUALS_OPERATOR {
    return EQUALS_OPERATOR;
}

+ (NSInteger) getOperatorNumber:(NSString *)operator {
    
    if([operator isEqualToString:@"Equals"]) {
        return EQUALS_OPERATOR;
    }
    return -1;
}

@end
