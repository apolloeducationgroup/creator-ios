//
//  FormJSONParser.m
//  ZohoCreatorFramework
//
//  Created by Vishnu Kumar V on 25/10/13.
//  Copyright (c) 2013 ZohoCorp. All rights reserved.
//

#import "FormJSONParser.h"

@interface FormJSONParser(private)

- (void) convertJSONToZCForm;
- (void) getFormGeneralInfo : (NSDictionary*) formGeneralDict;
- (void) getButtonInfo : (NSArray*) _buttonRawList;
- (void) getFieldInfo : (NSArray*) fieldList : (ZCForm*) _localForm;

@end

@implementation FormJSONParser

@synthesize zcForm=_zcForm;

- (FormJSONParser*) initFormJSONParser : (NSString*) jsonString : (ZCApplication*) application {
    
    self = [super init];
    if(self) {
        _jsonString = jsonString;
        _application = application;
        _zcForm = [[ZCForm alloc] initZCForm];
        [self convertJSONToZCForm];
    }
    return self;
}

- (void) convertJSONToZCForm
{
    @try {
        NSLog(@"Coming to JSON Parser");
        NSData *jsonData = [_jsonString dataUsingEncoding:[NSString defaultCStringEncoding]];
        _jsonDictionary= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if(_jsonDictionary != nil) {
            NSLog(@"Coming inside");
            NSDictionary *_responseDict = [_jsonDictionary objectForKey:@"response"];
            [self getFormGeneralInfo:_responseDict];
            NSArray *_buttonRawList = [_responseDict objectForKey:@"buttons"];
            NSLog(@"_button Raw Info %@",[_buttonRawList class]);
            [self getButtonInfo:_buttonRawList];
            NSArray *_fieldRawList = [_responseDict objectForKey:@"fields"];
            NSLog(@"Coming to fetch getFieldInfo");
            [self getFieldInfo:_fieldRawList :_zcForm];
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"Exception occ %@",exception);
        
    }
}

- (void) getFormGeneralInfo  : (NSDictionary*) formGeneralDict {
    
    [_zcForm setSuccessMessage:[formGeneralDict objectForKey:@"successmessage"]];
    [_zcForm setLinkName:[formGeneralDict objectForKey:@"labelname"]];
    [_zcForm setDisplayName:[formGeneralDict objectForKey:@"displayname"]];
    [_zcForm setDateFormat:[formGeneralDict objectForKey:@"dateformat"]];
    id temp = [formGeneralDict valueForKey:@"hasaddonload"];
    NSLog(@"type of on laod %@",[temp class]);
    
    BOOL _hasOnLoad = [[formGeneralDict valueForKey:@"hasaddonload"] boolValue];
    [_zcForm setHasOnLoad:_hasOnLoad];
    
    /*
     NSLog(@"Cominf IOnnnnnnn");
     
     if([_hasOnLoad isEqualToString:@"0"]) {
     [_zcForm setHasOnLoad:NO];
     }
     else {
     [_zcForm setHasOnLoad:YES];
     }
     NSLog(@"Coming outtttt");
     
     */
    
    NSString *_formType = [formGeneralDict objectForKey:@"type"];
    if([_formType isEqualToString:@"1"]) {
        [_zcForm setIsStateful:YES];
    }
    else {
        [_zcForm setIsStateful:NO];
    }
    
    NSLog(@"json Dic %@",_jsonDictionary);
}


- (void) getButtonInfo : (NSArray*) _buttonRawList {
    
    
    for(NSInteger index=0;index<[_buttonRawList count];index++) {
        NSDictionary *_buttonDic = [_buttonRawList objectAtIndex:index];
        ZCButton *_button = [[ZCButton alloc] init];
        [_button setButtonName:[_buttonDic objectForKey:@"labelname"]];
        [_button setButtonDisplayName:[_buttonDic objectForKey:@"displayname"]];
        NSString *_buttonActType = [_buttonDic objectForKey:@"actiontype"];
        NSString *_buttonType =          [_buttonDic objectForKey:@"type"];
        NSString *_sequenceNum =          [_buttonDic objectForKey:@"sequencenumber"];
        [_button setButtonActionType:[_buttonActType integerValue]];
        NSInteger buttonInt = [_buttonType integerValue];
        [_button setButtonType:buttonInt];
        NSLog(@"button type %d",buttonInt);
        
        [_button setSequence:[_sequenceNum integerValue]];
        [_zcForm addZCButton:_button];
        NSLog(@"Button has added %@",[_button buttonDisplayName]);
    }
}

- (void) getFieldInfo : (NSArray*) _fieldRawList : (ZCForm*) _localForm {
    
    for(NSInteger index=0;index<[_fieldRawList count];index++) {
        
        ZCField *_field = [[ZCField alloc] initZCField];
        NSDictionary *_fieldDict = [_fieldRawList objectAtIndex:index];
        [_field setFieldDisplayName:[_fieldDict objectForKey:@"displayname"]];
        [_field setFieldName:[_fieldDict objectForKey:@"fieldname"]];
        [_field setInitialValues:[_fieldDict objectForKey:@"initial"]];
        [_field setToolTip:[_fieldDict objectForKey:@"tooltip"]];
        NSString *_fieldTypeRawString = [_fieldDict objectForKey:@"type"];
        [_field setFieldType:[_fieldTypeRawString integerValue]];
        
        BOOL _isUnique = [[_fieldDict valueForKey:@"required"] boolValue];
        [_field setIsRequired:_isUnique];
        _isUnique = [[_fieldDict valueForKey:@"unique"] boolValue];
        [_field setIsUnique:_isUnique];
        
        
        
        id tempValue = [_fieldDict objectForKey:@"maxchar"];
        if(tempValue != nil) {
            [_field setMaxCharacter:[tempValue integerValue]];
        }
        
        tempValue = [_fieldDict objectForKey:@"isadminonly"];
        if(tempValue != nil) {
            [_field setIsAdminOnly:[tempValue boolValue]];
        }
        
        tempValue = [_fieldDict objectForKey:@"onchangeexists"];
        if(tempValue != nil) {
            [_field setHasOnUserScript:[tempValue boolValue]];
        }
        
        
        tempValue = [_fieldDict objectForKey:@"onaddrowexists"];
        if(tempValue != nil) {
            [_field setHasSubFormAddEvent:[tempValue boolValue]];
        }
        tempValue = [_fieldDict objectForKey:@"ondeleterowexists"];
        if(tempValue != nil) {
            [_field setHasSubFormDeleteEvent:[tempValue boolValue]];
        }

        
        tempValue = [_fieldDict objectForKey:@"maximumrows"];
        if(tempValue != nil) {
            [_field setHasmaximumNumberOfRows:[tempValue integerValue]];
        }

        tempValue = [_fieldDict objectForKey:@"choices"];
        if(tempValue != nil) {
            
            for(NSInteger choiceIndex=0;choiceIndex<[tempValue count];choiceIndex++)
            {
                NSDictionary *choiceDic = [tempValue objectAtIndex:choiceIndex];
                [[_field optionkeys] addObject:[choiceDic objectForKey:@"key"]];
                [[_field options] addObject:[choiceDic objectForKey:@"value"]];
            }
        }
        
        tempValue = [_fieldDict objectForKey:@"islookupfield"];
        if(tempValue != nil) {
            [_field setIsLookupField:[tempValue boolValue]];
        }
        
        tempValue = [_fieldDict objectForKey:@"allownewentries"];
        if(tempValue != nil) {
            [_field setHasAllowNewEntries:[tempValue boolValue]];
        }
        
        tempValue = [_fieldDict objectForKey:@"allownewentriestext"];
        if(tempValue != nil) {
            [_field setAddNewLinkText:tempValue];
        }
        
        tempValue = [_fieldDict objectForKey:@"decimallength"];
        if(tempValue != nil) {
            [_field setDecimalLength:[tempValue integerValue]];
        }
        
        tempValue = [_fieldDict objectForKey:@"currencydisp"];
        if(tempValue != nil) {
            [_field setCurrencyDisplay:tempValue];
        }
        
        tempValue = [_fieldDict objectForKey:@"currencyname"];
        if(tempValue != nil) {
            [_field setCurrencyName:tempValue];
        }
        
        tempValue = [_fieldDict objectForKey:@"currencytype"];
        if(tempValue != nil) {
            [_field setCurrencyType:[tempValue integerValue]];
        }
        
        
        tempValue = [_fieldDict objectForKey:@"linknamereq"];
        if(tempValue != nil) {
            [_field setIsUrlLinkName:[tempValue boolValue]];
        }
        
        tempValue = [_fieldDict objectForKey:@"titlereq"];
        if(tempValue != nil) {
            [_field setIsUrlTitle:[tempValue boolValue]];
        }
        
        tempValue = [_fieldDict objectForKey:@"text"];
        if(tempValue != nil) {
            [_field setInitialValues:tempValue];
        }
        
        tempValue = [_fieldDict objectForKey:@"visiblity"];
        if(tempValue != nil) {
            [_field setHasVisiblity:[tempValue boolValue]];
        }
        
        tempValue = [_fieldDict objectForKey:@"visiblity"];
        if(tempValue != nil) {
            [_field setHasVisiblity:[tempValue boolValue]];
        }

        tempValue = [_fieldDict objectForKey:@"refapplication"];
        NSLog(@"ref application %@",tempValue);
        if(tempValue != nil) {
            ZCApplication *_refApp = [[ZCApplication alloc] init];
            [_refApp setAppDisplayName:tempValue];
            [_refApp setAppLinkName:tempValue];
            NSLog(@"Application Owner %@",[_application appOwner]);
            [_refApp setAppOwner:[_application appOwner]];
            tempValue = [_fieldDict objectForKey:@"refform"];
            ZCComponent *_relatedComp = [[ZCComponent alloc] init];
            [_relatedComp setZcApplication:_refApp];
            [_relatedComp setLinkName:tempValue];
            [_relatedComp setDisplayName:tempValue];
            [_field setRelatedComponent:_relatedComp];
        }
        
        tempValue = [_fieldDict objectForKey:@"subformfields"];
        if(tempValue != nil) {
            
            ZCForm *_subFormData = [[ZCForm alloc] initZCForm];
            [self getFieldInfo:tempValue :_subFormData];
            [_field setSubForm:_subFormData];
            NSLog(@"SubForm Data has added");
        }
        
        tempValue = [_fieldDict objectForKey:@"value"];
        if(tempValue != nil) {
            [_field setInitialValues:tempValue];
        }
        
        tempValue = [_fieldDict objectForKey:@"subformrecords"];
        if(tempValue != nil) {

            [_field setSubformRecords:[self getSubformRecords:tempValue]];

        
        }
        
        
        [_localForm addZCField:_field];
    }
    
    /*
     
     displayname = Image;
     fieldname = Image;
     initial = "";
     required = 0;
     tooltip = "";
     type = 18;
     unique = 0;
     */
    
}
-(NSMutableArray *)getSubformRecords:(NSArray *)recordsRawArray
{
    NSMutableArray * records=[[NSMutableArray alloc]init];
    
 for(NSDictionary * recDict in recordsRawArray)
 {

     ZCRecord * subrec=[[ZCRecord alloc]initZCRecord];
    for (NSString * key_fieldname in [recDict allKeys])
     
     {
     
         ZCFieldData * data=[[ZCFieldData alloc]init];
         [data setFieldValue:[recDict objectForKey:key_fieldname]];
         [data setFieldName:key_fieldname ];
         [subrec addZCFieldData:data];
     
     }
     [records addObject:subrec];
 }
    return records;

}

@end
