//
//  ZCRecordString.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 22/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCForm.h"
#import "ZCRecord.h"
#import "ZCField.h"
#import "ZCFieldList.h"

@class ZCRecord,ZCView;

@interface ZCRecordString : NSObject

+ (NSString*) newRecordString : (ZCForm*) form : (ZCRecord*) record;
+ (NSString*) newRecordStringXML : (NSString*) appLinkName : (NSString*) formLinkName : (NSDictionary*) fieldDict;
+ (NSString*) newRecordStringXML : (ZCForm*) form : (ZCRecord*) record;
+ (NSString*) newRecordStringXMLWithViewLinkname:(NSString *)viewLinkname form: (ZCForm*) form  record: (ZCRecord*) record;
+ (NSString*) editRecordCriteria : (NSString*) idValue;
+ (NSString*) deleteRecordCriteria : (NSString*) idValue;
+ (NSString*) newUpdateRcordStringXML : (ZCForm*) form : (ZCRecord*) record : (NSString*) viewLinkName;
+ (NSString*) updateRcordStringXML : (NSString*) appLinkName  : (NSString*) formLinkName : (NSDictionary*) dataDict;
+ (NSString*) deleteRecordStringXML : (ZCForm*) form : (ZCRecord*) record;
+ (NSString*) deleteRecordStringXML: (NSString*) appLinkName : (NSString*) formLinkName : (NSString*) idValue;
+ (NSString*) bulkDeleteRecordStringXML: (NSString*) appLinkName : (NSString*) formLinkName : (NSMutableArray*) idValues;
+ (NSString*) newRecordsStringXML : (ZCForm*) form : (NSMutableArray*) records;
+ (NSString*) bulKUpdateRcordStringXML : (ZCForm*) form : (NSMutableArray*) records;
+ (NSString*) newDeleteRecordStringXML : (ZCView*) view : (ZCRecord*) record;
+ (NSString*) newUpdateRcordStringXML : (ZCView*) view : (ZCRecord*) record ;
+ (NSString*) recordXMLforSubformRecord : (ZCForm*) form : (ZCRecord*) record;

+ (NSString*) bulKUpdateRcordStringXMLWithZCForm:(ZCForm *)form viewLinkName : (NSString*) viewLinkName  records : (NSMutableArray*) records newRecord:(ZCRecord *)record;

+ (NSString*) bulkDeleteRecordStringXML: (NSString*) appLinkName withViewLinkName : (NSString*) viewLinkName : (NSMutableArray*) idValues;
+ (NSString*) deleteRecordStringXML: (NSString*) appLinkName withViewName: (NSString*) viewLinkName : (NSString*) idValue;
+ (NSString*) updateRcordStringXML : (NSString*) appLinkName  withViewName: (NSString*) viewLinkName : (NSDictionary*) dataDict;
+ (NSString*) bulKUpdateRcordStringXML : (NSString*) appLinkName withViewName : (NSString*) viewLinkName  andDataDictList : (NSMutableArray*) dataDictList;
+ (NSString*) duplicateRecords : (NSString*) viewLinkName withApplication : (NSString*) appLinkName AndRecords : (NSMutableArray*) records;
+ (NSString*) newDuplicateRecords : (NSString*) viewLinkName withApplication : (NSString*) appLinkName AndRecords : (NSMutableArray*) records;

@end
