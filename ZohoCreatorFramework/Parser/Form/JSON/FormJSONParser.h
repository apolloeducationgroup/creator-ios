//
//  FormJSONParser.h
//  ZohoCreatorFramework
//
//  Created by Vishnu Kumar V on 25/10/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParserUtil.h"
#import "ZCForm.h"
#import "ZCField.h"
#import "ZCButton.h"
#import "FormParserUtil.h"
#import "ZCInternationalization.h"
#import "ZOHOCreatorError.h"

@class ZCForm;

@interface FormJSONParser : NSObject {
    
    @private NSString *_jsonString;
    @private NSDictionary *_jsonDictionary;
}

@property (nonatomic,retain) ZCForm *zcForm;

- (FormJSONParser*) initFormJSONParser : (NSString*) jsonString;

@end