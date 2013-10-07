//
//  CustomActionParser.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 23/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelugeTasks.h"
#import "CustomActionResponse.h"
#import "CustomActionResult.h"
#import "ZCInternationalization.h"

@interface CustomActionParser : NSObject <NSXMLParserDelegate> {
    
@private NSXMLParser *_xmlParser;
@private NSString *_xmlString;
@private NSString *_currentElementValue;
@private NSString *_currentElementName;
@private NSInteger _baseElement;
@private id delugeTask;
@private NSInteger taskType;
@private BOOL _failureElement;
@private BOOL _successElement;
@private CustomActionResult *_customActionResult;
@private NSMutableArray *_failureList;
@private NSMutableArray *_successList;
}

@property (nonatomic,retain) CustomActionResponse *customResponse;

- (CustomActionParser*) initScriptParser : (NSString*) xmlString;

@end