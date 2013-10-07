//
//  ZCViewFilter.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 31/01/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCViewFilter.h"

@implementation ZCViewFilter

@synthesize filterName=_filterName,filterValues=_filterValues,selectedIndexs=_selectedIndexs,filterDisplayName=_filterDisplayName;

- (ZCViewFilter*) initZCViewFilter {
    
    self = [super init];
    if(self) {
        self->_filterValues = [[NSMutableArray alloc] init];
        self->_selectedIndexs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addFilterValues:(NSString*) filterValue {
    [_filterValues addObject:filterValue];
}

@end
