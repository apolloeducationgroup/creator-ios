//
//  ZCRecord.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConstructor.h"
#import "ZCRecordString.h"
#import "ZCRecordStatus.h"
#import "URLConnector.h"
#import "NewRecordParser.h"
#import "ZCMetaDefault.h"
#import "ZCApplication.h"
#import "ZCGroup.h"

@class ZCFieldData;
@class ZCForm;

@interface ZCRecord : NSObject <NSCopying>

@property (nonatomic,retain) NSMutableArray *fieldDataList;
@property (nonatomic,retain) NSMutableDictionary *record;
@property (nonatomic,retain) NSString *recordID;
@property (nonatomic,retain) ZCGroup *zCGroup;
@property (nonatomic,retain) ZCForm *form;

- (ZCRecord*) initZCRecord;
- (ZCRecord*) initZCRecord : (ZCForm*) _localform;
- (void) addZCFieldData : (ZCFieldData*) fieldData;
- (ZCFieldData*) getFieldData : (NSString*) fieldName;
- (ZCFieldData*) getFieldDataByIndex : (NSInteger) index;
- (ZCRecordStatus*) addRecord;
-(ZCRecordStatus*) addRecordWithViewLinkName:(NSString *)viewLinkname;
- (ZCRecordStatus*) addRecordForFormInAddToPickListChildappNamesINORDER:(NSArray *)childappNamesINORDER childFormNameINORDER:(NSArray *)childFormNameINORDER baseFieldNameINORDER:(NSArray *)baseFieldNameINORDER recordID :(NSString *)recID viewLinkname:(NSString *)viewLinkname;
- (ZCRecordStatus*) updateRecordFromView:(NSString*) viewLinkName;
- (ZCRecordStatus*) deleteRecord;
- (ZCRecordStatus*) duplicateRecord;
- (BOOL) uploadImages : (NSString*)  recordID viewLinkname:(NSString *)viewLinkname;
- (BOOL)  uploadFiles : (NSString*) recordID viewLinkname:(NSString *)viewLinkname;
-(id)copyWithZone:(NSZone *)zone;

@end
