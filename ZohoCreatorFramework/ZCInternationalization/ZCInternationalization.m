//
//  ZCInternationalization.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 30/05/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCInternationalization.h"

NSInteger decodeUIChar;
static NSString * languageCode;
static NSMutableDictionary * dictionaryOfStringsFormFile;

@implementation ZCInternationalization

+ (void) initUICharacterEncode {
    decodeUIChar = NSISOLatin1StringEncoding;
}

+ (void) initInternationalization {
    
    NSArray * locale=[NSLocale preferredLanguages];
    
    NSString * _languageCode=[locale objectAtIndex:0];
    
    languageCode=_languageCode;
    
    //    for (int loc=0; loc<locale.count;loc++) {
    //
    //        NSString * _la=[locale objectAtIndex:loc];
    //    NSLocale *localess = [NSLocale currentLocale];
    //    NSString *language = [localess displayNameForKey:NSLocaleIdentifier
    //                                             value:_la];
    //
    ////        //NSLog@"lang   %@ %@",_la,language);
    //
    //    }
    //
    //
    
    
    //    //NSLog@"ng  %@" ,locale);
    //    //NSLog@"%@%@",[locale objectAtIndex:0],[locale objectAtIndex:1]);
    
    
    if ([languageCode isEqualToString:@"en"] ||[languageCode isEqualToString:@"zh-Hant"] ||[languageCode isEqualToString:@"ja"] ) {
        NSString *bundle = [[ NSBundle mainBundle] pathForResource:languageCode ofType:@"strings"];
        dictionaryOfStringsFormFile = [[NSMutableDictionary alloc] initWithContentsOfFile:bundle];
    }
    
    else
    {
        
        NSString *bundle = [[ NSBundle mainBundle] pathForResource:@"en" ofType:@"strings"];
        dictionaryOfStringsFormFile = [[NSMutableDictionary alloc] initWithContentsOfFile:bundle];
        
        
    }
    // just to try what you have read:
    
    
}
+(NSString *) getLocaleStringForTitleString:(NSString *)title_key
{    NSString * returnString;
    
    
    @try {
        
        returnString=   [NSString stringWithCString:[[dictionaryOfStringsFormFile objectForKey:title_key] UTF8String ] encoding:NSUTF8StringEncoding];
        
    }
    @catch (NSException *exception) {
        returnString=title_key;
        
    }
    @finally {
        
    }
    return      returnString;
    
    
    //    NSLog (@"translated by your own dictionary: %@", string);
    
}

@end
