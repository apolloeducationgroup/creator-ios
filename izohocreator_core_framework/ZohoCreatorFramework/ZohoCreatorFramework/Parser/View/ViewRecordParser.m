//
//  ViewRecordParser.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ViewRecordParser.h"

@interface ViewRecordParser (hidden)

- (void) viewRecordParserXML;

@end

@implementation ViewRecordParser

@synthesize zcRecords=_zcRecords,zcView=_zcView;

- (ViewRecordParser*) initViewRecordParser:(NSString *) xmlString  : (ZCComponent*) component {
    
    self = [super init];
    if (self) {
        
        //        ////// //NSLog(@"view XML Riyaz %@",xmlString);
        
        isGrouped = NO;
        _zcGroups = [[ZCGroups alloc] initWithZCGroups];
        _userDateFormat = [[NSDateFormatter alloc] init];
        [_userDateFormat setDateFormat:@"MM/dd/yyyy"];
        [_userDateFormat setDefaultDate:[NSDate date]];
        
        _userDateTimeFormat = [[NSDateFormatter alloc] init];
        [_userDateTimeFormat setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
        [_userDateTimeFormat setDefaultDate:[NSDate date]];
        self->_xmlString = xmlString;
        self->_zcView = [ParserUtil convertToZCView:component];
    }
    [self viewRecordParserXML];
    return self;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser  {
    
    self->_zcRecords = [[ZCRecords alloc] initZCRecords];
    self->_zcCalendarEvents = [[ZCCalendarEvents alloc] initZCCalendarEvents];
    _columnTagEnabled = NO;
    _valueTagEnabled = NO;
    _recordTagEnabled = NO;
    _metaDataTagEnabled=NO;
    _metaDataFieldsEnabled=NO;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict   {
    
    _currentElementName = elementName;
    if(_metaDataTagEnabled==YES) {
        
        if(_metaDataFieldsEnabled==YES) {
            
            if([elementName isEqualToString:@"Field"]) {
                
                _zcViewFied = [[ZCViewField alloc] init];
                //                [_zcViewFied setFieldDisplayName:[NSString stringWithCString:[[attributeDict objectForKey:@"DisplayName"] cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
                [_zcViewFied setFieldLinkName:[attributeDict objectForKey:@"BaseLabelName"]];
                [_zcViewFied setFieldType:[ZCFieldList getFieldInteger:[attributeDict objectForKey:@"ComponentType"]]];
                NSString *viewOrder = [attributeDict objectForKey:@"viewOrder"];
                [_zcViewFied setViewOrder:[viewOrder integerValue]];
                NSString *sequenceNumber = [attributeDict objectForKey:@"SequenceNumber"];
                [_zcViewFied setSequenceNumber:[sequenceNumber integerValue]];
            }
            _fieldTagEnabled = YES;
        }
        else if(_metaDataFiltersEnabled==YES) {
            
            if([elementName isEqualToString:@"filter"]) {
                filter = [[ZCViewFilter alloc] initZCViewFilter];
                [filter setFilterName:[attributeDict valueForKey:@"name"]];
                //                [filter setFilterDisplayName:[attributeDict valueForKey:@"displayname"]];
                _filterValueList = [[NSMutableArray alloc] init];
            }
        }
        else if(_metaDataCustomFiltersEnabled==YES) {
            if([elementName isEqualToString:@"customFilter"]) {
                customFilter = [[ZCViewCustomFilter alloc ] init];
                [customFilter setFilterID:[attributeDict valueForKey:@"Id"]];
                
                
                
                
                
            }
        }
        else if(_metaDataActionsEnabled == YES) {
            
            if([elementName isEqualToString:@"Action"]) {
                _viewAction = [[ZCViewAction alloc] init];
                //                [_viewAction setActionName:[attributeDict valueForKey:@"name"]];
                [_viewAction setFunctionName:[attributeDict valueForKey:@"id"]];
                
                NSString *actionTyepStr = [attributeDict valueForKey:@"type"];
                if([actionTyepStr isEqualToString:@"row"]) {
                    [_viewAction setActionType:ZCViewActionTypeRecord];
                    [_rowActions addObject:_viewAction];
                    //// //NSLog(@"Added as row action");
                }
                else if([actionTyepStr isEqualToString:@"view"]) {
                    [_viewAction setActionType:ZCViewActionTypeHeader];
                    [_headerActions addObject:_viewAction];
                }
            }
        }
        else
        {
            if([elementName isEqualToString:@"View"]) {
                _viewTagEnabled = YES;
                //                [attributeDict objectForKey:@"LinkName"];
            }
            else if([elementName isEqualToString:@"BaseForm"]) {
                [_zcView setBaseForm:[attributeDict objectForKey:@"linkname"]];
            }
            else if([elementName isEqualToString:@"Fields"]) {
                _metaDataFieldsEnabled = YES;
            }
            else if([elementName isEqualToString:@"filters"]) {
                _metaDataFiltersEnabled = YES;
                filterList = [[NSMutableArray alloc] init];
            }
            else if([elementName isEqualToString:@"customFilters"]) {
                _metaDataCustomFiltersEnabled = YES;
                customFilterList = [[NSMutableArray alloc] init];
            }
            else if([elementName isEqualToString:@"permissions"]) {
                //// //NSLog(@"Coming to permission");
                NSString *add = [attributeDict valueForKey:@"add"];
                if([add isEqualToString:@"true"]) {
                    [_zcView setHasAddPermission:YES];
                }
                else {
                    [_zcView setHasAddPermission:NO];
                }
                NSString *edit = [attributeDict valueForKey:@"edit"];
                if([edit isEqualToString:@"true"]) {
                    [_zcView setHasEditPermission:YES];
                }
                else
                {
                    [_zcView setHasEditPermission:FALSE];
                }
                NSString *delete = [attributeDict valueForKey:@"delete"];
                if([delete isEqualToString:@"true"]) {
                    [_zcView setHasDeletePermission:YES];
                }
                else
                {
                    [_zcView setHasDeletePermission:FALSE];
                }
                NSString *duplicate = [attributeDict valueForKey:@"duplicate"];
                if([duplicate isEqualToString:@"true"]) {
                    [_zcView setHasDupplicatePermission:YES];
                }
                else
                {
                    [_zcView setHasDupplicatePermission:FALSE];
                }
                NSString *bulkedit = [attributeDict valueForKey:@"bulkedit"];
                if([bulkedit isEqualToString:@"true"]) {
                    [_zcView setHasBulkEditPermission:YES];
                }
                else
                {
                    [_zcView setHasBulkEditPermission:FALSE];
                }
            }
            else if([elementName isEqualToString:@"Actions"]) {
                
                //// //NSLog(@"vishnu parser Actions");
                _metaDataActionsEnabled=YES;
                _rowActions = [[NSMutableArray alloc] init];
                _headerActions = [[NSMutableArray alloc] init];
            }
        }
    }
    else if(_recordTagEnabled == YES) {
        
        if(_columnTagEnabled == YES)  {
            
            if([elementName isEqualToString:@"value"]) {
                _valueTagEnabled = YES;
            }
        }
        else
        {
            if([elementName isEqualToString:@"column"]) {
                _zcFieldData = [[ZCFieldData alloc] init];
                [_zcFieldData setFieldName:[attributeDict valueForKey:@"name"]];
                _columnTagEnabled = YES;
            }
        }
    }
    else
    {
        if([elementName isEqualToString:@"metadata"]) {
            _metaDataTagEnabled = YES;
        }
        else if([elementName isEqualToString:@"records"]) {
            //////// //NSLog(@"Coming to initialize recordsssss");
            _zcRecords = [[ZCRecords alloc] initZCRecords];
        }
        if([elementName isEqualToString:@"record"]) {
            //////// //NSLog(@"Record Tag Coming :::%@", [attributeDict objectForKey:@"id"]);
            _recordTagEnabled = YES;
            _zcRecord = [[ZCRecord alloc] initZCRecord];
            [_zcRecord setRecordID:[attributeDict objectForKey:@"id"]];
            
            BOOL isGroupStart = NO;
            for (NSString *column in attributeDict) {
                if ([column hasPrefix:@"group_"]) {
                    isGrouped = YES;
                    if (isGroupStart == NO) {
                        isGroupStart = YES;
                        if (_zcGroup != nil) {
                            [_zcGroups addZCGroup:_zcGroup];
                        }
                        _zcGroup = [[ZCGroup alloc] initWithZCGroup];
                    }
                    ZCFieldData *fielddata = [[ZCFieldData alloc] init];
                    [fielddata setFieldName:[column substringFromIndex:6]];
                    [fielddata setFieldValue:[attributeDict objectForKey:column]];
                    [_zcGroup addZCGroupFields:fielddata];
                }
            }
        }
        else if([elementName isEqualToString:@"calendar"]) {
            _calendarTagEnabled = YES;
            self->_zcCalendarEvents = [[ZCCalendarEvents alloc] initZCCalendarEvents];
            [_zcView setBaseField:[attributeDict valueForKey:@"start"]];
            //  [_zcView setViewDisplayField:[attributeDict valueForKey:@"title"]];
        }
        else if([elementName isEqualToString:@"group"]) {
            isGrouped = YES;
            if(_zcGroup != nil) {
                [_zcGroups addZCGroup:_zcGroup];
            }
            _zcGroup = [[ZCGroup alloc] initWithZCGroup];
        }
        
        if([elementName isEqualToString:@"column"]) {
            
            _groupNameEnabled = YES;
            _groupByNameFields = [[ZCFieldData alloc] init];
            [_groupByNameFields setFieldName:[attributeDict objectForKey:@"name"]];
        }
        if([elementName isEqualToString:@"event"]) {
            
            _eventTagEnabled = YES;
            NSString *startTime = @"all-day";
            NSString *endTime = @"all-day";
            
            NSDateFormatter *_timeDateFormat = [[NSDateFormatter alloc] init];
            [_timeDateFormat setDateFormat:@"HH:mm a"];
            
            NSDate *startDate = [_userDateFormat dateFromString:[attributeDict valueForKey:@"start"]];
            if(startDate == Nil)
            {
                startDate = [_userDateTimeFormat dateFromString:[attributeDict valueForKey:@"start"]];
                startTime = [_timeDateFormat stringFromDate:startDate];
            }
            NSDate *endDate = [startDate copy];
            if([attributeDict valueForKey:@"end"] != Nil)
            {
                endDate = [_userDateFormat dateFromString:[attributeDict valueForKey:@"end"]];
                if(endDate == Nil)
                {
                    endDate = [_userDateTimeFormat dateFromString:[attributeDict valueForKey:@"end"]];
                    endTime = [_timeDateFormat stringFromDate:endDate];
                }
            }
            
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDateComponents *startcomp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
                                                           NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
                                                 fromDate:startDate];
            NSDateComponents *endcomp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
                                                         NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
                                               fromDate:endDate];
            
            if ([startcomp year] == [endcomp year] && [startcomp month] == [endcomp month] && [startcomp day] == [endcomp day])
            {
                _zcCalendarEvent = [[ZCCalendarEvent alloc] init];
                [_zcCalendarEvent setZcRecord:[_zcView.records getZCRecord:[attributeDict valueForKey:@"id"]]];
                [_zcCalendarEvent setStart:startDate];
                [_zcCalendarEvent setEnd:endDate];
                //                [_zcCalendarEvent setTitle:[attributeDict valueForKey:@"title"]];
                [_zcCalendarEvent setEventType:[ZCCalendarEvent EVENT_SHORT]];
                if ([[attributeDict valueForKey:@"allDay"] boolValue]) {
                    [_zcCalendarEvent setEventType:[ZCCalendarEvent EVENT_ALLDAY]];
                    [_zcCalendarEvent setSubTitle:@"all-day"];
                }
                else
                {
                    [_zcCalendarEvent setEventType:[ZCCalendarEvent EVENT_SHORT]];
                    [_zcCalendarEvent setSubTitle:startTime];
                }
                [_zcCalendarEvents addZCCalendarEvent:_zcCalendarEvent];
            }
            else
            {
                NSDate *checkDate = [startDate copy];
                NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
                [offsetComponents setDay:1];
                while (YES) {
                    NSComparisonResult result = [checkDate compare:endDate];
                    if (result == NSOrderedDescending)
                    {
                        break;
                    }
                    _zcCalendarEvent = [[ZCCalendarEvent alloc] init];
                    NSDate *modStartDate = [checkDate copy];
                    NSDate *modEndDate = [checkDate copy];
                    NSString *subTitle = @"all-day";
                    NSInteger eventType = [ZCCalendarEvent EVENT_ALLDAY];
                    BOOL isEvent = YES;
                    
                    NSString *modStartStr = [_userDateFormat stringFromDate:modStartDate];
                    NSString *modEndStr = [_userDateFormat stringFromDate:modEndDate];
                    
                    NSDateComponents *checkdatecomp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit |
                                                                       NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit)
                                                             fromDate:checkDate];
                    
                    if ([[attributeDict valueForKey:@"allDay"] boolValue]) {
                        
                        modStartDate = [_userDateTimeFormat dateFromString:[NSString stringWithFormat:@"%@ 00:00:00", modStartStr]];
                        modEndDate = [_userDateTimeFormat dateFromString:[NSString stringWithFormat:@"%@ 23:59:59", modEndStr]];
                    }
                    else
                    {
                        if ([checkdatecomp year] == [startcomp year] && [checkdatecomp month] == [startcomp month] && [checkdatecomp day] == [startcomp day])
                        {
                            
                            if ([startTime isEqualToString:@"00:00 AM"]) {
                                eventType = [ZCCalendarEvent EVENT_ALLDAY];
                            }
                            else
                            {
                                eventType = [ZCCalendarEvent EVENT_LONG_STARTS];
                                subTitle = startTime;
                            }
                            
                            modEndDate = [_userDateTimeFormat dateFromString:[NSString stringWithFormat:@"%@ 23:59:59", modEndStr]];
                        }
                        else if ([checkdatecomp year] == [endcomp year] && [checkdatecomp month] == [endcomp month] && [checkdatecomp day] == [endcomp day])
                        {
                            
                            if ([endTime isEqualToString:@"11:59 AM"]) {
                                eventType = [ZCCalendarEvent EVENT_ALLDAY];
                            }
                            else
                            {
                                eventType = [ZCCalendarEvent EVENT_LONG_ENDS];
                                subTitle = endTime;
                            }
                            if ([endTime isEqualToString:@"00:00 AM"]) {
                                isEvent = NO;
                            }
                            subTitle = endTime;
                            modStartDate = [_userDateTimeFormat dateFromString:[NSString stringWithFormat:@"%@ 00:00:00", modStartStr]];
                        }
                        else
                        {
                            subTitle = @"all-day";
                        }
                    }
                    
                    if (isEvent) {
                        [_zcCalendarEvent setZcRecord:[_zcView.records getZCRecord:[attributeDict valueForKey:@"id"]]];
                        [_zcCalendarEvent setStart:modStartDate];
                        [_zcCalendarEvent setEnd:modEndDate];
                        //    [_zcCalendarEvent setTitle:[attributeDict valueForKey:@"title"]];
                        [_zcCalendarEvent setSubTitle:subTitle];
                        [_zcCalendarEvent setEventType:eventType];
                        [_zcCalendarEvents addZCCalendarEvent:_zcCalendarEvent];
                    }
                    
                    checkDate = [cal dateByAddingComponents:offsetComponents toDate:checkDate options:0];
                }
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(_valueTagEnabled == YES) {
        //////// //NSLog(@"Coming to add field value  %@",string);
        
        if(string != nil && ![string isEqualToString:@""]) {
            
            char starChar =  [string characterAtIndex:0];
            char endChar = [string characterAtIndex:[string length]-1];
            if(starChar == '[' && endChar == ']') {
                NSRange range;
                range.location = 1;
                range.length = [string length] - 2;
                NSString *tempString = [string substringWithRange:range];
                //// //NSLog(@"ZCField Name %@   %@",[_zcFieldData fieldName],string);
                if(![tempString isEqualToString:@""]) {
                    NSMutableArray *optionArray = [NSMutableArray arrayWithArray:[tempString componentsSeparatedByString: @","]];
                    [_zcFieldData setFieldValue:optionArray];
                }
            }
            else {
                
                if([string isEqualToString:@"&nbsp;"]) {
                    string = @"";
                }
                ZCViewField *viewField = [_zcView getField:[_zcFieldData fieldName]];
                NSString *correctString = [NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
                if([viewField fieldType] == [ZCFieldList ZCEmail]) {
                    correctString = [ParserUtil extractEmailFromLink:correctString];
                }
                [_zcFieldData setFieldValue:correctString];
            }
        }
    }
    else if(_metaDataFiltersEnabled == YES) {
        if([_currentElementName isEqualToString:@"displayname"]) {
            [filter setFilterDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
        }
        else {
            NSRange startIndex = [string rangeOfString:@":"];
            [_filterValueList addObject:[string substringFromIndex:startIndex.location+1]];
        }
    }
    else if(_metaDataCustomFiltersEnabled==YES) {
        if([_currentElementName isEqualToString:@"DisplayName"]) {
            [customFilter setDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
            
        }
    }
    else if(_metaDataActionsEnabled==YES) {
        [_viewAction setActionName:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
    }
    else if(_fieldTagEnabled==YES) {
        if([_currentElementName isEqualToString:@"DisplayName"]) {
            [_zcViewFied setFieldDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
        }
    }
    else if(_calendarTagEnabled==YES) {
        if(_eventTagEnabled==YES) {
            if([_currentElementName isEqualToString:@"title"])  {
                [_zcCalendarEvent setTitle:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
            }
        }
    }
    else if(_groupNameEnabled==YES) {
        [_groupByNameFields setFieldValue:string];
    }
    else if(_viewTagEnabled==YES) {
        
        if([_currentElementName isEqualToString:@"DisplayName"])
        {
            [_zcView setViewDisplayName:[NSString stringWithCString:[string cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding]];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if(_metaDataTagEnabled==YES) {
        
        if(_metaDataFieldsEnabled==YES) {
            
            if([elementName isEqualToString:@"Field"]) {
                [_zcView addZCViewField:_zcViewFied];
                _fieldTagEnabled = NO;
            }
            else
            {
                if([elementName isEqualToString:@"Fields"]) {
                    _metaDataFieldsEnabled=NO;
                }
            }
        }
        else if(_metaDataFiltersEnabled==YES) {
            
            if([elementName isEqualToString:@"filter"]) {
                [filter setFilterValues:_filterValueList];
                [filterList addObject:filter];
            }
            else if([elementName isEqualToString:@"filters"]) {
                _metaDataFiltersEnabled = NO;
                [_zcView setFilterList:filterList];
                ////// //NSLog(@"filters has set to view");
            }
        }
        else if(_metaDataCustomFiltersEnabled==YES) {
            if([elementName isEqualToString:@"customFilter"]) {
                
                [customFilterList addObject:customFilter];
                
            }
            else if([elementName isEqualToString:@"customFilters"]) {
                _metaDataCustomFiltersEnabled=NO;
                
                if(customFilterList != nil &&  [customFilterList count] > 0) {
                    customFilter = [[ZCViewCustomFilter alloc] init];
                    [customFilter setDisplayName:@"All Records"];
                    [customFilter setFilterID:nil];
                    [customFilterList insertObject:customFilter atIndex:0];
                }
                
                [_zcView setCustomFilterList:customFilterList];
            }
        }
        else if(_metaDataActionsEnabled==YES) {
            if([elementName isEqualToString:@"Actions"]) {
                _metaDataActionsEnabled = NO;
                
                /*                ZCViewAction *action = [[ZCViewAction alloc] init];
                 [action setActionName:@"MyFunction1"];
                 [action setActionType:ZCViewActionTypeHeader];
                 [_headerActions addObject:action];
                 [action setActionType:ZCViewActionTypeRecord];
                 [_rowActions addObject:action];
                 
                 ZCViewAction *action1 = [[ZCViewAction alloc] init];
                 [action1 setActionName:@"MyFunction2"];
                 [action1 setActionType:ZCViewActionTypeHeader];
                 [_headerActions addObject:action1];
                 [action1 setActionType:ZCViewActionTypeRecord];
                 [_rowActions addObject:action1]; */
                
                //// //NSLog(@"row action count %d",[_rowActions count]);
                //// //NSLog(@"Added to row action to view");
                
                [_zcView setRowAction:_rowActions];
                [_zcView setHeaderAction:_headerActions];
                
            }
            else if([elementName isEqualToString:@"Action"]) {
                
            }
            else if(_viewTagEnabled==YES) {
                if([elementName isEqualToString:@"View"]) {
                    _viewTagEnabled = NO;
                }
            }
        }
        else {
            if([elementName isEqualToString:@"metadata"]) {
                _metaDataTagEnabled = NO;
            }
        }
    }
    else if(_recordTagEnabled == YES) {
        
        if(_columnTagEnabled == YES) {
            
            if([elementName isEqualToString:@"value"]) {
                _valueTagEnabled = NO;
            }
            else if([elementName isEqualToString:@"column"]) {
                
                _columnTagEnabled = NO;
                ZCViewField *tempField = [_zcView getField:[_zcFieldData fieldName]];
                if([tempField fieldType] == 20 )  //Image
                {
                    
                    // //NSLog(@"Image Value %@",[_zcFieldData fieldValue]);
                    [_zcFieldData setFieldValue:[ParserUtil getImageLocation:[_zcFieldData fieldValue]]];
                }
                else if([tempField fieldType] == 21)  //URL
                {
                    [_zcFieldData setFieldValue:[ParserUtil getURLString:[_zcFieldData fieldValue]]];
                }
                /*                else if([tempField fieldType] == [ZCFieldList ZCFileupload]) {
                 
                 // //NSLog(@"Fileupload Data %@",[_zcFieldData fieldValue]);
                 NSMutableDictionary *filePaths = [ParserUtil getURLString:[_zcFieldData fieldValue]];
                 // //NSLog(@"File Paths %@",filePaths);
                 // //NSLog(@"File Path %@",[filePaths objectForKey:@"url"]);
                 
                 //                    [_zcFieldData setFieldValue:];
                 } */
                [_zcRecord addZCFieldData:_zcFieldData];
            }
        }
        else
        {
            //////// //NSLog(@"elemenet name %@",elementName);
            if([elementName isEqualToString:@"record"]) {
                _recordTagEnabled = NO;
                //////// //NSLog(@"Recprd had added");
                [_zcRecords addZCRecord:_zcRecord];
                [_zcGroup addZCRecordInGroup:_zcRecord];
            }
        }
    }
    else
    {
        if([elementName isEqualToString:@"records"]) {
            //////// //NSLog(@"Coming to Add Records");
            [_zcView setRecords:_zcRecords];
            if (_zcRecord.recordID != nil) {
                // [_zcView setViewDisplayField:[_zcRecord getFieldDataByIndex:0].fieldName];
            }
            
            if (isGrouped) {
                [_zcGroups addZCGroup:_zcGroup];
                [_zcView setZcGroups:_zcGroups];
            }
        }
        else if ([elementName isEqualToString:@"calendar"])
        {
            _calendarTagEnabled = NO;
            NSArray *allDates = [[_zcCalendarEvents.eventsForDate allKeys] sortedArrayUsingComparator:^(id obj1, id obj2)
                                 {
                                     NSDate *dateOne = [_userDateFormat dateFromString:obj1];
                                     NSDate *dateTwo = [_userDateFormat dateFromString:obj2];
                                     switch ([dateOne compare:dateTwo])
                                     {
                                         case NSOrderedAscending:
                                             return NSOrderedDescending;
                                         case NSOrderedSame:
                                             return NSOrderedSame;
                                         case NSOrderedDescending:
                                             return NSOrderedAscending;
                                     }
                                 }];
            for (NSString *datekey in allDates) {
                _zcGroup = [[ZCGroup alloc] initWithZCGroup];
                ZCFieldData *fielddata = [[ZCFieldData alloc] init];
                [fielddata setFieldName:[NSString stringWithFormat:@"%@==>EventDate", _zcView.viewLinkName]];
                [fielddata setFieldValue:[ZCCalendarEvents getDateDisplayValue:datekey]];
                [_zcGroup addZCGroupFields:fielddata];
                NSMutableArray *zcEvents = [_zcCalendarEvents.eventsForDate objectForKey:datekey];
                for (ZCCalendarEvent *event in zcEvents) {
                    [_zcGroup addZCRecordInGroup:event.zcRecord];
                }
                [_zcGroups addZCGroup:_zcGroup];
            }
            [_zcView setZcGroups:_zcGroups];
            _zcRecords = [[ZCRecords alloc] initZCRecords];
            for (ZCGroup *zcGrp in _zcGroups.zcGroups) {
                
                for (ZCRecord *zcRrd in zcGrp.zcRecords) {
                    [_zcRecords addZCRecord:zcRrd];
                }
            }
            [_zcView setRecords:_zcRecords];
            [_zcView setEvents:_zcCalendarEvents];
        }
        else if([elementName isEqualToString:@"column"]) {
            
            _groupNameEnabled = NO;
            [_zcGroup addZCGroupFields:_groupByNameFields];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

@end

/****
 
 private implementation
 
 ****/

@implementation ViewRecordParser (hidden)

- (void) viewRecordParserXML  {
    
    _xmlParser = [[NSXMLParser alloc] initWithData:[_xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    [_xmlParser setDelegate:self];
    [_xmlParser setShouldProcessNamespaces:NO];
    [_xmlParser setShouldReportNamespacePrefixes:NO];
    [_xmlParser setShouldResolveExternalEntities:NO];
    [_xmlParser parse];
}

@end
