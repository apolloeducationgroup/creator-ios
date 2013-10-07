//
//  ZCViewFilter.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 31/01/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCViewFilter : NSObject

@property (nonatomic,retain) NSString *filterName;
@property (nonatomic,retain) NSString *filterDisplayName;
@property (nonatomic,retain) NSMutableArray *filterValues;
@property (nonatomic,retain) NSMutableArray *selectedIndexs;

- (ZCViewFilter*) initZCViewFilter;

@end