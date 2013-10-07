//
//  ZCSections.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 14/09/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCSections.h"

@implementation ZCSections

@synthesize sectionList=_sectionList,visibleSectionCount=_visibleSectionCount,visibleSectionList=_visibleSectionList,sectionsDict;

- (ZCSections*) initZCSections
{
    
    self = [super init];
    if(self) {
        self->_sectionList = [[NSMutableArray alloc] init];
        self->_visibleSectionList = [[NSMutableArray alloc] init];
        _visibleSectionCount = -1;
    }
    return self;
}
-(void)setJsonDict:(NSMutableDictionary *)jsonDict
{
    sectionsDict = jsonDict;
}

- (void) addZCSection:(ZCSection*)section
{
    [_sectionList addObject:section];
    if([section isHidden]==NO) {
        [_visibleSectionList addObject:section];
    }
}

- (NSInteger) visibleSectionCount {
    
    if(_visibleSectionCount==-1) {
        _visibleSectionCount=0;
        for(NSInteger index=0;index<[_sectionList count];index++) {
            ZCSection *_sec = [_sectionList objectAtIndex:index];
            if([_sec isHidden] == NO) _visibleSectionCount++;
        }
    }
    return _visibleSectionCount;
}

@end
