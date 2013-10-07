//
//  FormParserUtil.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 18/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormParserUtil : NSObject

+ (NSString*) convertToHTMLTag : (NSString*) rawString;
+ (NSMutableArray*) orderChoices : (NSMutableArray*) options : (NSMutableArray*) optionSequence;
+ (NSDictionary*) convertToDictionary : (NSArray*) _optionList;
+ (NSArray*) parseOptions : (NSArray*) _optionList;

@end
