//
//  ZCAppsCategoryParser.h
//  ZohoCreator
//
//  Created by Solai Murugan on 30/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPersonalGroup.h"
#import "ZCWorkSpace.h"
#import "ZCAllAppsCategory.h"

enum APP_CATEGORY_PARSER
{
    GROUP = 1,
    WORKSPACE=2,
    NONE_CAT = -1,
};

@interface ZCAppsCategoryParser : NSObject<NSXMLParserDelegate>
{
@private
    ZCPersonalGroup* _sharedGrp;
    ZCWorkSpace *_workspace;
    NSXMLParser *_xmlParser;
    NSString *_xmlString;
    NSString *_currentElementName;
    NSInteger _elementType;
}

@property (nonatomic,retain) ZCAllAppsCategory* allAppsCategory;

- (ZCAppsCategoryParser *)  initZCAppsCategoryParser : (NSString*) xmlString;

@end
