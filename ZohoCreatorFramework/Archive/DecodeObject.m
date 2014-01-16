//
//  DecodeObject.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "DecodeObject.h"

@implementation DecodeObject

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

+ (id) decode : (NSString*) fileName : (NSString*) keyName
{
    NSData *data = [[NSData alloc] initWithContentsOfFile:fileName];
    ////// ////NSLog@"decode before...");
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    ////// ////NSLog@"decode after...");
    id object =[unarchiver decodeObjectForKey:keyName];
    [unarchiver finishDecoding];
    return object;
}

@end