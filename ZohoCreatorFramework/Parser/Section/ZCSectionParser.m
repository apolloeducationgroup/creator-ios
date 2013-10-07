//
//  ZCSectionParser.m
//  ZohoCreator
//
//  Created by Vishnukumar on 14/09/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import "ZCSectionParser.h"

/**** start of private interface for the current class ****/

@interface ZCSectionParser (hidden)

- (void) parseSectionXML;

@end

/**** end of private interface for the current class ****/

@implementation ZCSectionParser

@synthesize zcSections = _zcSections;

- (ZCSectionParser*) initZCSectionParser:(NSString *)xmlString : (ZCApplication*) _app
{
    self = [super init];
    if(self) {
        self->_xmlString = xmlString;
        self->_sectionsElement = SECTIONS_NONE;
        self->_baseElement=
        self->_sectionElement=SECTION_NONE;
        self->_application = _app;
    }
    [self parseSectionXML];    
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
        
    self->_zcSections = [[ZCSections alloc] initZCSections];
    columnDict = [[NSMutableDictionary alloc]init];
    rowsDict = [[NSMutableDictionary alloc]init];
    sectionsArray = [[NSMutableArray alloc]init];
    sectionsDict = [[NSMutableDictionary alloc]init];
    layoutType = ZCLayoutCreator;
    /*
     ZCLayoutCreator = 1,
     ZCLayoutSliderMenu = 2,
     ZCLayoutTapBar = 3,
     ZCLayoutTapMenuBottom = 4,
     ZCLayoutTapMenuTop = 5,
     ZCLayoutPlainList = 6,
     */
    columnsArray = [[NSMutableArray alloc]init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {

    if(_baseElement==BASE_SECTIONS) {
        
        if(_sectionElement==SECTION_SECTION) {
            
            if([elementName isEqualToString:@"Component"])  {
                _sectionElement = SECTION_COMPONENT;
                _zcComponent = [[ZCComponent alloc] init];
                [_zcComponent setZcApplication:_application];
                NSString *componentType = [attributeDict valueForKey:@"type"];
                if([componentType isEqualToString:@"form"]) {
                    [columnDict setObject:[NSNumber numberWithInt:[ZCComponent COMPONENT_FORM]] forKey:@"type"];
                    [_zcComponent setType:[ZCComponent COMPONENT_FORM]];
                }
                else if([componentType isEqualToString:@"view"]) {
                    [columnDict setObject:[NSNumber numberWithInt:[ZCComponent COMPONENT_VIEW]] forKey:@"type"];
                    [_zcComponent setType:[ZCComponent COMPONENT_VIEW]];
                }
                else if([componentType isEqualToString:@"calendar"]) {
                    [columnDict setObject:[NSNumber numberWithInt:[ZCComponent COMPONENT_CALENDAR]] forKey:@"type"];
                    [_zcComponent setType:[ZCComponent COMPONENT_CALENDAR]];
                }
                else if([componentType isEqualToString:@"html"]) {
                    [columnDict setObject:[NSNumber numberWithInt:[ZCComponent COMPONENT_HTML]] forKey:@"type"];
                    [_zcComponent setType:[ZCComponent COMPONENT_HTML]];
                }
            }
        }
        else
        {
            if([elementName isEqualToString:@"Section"]) {
                if (layoutType==ZCLayoutCreator || layoutType==ZCLayoutGroupedList || layoutType==ZCLayoutSliderMenu || layoutType == ZCLayoutTapBar || layoutType == ZCLayoutTapMenuBottom || layoutType==ZCLayoutTapMenuTop) columnsArray = [[NSMutableArray alloc]init];
                _sectionsElement = SECTIONS_SECTION;
                _sectionElement = SECTION_SECTION;
                _zcSection = [[ZCSection alloc] initZCSection];
            }
        }
    }
    else
    {
        if([elementName isEqualToString:@"Sections"])  {
            _baseElement = BASE_SECTIONS;
        }
    }
    _currentElementName = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(_sectionsElement==SECTIONS_SECTION) {
        
        if(_sectionElement==SECTION_SECTION) {
         
            if([_currentElementName isEqualToString:@"Display_Name"]) {
                [sectionsDict setObject:string forKey:@"sectionDisplayName"];
                [_zcSection setSectionDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
            }
            else if([_currentElementName isEqualToString:@"Link_Name"]) {
                [sectionsDict setObject:string forKey:@"sectionLinkName"];
                [_zcSection setSectionLinkName:string];
            }
            else if([_currentElementName isEqualToString:@"Section_ID"]) {
                [_zcSection setSectionID:string];
            }
            else if([_currentElementName isEqualToString:@"Sequence_Number"]) {
                [_zcSection setSequenceNumber:[string integerValue]];
            }
            else if([_currentElementName isEqualToString:@"Is_Hidden"]) {
                //NSLog(@"hidden  %@",string);
                if([string isEqualToString:@"true"]) {
                    [_zcSection setIsHidden:YES];
                    //NSLog(@"Setting YES");
                }
                else
                {
                    [_zcSection setIsHidden:NO];
                    //NSLog(@"Setting NO");
                }
            }
        }
        else if(_sectionElement==SECTION_COMPONENT) {
            
            if([_currentElementName isEqualToString:@"Display_Name"]) {
                [columnDict setObject:string forKey:@"name"];
                [_zcComponent setDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:decodeUIChar] encoding:NSUTF8StringEncoding]];
            }
            else if([_currentElementName isEqualToString:@"Link_Name"]) {
                [columnDict setObject:string forKey:@"link"];
                [_zcComponent setLinkName:string];
            }
        }
    }
    ////// //NSLog(@"Coming out");
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    if([elementName isEqualToString:@"Section"]){
        if([[_zcSection componentList] count] != 0) {
            if (layoutType==ZCLayoutCreator || layoutType==ZCLayoutSliderMenu|| layoutType == ZCLayoutTapBar || layoutType == ZCLayoutTapMenuBottom || layoutType==ZCLayoutTapMenuTop)
            {
            NSMutableArray *rowsArray = [[NSMutableArray alloc]init];
            NSMutableDictionary *columnsDict = [[NSMutableDictionary alloc]init];
            [columnsDict setObject:columnsArray forKey:@"columns"];
            [rowsArray addObject:columnsDict];
            NSMutableArray *bodyArray =[[NSMutableArray alloc]init];
            [sectionsDict setObject:bodyArray forKey:@"body"];
            NSMutableDictionary *sectionDict = [[NSMutableDictionary alloc]init];
            [sectionDict setObject:rowsArray forKey:@"rows"];
            [bodyArray addObject:sectionDict];
            [sectionsArray addObject:[sectionsDict mutableCopy]];
            }
            [_zcSections addZCSection:_zcSection];
        }
        _sectionElement= SECTIONS_NONE;
    }
    if([elementName isEqualToString:@"Component"])
    {
     
        if (layoutType==ZCLayoutCreator || layoutType==ZCLayoutSliderMenu || layoutType == ZCLayoutTapBar || layoutType == ZCLayoutTapMenuBottom || layoutType==ZCLayoutTapMenuTop)
        {
            [columnsArray addObject:[columnDict mutableCopy]];
        }
        else if (layoutType==ZCLayoutPlainList)
        {
            [columnsArray addObject:[columnDict mutableCopy]];
        }
        
        
        if([_zcComponent type] == [ZCComponent COMPONENT_FORM] || [_zcComponent type] == [ZCComponent COMPONENT_VIEW] || [_zcComponent type] == [ZCComponent COMPONENT_CALENDAR] || [_zcComponent type] == [ZCComponent COMPONENT_HTML]) {
            [_zcSection addZCComponent:_zcComponent];
        }
       _sectionElement= SECTION_SECTION;
    }    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    [jsonDict setObject:[NSNumber numberWithInt:layoutType] forKey:@"layout_type"];
    [_zcSections setJsonDict:jsonDict];
   
    if (layoutType==ZCLayoutCreator || layoutType==ZCLayoutSliderMenu || layoutType == ZCLayoutTapBar || layoutType == ZCLayoutTapMenuBottom || layoutType==ZCLayoutTapMenuTop)
    {
        
         [jsonDict setObject:sectionsArray forKey:@"sections"];
    }
    else if (layoutType==ZCLayoutPlainList)
    {
        NSMutableArray *rowsArray = [[NSMutableArray alloc]init];
        NSMutableDictionary *columnsDict = [[NSMutableDictionary alloc]init];
        [columnsDict setObject:columnsArray forKey:@"columns"];
        [rowsArray addObject:columnsDict];
        NSMutableArray *bodyArray =[[NSMutableArray alloc]init];
        [jsonDict setObject:bodyArray forKey:@"body"];
        NSMutableDictionary *sectionDict = [[NSMutableDictionary alloc]init];
        [sectionDict setObject:rowsArray forKey:@"rows"];
        [bodyArray addObject:sectionDict];
    }
    NSLog(@"Response ::: Rows Array %@",jsonDict);
    
    
}

@end


/****
 
 start of private implementation for the current class
 
 ****/

@implementation ZCSectionParser (hidden)

- (void) parseSectionXML  {
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
