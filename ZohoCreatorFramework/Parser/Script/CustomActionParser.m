//
//  CustomActionParser.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 23/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "CustomActionParser.h"
#import "ScriptParser.h"

@interface CustomActionParser (hidden)

- (void) parseScriptXML;

@end

@implementation CustomActionParser

@synthesize customResponse=_customResponse;

- (CustomActionParser*) initScriptParser:(NSString *)xmlString
{
    self = [super init];
    if(self) {
        
        self->_customResponse = [[CustomActionResponse alloc] init];
        self->_failureList = [[NSMutableArray alloc] init];
        self->_successList = [[NSMutableArray alloc] init];
        self->_customResponse = [[CustomActionResponse alloc] init];
        self->_xmlString=[self getstringafterDelugeTAskXML:xmlString];
    }
    [self parseScriptXML];
    return self;
}
-(NSString *)getstringafterDelugeTAskXML:(NSString *)xmlString
{
    
   xmlString =[xmlString stringByReplacingOccurrencesOfString:@"<GenerateJS><![CDATA[" withString:@"<GenerateJS>"];
    xmlString =[xmlString stringByReplacingOccurrencesOfString:@"</tasks>]]>" withString:@"</tasks>"];
    
    

        NSRange start = [xmlString rangeOfString:@"<GenerateJS>"];
        NSRange end = [xmlString rangeOfString:@"</GenerateJS>"];
        
        NSRange target;
        
        target.location = start.location+start.length;
        
        //NSLog@"start %@ end %@",NSStringFromRange(start),NSStringFromRange(end));
        
        if (!start.length == 0 && end.length!=0 )
            
        {
            
            
            target.length = end.location - target.location;
        }
        
        else
            
        {
            
            target.length = 0 ;
            
        }
        
        if (start.location!=NSNotFound) {
            
            
            
            target.location=start.location+start.length;
            
            
            
            
            //NSLog@"title length value is :%d",target.length);
            
            
            //NSLog@"title gee %@",[xmlString substringWithRange:target]);
            
            NSString * substringTasksXML=[xmlString substringWithRange:target];
            
            ScriptParser * sParse=[[ScriptParser alloc]initScriptParser:substringTasksXML];
            [_customResponse setDelugeTasks:[sParse delugeTasks]];
            //NSLog@"deluge task after parse in custom action %@",[sParse delugeTasks].taskList);
            
            
            xmlString =[xmlString stringByReplacingOccurrencesOfString:substringTasksXML withString:@""];

        }
    
    
    
        
    return xmlString;
    
        
        
    }

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    //NSLog@"did start element name : %@",elementName);
    
    if(_failureElement==YES) {
        
        if([elementName isEqualToString:@"Failure"]) {
            
            _customActionResult = [[CustomActionResult alloc] init];
            [_customActionResult setRecordId:[attributeDict valueForKey:@"recordid"]];
        }
    }
    else if(_successElement==YES) {
        
        if([elementName isEqualToString:@"Success"]) {
            
            _customActionResult = [[CustomActionResult alloc] init];
            [_customActionResult setRecordId:[attributeDict valueForKey:@"recordid"]];
        }
    }
    else {
        
        if([elementName isEqualToString:@"FailureRecords"]) {
            _failureElement = YES;
        }
        else if([elementName isEqualToString:@"SuccessRecords"]) {
            _successElement = YES;
        }
    }
    _currentElementName = elementName;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(_failureElement==YES) {
        
        if([_currentElementName isEqualToString:@"Msg"]) {
//            [_customActionResult setMessage:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
            [_customActionResult setMessage:string];

        }
    }
    else if(_successElement==YES) {
        
        if([_currentElementName isEqualToString:@"Info"]) {
//            [_customActionResult setMessage:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
            [_customActionResult setMessage:string];

        }
    }
    else {
        if([_currentElementName isEqualToString:@"ExecutionType"]) {
            [_customResponse setExecutionType:string];
        }
        else if([_currentElementName isEqualToString:@"SuccessMessage"]) {
            //// ////NSLog@"Coming to success message");
//            [_customResponse setSuccessMessage:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
            [_customResponse setSuccessMessage:string];
        }
        else if([_currentElementName isEqualToString:@"GenerateJS"]) {
//            [_customResponse setDelugeTasks:nil];
        }
        
        //NSLog@"g element name : %@ & value : %@",_currentElementName,string);
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //NSLog@"did end element name : %@",elementName);
    
    if(_failureElement==YES) {
        
        if ([elementName isEqualToString:@"Failure"]) {
            [_failureList addObject:_customActionResult];
                        //NSLog@"failure custom action %@",_failureList);

            
//            _failureElement=NO;
        }
        else if([elementName isEqualToString:@"FailureRecords"]) {
            _failureElement =NO;
//            //NSLog@"failure custom action %@",_customActionResult);
            //NSLog@"failure custom action %@",_failureList);
            [_customResponse setFailureRecordList:_failureList];
        }
    }
    else if(_successElement==YES) {
        
        if ([elementName isEqualToString:@"Success"]) {
            [_successList addObject:_customActionResult];
            _successElement = NO;
        }
        else if([elementName isEqualToString:@"SuccessRecords"]) {
            _successElement =NO;
            [_customResponse setSuccessRecordList:_successList];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

@end


@implementation CustomActionParser (hidden)

- (void) parseScriptXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}

@end
