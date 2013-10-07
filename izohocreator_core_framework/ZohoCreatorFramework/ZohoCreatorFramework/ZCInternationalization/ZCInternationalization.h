//
//  ZCInternationalization.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 30/05/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSInteger decodeUIChar;

@interface ZCInternationalization : NSObject

+ (void) initUICharacterEncode;
+ (void) initInternationalization;
+(NSString *) getLocaleStringForTitleString:(NSString *)title_key;
@end
