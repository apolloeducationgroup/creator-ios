//
//  ViewRecordCountParser.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 15/07/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ViewRecordCountParser.h"

@interface ViewRecordCountParser (hidden)

- (void) viewRecordParserXML;

@end

@implementation ViewRecordCountParser

@synthesize recordCount=_recordCount;

- (ViewRecordCountParser*) initViewRecordCountParser:(NSString *) xmlString  {
    
    self = [super init];
    if (self) {
        
        self->_xmlString = xmlString;
    }
    [self viewRecordParserXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    if([elementName isEqualToString:@"recordcount"]) {
        
        NSString *recCountString = [attributeDict valueForKey:@"value"];
        _recordCount = [recCountString integerValue];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

@end

/****
 
 private implementation
 
 ****/

@implementation ViewRecordCountParser (hidden)

- (void) viewRecordParserXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}

@end
