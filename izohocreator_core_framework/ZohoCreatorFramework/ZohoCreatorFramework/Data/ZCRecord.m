//
//  ZCRecord.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCRecord.h"

@implementation ZCRecord

@synthesize record=_record,form=_form,fieldDataList=_fieldDataList,recordID=_recordID, zCGroup=_zCGroup;

- (ZCRecord*) initZCRecord {
    
    self = [super init];
    if(self) {
        self->_record = [[NSMutableDictionary alloc] init];
        self->_fieldDataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (ZCRecord*) initZCRecord : (ZCForm*) _localform {
    
    self = [super init];
    if(self) {
        
        self->_record = [[NSMutableDictionary alloc] init];
        self->_fieldDataList = [[NSMutableArray alloc] init];
        self->_form=_localform;
    }
    return self;
}

- (void) addZCFieldData : (ZCFieldData*) fieldData {
    
    [_record setObject:fieldData forKey:[fieldData fieldName]];
    [_fieldDataList addObject:fieldData];
}

- (ZCFieldData*) getFieldData : (NSString*) fieldName {
    
    //// //NSLog(@"Record %@",_record);
    return [_record objectForKey:fieldName];
}

- (ZCFieldData*) getFieldDataByIndex : (NSInteger) index {
    
    if(index < [_fieldDataList count]) {
        return [_fieldDataList objectAtIndex:index];
    }
    else  {
        return nil;
    }
}

- (ZCRecordStatus*) addRecord {
    
    NSLog(@"In add record");
    if([self->_form application] == nil) {
        [NSException raise:@"Application" format:@"Application Object Missing"];
        return NO;
    }
    NSString *newRecord = [URLConstructor newsubmitRecordURL];
    NSString *newRecordString = [URLConstructor postAuthTokenWithApplication:[_form application]];
    newRecordString = [newRecordString stringByAppendingFormat:@"&%@&errorLog=true",[ZCRecordString newRecordStringXML:self->_form :self]];
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:newRecord :newRecordString :[URLConnector POSTMETHOD]];
    
    NSString *response = [urlConnect apiResponse];
    NSLog(@"addrecord response \n \n %@ \n\n",response);
    NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:_form];
    return [parser recordStatus];
}

- (ZCRecordStatus*) updateRecord {
    
    if([self->_form application] == nil) {
        [NSException raise:@"Application" format:@"Application Object Missing"];
        return NO;
    }
    NSLog(@"%@",self.recordID);
    NSString *updateRecord = [URLConstructor submitRecordURL];
    NSString *updateRecordString = [URLConstructor postAuthTokenWithAppOwner:[[self->_form application] appOwner]];
    
    ZCFieldData *idFieldData = [[ZCFieldData alloc] init];
    [idFieldData setFieldName:@"ID"];
    [idFieldData setFieldValue:self.recordID];
    [self addZCFieldData:idFieldData];
    updateRecordString = [updateRecordString stringByAppendingFormat:@"&%@",[ZCRecordString updateRcordStringXML:self->_form :self]];
    NSLog(@"Update record string %@",updateRecordString);
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:updateRecord :updateRecordString :[URLConnector POSTMETHOD]];
    NSString *response = [urlConnect apiResponse];
    NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:_form];
    NSLog(@"%@",[parser recordStatus]);
    return [parser recordStatus];
}

- (ZCRecordStatus*) deleteRecord {
    
    if([self->_form application] == nil) {
        [self->_form setApplication :[[ZOHOCreator getObject] lastAccessedApp] ];
        if([self->_form application] == nil) {
            [NSException raise:@"Application" format:@"Application Object Missing"];
            return NO;
        }
    }
    NSString *deleteRecord = [URLConstructor writeURL];
    NSString *deleteCriteriaString = [URLConstructor postAuthTokenWithAppOwner];
    deleteCriteriaString = [deleteCriteriaString stringByAppendingFormat:@"&%@",[ZCRecordString deleteRecordStringXML:self->_form :self]];
    //// //NSLog(@"Coming to delete %@",deleteCriteriaString);
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:deleteRecord :deleteCriteriaString :[URLConnector POSTMETHOD]];
    NSString *response = [urlConnect apiResponse];
    //// //NSLog(@"Response XML %@",response);
    NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:_form];
    return [parser recordStatus];
}

- (BOOL) uploadImages : (NSString*)  recordID {
    
    
    NSArray *imageFields = [self.form getImageFields];
    if(imageFields != nil && imageFields.count > 0) {
        for(NSInteger index=0;index<[imageFields count];index++) {
            
            ZCField *imageField = [imageFields objectAtIndex:index];
            NSString *fieldName = [imageField fieldName];
            UIImageView *newImage = [[self.record valueForKey:fieldName] fieldValue];
            if(newImage != nil) {
                
                NSString *uploadURL = [URLConstructor uploadURL:[self.form.application appLinkName] :[self.form linkName] :fieldName :recordID :@"file" :[self.form.application appOwner]];
                URLConnector *url = [[URLConnector alloc] initFetcherPostImage:uploadURL :newImage :[URLConnector MULTIPARTPOST]];
                [url apiResponse];
            }
        }
    }
    return YES;
}

- (BOOL)  uploadFiles : (NSString*) recordID {
    
    NSArray *imageFields = [self.form getFileUploadFields];
    if(imageFields != nil && imageFields.count > 0) {
        for(NSInteger index=0;index<[imageFields count];index++) {
            
            ZCField *imageField = [imageFields objectAtIndex:index];
            NSString *fieldName = [imageField fieldName];
            UIImageView *newImage = [[self.record valueForKey:fieldName] fieldValue];
            if(newImage != nil) {
                
                NSString *uploadURL = [URLConstructor uploadURL:[self.form.application appLinkName] :[self.form linkName] :fieldName :recordID :@"file" :[self.form.application appOwner]];
                
                //NSLog(@"image upload url riyaz :: %@",uploadURL);
                
                
                URLConnector *url = [[URLConnector alloc] initFetcherPostImage:uploadURL :newImage :[URLConnector MULTIPARTPOST]];
                [url apiResponse];
            }
        }
    }
    return YES;
}

- (ZCRecordStatus*) duplicateRecord {
    
    return [self addRecord];
}

-(id) copyWithZone:(NSZone *)zone {
    
    ZCRecord *copyRecord = [[[self class] alloc] initZCRecord];
    if(copyRecord) {
        
        [copyRecord setForm:_form];
        [copyRecord setRecord:[_record mutableCopy]];
        [copyRecord setRecordID:[_recordID mutableCopy]];
        [copyRecord setFieldDataList:[_fieldDataList mutableCopy]];
        [copyRecord setZCGroup:[_zCGroup mutableCopy ]];
    }
    return copyRecord;
}

@end
