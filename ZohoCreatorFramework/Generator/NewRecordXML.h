//
//  NewRecordXML.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 02/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCForm.h"
#import "ZCField.h"
#import "ZCRecord.h"
#import "ZCFieldData.h"
#import "ZCFieldList.h"


@interface NewRecordXML : NSObject  {
    
}

+ (NSString*) constructRecord : (ZCForm*) zcForm : (ZCRecord*) zcRecord;

@end
