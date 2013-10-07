//
//  ZCPaymentParser.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 05/06/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCPaymentParser.h"

/**** start of private interface for the current class ****/

@interface ZCPaymentParser (hidden)

- (void) parseScriptXML;

@end

/**** end of private interface for the current class ****/

@implementation ZCPaymentParser

@synthesize zcPayment=_zcPayment;

- (ZCPaymentParser*) initRecordParser:(NSString *)xmlString
{
    self = [super init];
    if(self) {
        self->_xmlString = xmlString;
    }
    [self parseScriptXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
    _zcPayment = [[ZCPayment alloc] initZCPayment];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    _currentElementName = elementName;
    if([elementName isEqualToString:@"ENABLED"]) {
        [_zcPayment setMobilePaymentStatus:YES];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if([_currentElementName isEqualToString:@"ENABLED"]) {
        
        if([string isEqualToString:@"true"]) {
            [_zcPayment setMobilePaymentStatus:YES];
        }
        else {
            [_zcPayment setMobilePaymentStatus:NO];
        }
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

@implementation ZCPaymentParser (hidden)

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
