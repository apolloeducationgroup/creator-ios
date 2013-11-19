//
//  RecordDuplicateParser.m
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 27/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "RecordDuplicateParser.h"
@interface RecordDuplicateParser (hidden)

- (void) recordDuplicateParserXML;

@end


@implementation RecordDuplicateParser

@synthesize status=_status;
@synthesize criteriaID=_criteriaID;
@synthesize formName=_formName;
@synthesize dateFormat=_dateFormat;
@synthesize timezone=_timezone;
- (RecordDuplicateParser*) initWithRecordDuplicateParser:(NSString *) xmlString  bulkDuplicate:(BOOL)bulkdup {
    
    self = [super init];
    if (self) {
        
        self->_xmlString = xmlString;
        fieldkeyvaluepair=[[NSMutableDictionary alloc]init];
        _bulkDuplicate=bulkdup;
    }
    [self recordDuplicateParserXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    //    NSLog(@"element name %@",elementName);
    //    NSLog(@"dict : %@",attributeDict);
    _elementname=Nil;
    if([elementName isEqualToString:@"form"]) {
        
        
        _formName =[attributeDict objectForKey:@"name"];
        
    }
    else if([elementName isEqualToString:@"criteria"]) {
        
        
        _elementname=elementName;
        
        
    }
    else if([elementName isEqualToString:@"value"]) {
        
        
        _elementname=elementName;
        
        
    }
    else if([elementName isEqualToString:@"field"]) {
        
        
        _fieldname = [attributeDict objectForKey:@"name"];
        
    }
    
    else if([elementName isEqualToString:@"status"]) {
        
        
        _elementname=elementName;
        
        
    }
    
    
    
    
    //        NSLog(@"dict : %@",attributeDict);
    //        NSString *recCountString = [attributeDict valueForKey:@"value"];
    //        _recordCount = [recCountString integerValue];
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    
    //    NSLog(@"found char %@",string);
    
    if([_elementname isEqualToString:@"criteria"] && !_bulkDuplicate) {
        
        NSArray * array=[string componentsSeparatedByString:@"== "];
        [fieldkeyvaluepair setObject:[NSString stringWithFormat:@"%lld",[[array objectAtIndex:1]longLongValue] ]forKey:@"CriteriaID"];
        
        [fieldkeyvaluepair setObject:[NSNumber numberWithLongLong:[[array objectAtIndex:1]longLongValue]] forKey:@"CriteriaID"];
        
        //         NSLog(@"fieldkey calue %@ %@",array,fieldkeyvaluepair);
        
        
    }
    else if([_elementname isEqualToString:@"value"]) {
        
        
        [fieldkeyvaluepair setObject:string forKey:_fieldname];
    }
    
    else if([_elementname isEqualToString:@"status"]) {
        
        
        if ([string isEqualToString:@"Success"]) {
            
            _status = YES;
            
            
        }
        else
        {
            
            _status =NO;
        }
        
    }
    //    <response>
    
    //    <result>
    //    <form name="all_basic_fields">
    
    //     <duplicate>
    //    <values xmlns="duplicate">
    //    <criteria>
    //    <![CDATA[(ID == 1409167000000256055)]]>
    //    </criteria>
    //    <field name="ID">
    //    <value>1409167000000266003
    //    </value>
    //    </field>
    //    <field name="dateFormat">
    //    <value>
    //    dd-MMM-yyyy
    //    </value>
    //    </field>
    //    <field name="timeZone">
    //    <value>America/Los_Angeles
    //    </value>
    //    </field>
    //    </values>
    
    
    
    //    <status>Success</status>
    //    </duplicate></form></result></response>
    //
    //
    //    <response><recordcount value="2"/></response>
    
    
    
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    _criteriaID=[fieldkeyvaluepair valueForKey:@"CriteriaID"];
    _recordID=[fieldkeyvaluepair valueForKey:@"ID"];
    _dateFormat=[fieldkeyvaluepair valueForKey:@"dateFormat"];
    _timezone=[fieldkeyvaluepair valueForKey:@"timeZone"];
    
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    //    NSLog(@"end element name %@",elementName);
    
    
}

@end

/****
 
 private implementation
 
 ****/

@implementation RecordDuplicateParser (hidden)

- (void) recordDuplicateParserXML
{
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}

@end