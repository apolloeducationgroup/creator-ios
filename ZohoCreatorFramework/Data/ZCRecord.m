//
//  ZCRecord.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCRecord.h"
#import "ZCSharedAppsEventsParamsUtil.h"

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
    newRecordString = [newRecordString stringByAppendingFormat:@"&formAccessType=1&errorLog=true&%@",[ZCRecordString newRecordStringXML:self->_form :self]];
    
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:newRecord :newRecordString :[URLConnector POSTMETHOD]];
    
    NSString *response = [urlConnect apiResponse];
    NSLog(@"addrecord response \n \n %@ \n\n",response);
    NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:_form];
    return [parser recordStatus];
}
-(ZCRecordStatus*) addRecordWithViewLinkName:(NSString *)viewLinkname

{


    NSLog(@"In add record with ViewLinkname");
    if([self->_form application] == nil) {
        [NSException raise:@"Application" format:@"Application Object Missing"];
        return NO;
    }
    NSString *newRecord = [URLConstructor newsubmitRecordURL];
    NSString *newRecordString = [URLConstructor postAuthTokenWithApplication:[_form application]];
    newRecordString = [newRecordString stringByAppendingFormat:@"&%@&errorLog=true&zcRefValue=true",[ZCRecordString newRecordStringXMLWithViewLinkname:viewLinkname form:self->_form record:self]];
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:newRecord :newRecordString :[URLConnector POSTMETHOD]];
    
    NSString *response = [urlConnect apiResponse];
    NSLog(@"addrecord response \n \n %@ \n\n",response);
    NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:_form];
    return [parser recordStatus];
}
- (ZCRecordStatus*) addRecordForFormInAddToPickListChildappNamesINORDER:(NSArray *)childappNamesINORDER childFormNameINORDER:(NSArray *)childFormNameINORDER baseFieldNameINORDER:(NSArray *)baseFieldNameINORDER recordID :(NSString *)recID viewLinkname:(NSString *)viewLinkname
 {
    
    NSLog(@"In add record");
    if([self->_form application] == nil) {
        [NSException raise:@"Application" format:@"Application Object Missing"];
        return NO;
    }
    NSString *newRecord = [URLConstructor newsubmitRecordURL];
    NSString *newRecordString = [URLConstructor postAuthTokenWithAppOwner:[_form application].appOwner];
     newRecordString = [newRecordString stringByAppendingFormat:@"&%@&errorLog=true&formAccessType=5",[ZCRecordString newRecordStringXML:self->_form :self]];
     
//    for(int appInd=0;appInd<childappNamesINORDER.count;appInd++)
//    {
//        
//        
//
//        newRecordString = [newRecordString stringByAppendingFormat:@"&zc_childappname_%i=%@",appInd+1,[[childappNamesINORDER objectAtIndex:appInd]appLinkName] ];
//        newRecordString = [newRecordString stringByAppendingFormat:@"&zc_childformname_%i=%@",appInd+1,[[childFormNameINORDER objectAtIndex:appInd]linkName] ];
//        newRecordString = [newRecordString stringByAppendingFormat:@"&zc_childlabelname_%i=%@",appInd+1,[[baseFieldNameINORDER objectAtIndex:appInd]fieldName]];
//    }
//    
//    newRecordString = [newRecordString stringByAppendingFormat:@"&zc_lookupCount=%i",childFormNameINORDER.count];
//    newRecordString = [newRecordString stringByAppendingFormat:@"&formAccessType=5"];
//    
//    NSLog(@"recLinkID %@ %@",recID,viewLinkname);
//    if (recID.length) {
//        newRecordString = [newRecordString stringByAppendingFormat:@"&recLinkID=%@",recID];
//    }
//    if (viewLinkname.length) {
//        
//        newRecordString = [newRecordString stringByAppendingFormat:@"&viewLinkName=%@",viewLinkname];
//        
//    }
    

     newRecordString =[newRecordString stringByAppendingString:[ZCSharedAppsEventsParamsUtil getAddtoPickListParamsWithAPPS:childappNamesINORDER Forms:childFormNameINORDER fields:baseFieldNameINORDER viewLinkname:viewLinkname recordID:recID]];
     
    
    
    URLConnector *urlConnect = [[URLConnector alloc] initFetcherPostParam:newRecord :newRecordString :[URLConnector POSTMETHOD]];
    
    NSString *response = [urlConnect apiResponse];
    NSLog(@"addrecord response \n \n %@ \n\n",response);
    NewRecordParser *parser = [[NewRecordParser alloc] initRecordParser:response:_form];
    return [parser recordStatus];
}

- (ZCRecordStatus*) updateRecordFromView:(NSString *)viewLinkName {
    
    if([self->_form application] == nil) {
        [NSException raise:@"Application" format:@"Application Object Missing"];
        return NO;
    }
    NSString *updateRecord = [URLConstructor submitRecordURL];
    NSString *updateRecordString = [URLConstructor postAuthTokenWithAppOwner:[[self->_form application] appOwner]];
    
    ZCFieldData *idFieldData = [[ZCFieldData alloc] init];
    [idFieldData setFieldName:@"ID"];
    [idFieldData setFieldValue:self.recordID];
    [self addZCFieldData:idFieldData];
    updateRecordString = [updateRecordString stringByAppendingFormat:@"&%@&zcRefValue=true",[ZCRecordString newUpdateRcordStringXML:self->_form :self :viewLinkName]];
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
                
                NSLog(@"file name %@",fieldName);
                NSLog(@"URL for Image Upload   %@",uploadURL);
                
                
                URLConnector *url = [[URLConnector alloc] initFetcherPostImage:uploadURL :newImage :[URLConnector MULTIPARTPOST]];
                NSLog(@" Image Response %@",[url apiResponse]);
            }
        }
    }
    return YES;
}

- (BOOL)  uploadFiles : (NSString*) recordID {
    
    NSLog(@"Coming to upload files11111");
    
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
                NSLog(@" Image Response %@",[url apiResponse]);
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
