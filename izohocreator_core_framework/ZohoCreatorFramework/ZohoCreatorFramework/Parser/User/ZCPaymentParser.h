//
//  ZCPaymentParser.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 05/06/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPayment.h"

@class ZCPayment;

@interface ZCPaymentParser : NSObject <NSXMLParserDelegate> {
    
@private NSXMLParser *_xmlParser;
@private NSString *_xmlString;
@private NSString *_currentElementName;
    
}

@property (nonatomic,retain) ZCPayment *zcPayment;

- (ZCPaymentParser*) initRecordParser : (NSString*) xmlString;

@end
