//
//  ZCAppsCategoryParser.m
//  ZohoCreator
//
//  Created by Solai Murugan on 30/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCAppsCategoryParser.h"

@interface ZCAppsCategoryParser (hidden)

- (void) parseZCAppsCategoryXML;

@end

@implementation ZCAppsCategoryParser

@synthesize allAppsCategory=_allAppsCategory;

- (ZCAppsCategoryParser *) initZCAppsCategoryParser:(NSString *)xmlString {
    
    self = [super init];
    if (self) {
        _elementType = NONE_CAT;
        self->_xmlString = xmlString;
    }
    [self parseZCAppsCategoryXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
    self->_allAppsCategory = [[ZCAllAppsCategory alloc] initZCAllAppsCategory];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    if (_elementType == GROUP) {
        if([elementName isEqualToString:@"group"])  {
            
            _sharedGrp = [[ZCPersonalGroup alloc] init];
        }
    }
    else if (_elementType == WORKSPACE)
    {
        if([elementName isEqualToString:@"workspace"])  {
            
            _workspace = [[ZCWorkSpace alloc] init];
        }
    }
    else
    {
        if([elementName isEqualToString:@"workspaces"])  {
            _elementType = WORKSPACE;
        }
        else if ([elementName isEqualToString:@"groups"])
        {
            _elementType = GROUP;
        }
    }
    _currentElementName = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (_elementType == GROUP) {
        if([_currentElementName isEqualToString:@"groupname"]) {
//            [_sharedGrp setGroupName:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
                    [_sharedGrp setGroupName:string];

        }
        else if([_currentElementName isEqualToString:@"groupid"]) {
            [_sharedGrp setGroupID:string];
        }
    }
    else if (_elementType == WORKSPACE)
    {
        if([_currentElementName isEqualToString:@"workspaceowner"]) {
//            [_workspace setWorkspaceowner:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
            [_workspace setWorkspaceowner:string];

        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"groups"] || [elementName isEqualToString:@"workspaces"]) {
        _elementType = NONE_CAT;
    }
    else
    {
        if ([elementName isEqualToString:@"group"])
        {
            [_allAppsCategory addPersonalGroup:_sharedGrp];
        }
        else if ([elementName isEqualToString:@"workspace"])
        {
            [_allAppsCategory addWorkSpace:_workspace];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
}

@end

/****
 
 private implementation
 
 ****/

@implementation ZCAppsCategoryParser (hidden)

- (void) parseZCAppsCategoryXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}
@end