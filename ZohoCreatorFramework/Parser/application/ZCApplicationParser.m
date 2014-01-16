//
//  ZCApplicationParser.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCApplicationParser.h"


@interface ZCApplicationParser (hidden)

- (void) parseApplicationXML;

@end

@implementation ZCApplicationParser

@synthesize applicationList=_applicationList;

- (ZCApplicationParser*) initApplicationParser:(NSString *) xmlString  {
    
    self = [super init];
    if (self) {
        self->_xmlString = xmlString;
    }
    [self parseApplicationXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
    self->_applicationList = [[ZCApplicationList alloc] initZCApplicationList];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    if(_elementType==APPLICATION_LIST_TAG)  {
        
        if([elementName isEqualToString:@"application"])  {
            
            _zcApplication = [[ZCApplication alloc] init];
            _appListElementType = APPLICATION;
        }
        else {
            
            _currentElementName = elementName;
        }
    }
    else   {
        
        if([elementName isEqualToString:@"application_list"])  {
            _elementType = APPLICATION_LIST_TAG;
        }
        else {
            
            _elementType = NONE;
        }
        _currentElementName = elementName;
    }
}

-(NSString *)getDateWithFormat:(NSString *)date
{
    
    
  NSDateFormatter *commingDateFormat  = [[NSDateFormatter alloc] init];
    [commingDateFormat setDateFormat:@"yyyy-MM-dd HH:mm:sss.S"];
    NSDateFormatter *returnDateFormatter  = [[NSDateFormatter alloc] init];
    [returnDateFormatter setDateFormat:@"MMM dd, yyyy"];
NSDate *date_data=[commingDateFormat dateFromString:date];

    
NSString *stringFromDate = [returnDateFormatter stringFromDate:date_data];

    
    return stringFromDate;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(_elementType==APPLICATION_LIST_TAG)  {
        
        if(_appListElementType == APPLICATION) {
            
            if([_currentElementName isEqualToString:@"access"]) {
                [_zcApplication setAccessType:string];
            }
            else if([_currentElementName isEqualToString:@"link_name"]) {
                [_zcApplication setAppLinkName:string];
            }
            else if([_currentElementName isEqualToString:@"application_name"]) {
//                NSString *correctString = [NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding];
//                NSString *correctString = [NSString stringWithCString:[string cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding];

                
                [_zcApplication setAppDisplayName:string];
            }
            else if([_currentElementName isEqualToString:@"created_time"]) {
                string =[self getDateWithFormat:string];
                //NSLog@"string %@",string);
                [_zcApplication setCreatedOn:string];
            }
            else if([_currentElementName isEqualToString:@"sharedBy"]) {
                _appOwner = string;
                [_zcApplication setAppOwner:string];
            }
            else if([_currentElementName isEqualToString:@"layout"]) {
                [_zcApplication setAppLayout:[string intValue]];
                [_zcApplication setIsZAppBox:YES];
            }
        }
    }
    else {
        
        if([_currentElementName isEqualToString:@"application_owner"]) {
            [_applicationList addZCApplicationOwner:string];
            _appOwner=string;
        }
        else if([_currentElementName isEqualToString:@"license_enabled"]) {
            
            if ([string isEqualToString:@"true"]) {
                [_applicationList setLicenseEnabled:TRUE];
            }
            else {
                [_applicationList setLicenseEnabled:FALSE];
            }
        }
        else if([_currentElementName isEqualToString:@"evaluationDays"]) {
            
            [_applicationList setEvaluationDays:[string intValue]];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"application_list"])
    {
        _elementType = NONE;
    }
    else if(_elementType==APPLICATION_LIST_TAG)  {
        
        if(_appListElementType == APPLICATION) {
            
            if([elementName isEqualToString:@"application"])  {
                _appListElementType = NONE;
                [_zcApplication setAppOwner:_appOwner];
                [_applicationList addZCApplication:_zcApplication];
            }
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

@end

/****
 
 private implementation
 
 ****/

@implementation ZCApplicationParser (hidden)

- (void) parseApplicationXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}

@end
