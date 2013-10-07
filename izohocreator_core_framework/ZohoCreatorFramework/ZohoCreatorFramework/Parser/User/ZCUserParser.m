//
//  ZCUserParser.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 05/06/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCUserParser.h"

/**** start of private interface for the current class ****/

@interface ZCUserParser (hidden)

- (void) parseScriptXML;

@end

/**** end of private interface for the current class ****/

@implementation ZCUserParser

- (ZCUserParser*) initZCUserParser : (NSString*) xmlString;
{
    self = [super init];
    if(self) {
        self->_xmlString = xmlString;
    }
    [self parseScriptXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    _currentElementName = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if([_currentElementName isEqualToString:@"DISPLAY_NAME"])  {
        [[ZOHOUser userObject] setUserDisplayName:string];
    }
    else if([_currentElementName isEqualToString:@"ZUID"]) {
        [[ZOHOUser userObject] setZuid:string];
    }
    else if([_currentElementName isEqualToString:@"FULL_NAME"]) {
        [[ZOHOUser userObject] setUserName:string];
    }
    else if([_currentElementName isEqualToString:@"LOCALE_INFO"]) {
        [[ZOHOUser userObject] setUserLocale:string];
    }
    else if([_currentElementName isEqualToString:@"EMAIL_ID"]) {
        [[ZOHOUser userObject] setEmailIds:[string componentsSeparatedByString:@","]];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
}


@end


/****
 
 start of private implementation for the current class
 
 ****/

@implementation ZCUserParser (hidden)

- (void) parseScriptXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
    
}

@end

/****
 
 end of private implementation for the current class
 
 ****/
