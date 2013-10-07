//
//  ViewRecordCountParser.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 15/07/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewRecordCountParser : NSObject <NSXMLParserDelegate>  {
    
@private
    NSString *_xmlString;
    NSXMLParser *_xmlParser;
}

@property NSInteger recordCount;

- (ViewRecordCountParser*) initViewRecordCountParser:(NSString *) xmlString;

@end
