//
//  ZCSections.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 14/09/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSection.h"

@interface ZCSections : NSObject  {
    
}

@property BOOL hasLicense;
@property (nonatomic,retain) NSMutableArray *sectionList;
@property (nonatomic,retain) NSMutableArray *visibleSectionList;
@property (getter = visibleSectinoCount) NSInteger visibleSectionCount;


//Mathan added
@property (nonatomic,retain) NSMutableDictionary *sectionsDict;
-(void)setJsonDict:(NSMutableDictionary *)jsonDict;
//

- (ZCSections*) initZCSections;
- (void) addZCSection : (ZCSection*) section;
@end
