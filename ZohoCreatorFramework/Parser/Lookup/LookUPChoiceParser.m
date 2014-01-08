//
//  LookUPChoiceParser.m
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 31/10/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import "LookUPChoiceParser.h"

@implementation LookUPChoiceParser
@synthesize choiceKeys=_choiceKeys,choiceValues=_choiceValues,lookUpChoicesParm=_lookUpChoicesParm;
- (LookUPChoiceParser *) initLookUPChoiceParser:(NSString *) xmlString
{
    self = [super init];
    if (self) {
        self->_xmlString = xmlString;
        _lookUpChoicesParm=[[ZCLookUpChoices alloc]initLookUpChoicesParm];
    
    }
    [self ParserXML];
    return self;
}
-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict

{
    if ([elementName isEqualToString:@"field"]) {
        
        [_lookUpChoicesParm setLookUpField:[attributeDict objectForKey:@"name"]];
        inchoices=NO;

    }
 
  else  if ([elementName isEqualToString:@"choices"]) {
        inchoices=YES;
    
    
    }
    
 else   if ([elementName isEqualToString:@"choice"] && inchoices) {
     
     
     
     
     key=[attributeDict objectForKey:@"value"];
     
    }
    
    

}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

    if( inchoices) {
        
        
        
        [_lookUpChoicesParm  addLookupChoice:string key:key];
        
        
    }

}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
}


- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    
    NSLog(@"LOOKUP CHOICES keys %@ valuew %@ choices %@ fieldname %@ ",[_lookUpChoicesParm lookUPKeysInOrder],[_lookUpChoicesParm lookUPChoicesInOrder],[_lookUpChoicesParm LookupChoices ],[_lookUpChoicesParm lookUpField]);

}

- (void) ParserXML  {
    
    NSLog(@"data riyaz in lookup");
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}


//<response>
//<result>
//<field name="Lookup_3">
//<choices>
//<choice value="1">1 - one</choice>
//<choice value="2">2 - two</choice>
//<choice value="3">3 - three</choice>
//<choice value="4">4 - four</choice>
//<choice value="5">5 - five</choice>
//<choice value="6">6 - six</choice>
//</choices>
//</field>
//</result>
//</response>

@end
