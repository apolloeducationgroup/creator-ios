//
//  FormParserUtil.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 18/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "FormParserUtil.h"

@implementation FormParserUtil

+ (NSString*) convertToHTMLTag : (NSString*) rawString {
    
    if(rawString != nil) {
        rawString =  [rawString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        rawString =  [rawString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        return rawString;
    }
    else {
        return nil;
    }
}

+ (NSMutableArray*) orderChoices : (NSMutableArray*) options : (NSMutableArray*) optionSequence {
    // //NSLog@"Options: %@", options);
    // //NSLog@"Option sequence %@", optionSequence);
    
    
    NSMutableArray *_returnList = [[NSMutableArray alloc] initWithCapacity:[options count]];
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:[options count]];
    
    for(NSInteger index=0;index<[options count];index++) {
        NSString *optSequence = [optionSequence objectAtIndex:index];
        NSInteger seNumber = [[optSequence substringFromIndex:6] integerValue];
        [dic setValue:[options objectAtIndex:index] forKey:[NSString stringWithFormat:@"%4d",seNumber]];
    }
    
    NSArray *keys = [dic allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    for(NSString *key in keys) {
        [_returnList addObject:[dic valueForKey:key]];
    }
    return _returnList;
}

+ (NSDictionary*) convertToDictionary : (NSArray*) _optionList {
    
    NSMutableDictionary *_optionDict = [[NSMutableDictionary alloc] initWithCapacity:[_optionList count]];
    for(NSString *_optionString in _optionList) {
//        NSData *jsonData = [_optionString dataUsingEncoding:[NSString defaultCStringEncoding]];
        NSData *jsonData = [_optionString dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if(dataDic != nil) {
            [_optionDict addEntriesFromDictionary:dataDic];
        }
        else {
            [_optionDict setValue:_optionString forKey:_optionString];
        }
        //}
    }
    return _optionDict;
}

+ (NSArray*) parseOptions : (NSArray*) _optionList {
    
    NSMutableArray *optionList = [[NSMutableArray alloc] initWithCapacity:2];
    NSMutableArray *optionValues = [[NSMutableArray alloc] initWithCapacity:[_optionList count]];
    NSMutableArray *optionKeys = [[NSMutableArray alloc] initWithCapacity:[_optionList count]];
    
    
    for(NSString *_optionString in _optionList) {
//        NSData *jsonData = [_optionString dataUsingEncoding:[NSString defaultCStringEncoding]];
        NSData *jsonData = [_optionString dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if(dataDic != nil) {
            
            NSString *key = [[dataDic allKeys] objectAtIndex:0];
            
            [optionKeys addObject:key];
            NSString *value = [dataDic valueForKey:key];
            [optionValues addObject:value];
        }
        else {
            [optionKeys addObject:_optionString];
            [optionValues addObject:_optionString];
        }
    }
    [optionList addObject:optionKeys];
    [optionList addObject:optionValues];
    return optionList;
}


@end
