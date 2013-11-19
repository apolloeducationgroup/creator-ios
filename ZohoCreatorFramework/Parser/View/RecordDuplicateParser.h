//
//  RecordDuplicateParser.h
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 27/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordDuplicateParser : NSObject <NSXMLParserDelegate>
{@private
    NSString *_xmlString;
    NSXMLParser *_xmlParser;
    
    NSMutableDictionary * fieldkeyvaluepair;
    NSString * _fieldname;
    NSString * _elementname;
    BOOL _bulkDuplicate;
    
    
}

@property (nonatomic,assign) BOOL status;
@property (nonatomic,retain) NSString *  recordID;
@property (nonatomic,retain) NSString *  dateFormat;
@property (nonatomic,retain) NSString *  timezone;
@property (nonatomic,retain) NSString *  criteriaID;
@property (nonatomic,retain) NSString * formName;

- (RecordDuplicateParser*) initWithRecordDuplicateParser:(NSString *) xmlString  bulkDuplicate:(BOOL)bulkdup;


@end
