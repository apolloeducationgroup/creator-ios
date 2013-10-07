//
//  ZCUserParser.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 05/06/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZOHOCreator.h"

@interface ZCUserParser : NSObject <NSXMLParserDelegate> {
    
@private NSXMLParser *_xmlParser;
@private NSString *_xmlString;
@private NSString *_currentElementName;
}

- (ZCUserParser*) initZCUserParser : (NSString*) xmlString;

@end

