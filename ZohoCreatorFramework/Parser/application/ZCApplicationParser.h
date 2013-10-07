//
//  ZCApplicationParser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCApplication.h"
#import "ZCApplicationList.h"

@class ZCApplicationList;
enum APP_PARSER
{
    APPLICATION_LIST_TAG = 1,
    APPLICATION=2,
    NONE = -1,
};

@interface ZCApplicationParser : NSObject <NSXMLParserDelegate>  {
    
@private
    NSXMLParser *_xmlParser;
    NSString *_xmlString;
    NSString *_currentElementValue;
    NSInteger _elementType;
    NSInteger _appListElementType;
    ZCApplication *_zcApplication;
    NSString *_currentElementName;
    NSString *_appOwner;
}

@property (nonatomic,retain) ZCApplicationList* applicationList;

- (ZCApplicationParser*)  initApplicationParser : (NSString*) xmlString;

@end





