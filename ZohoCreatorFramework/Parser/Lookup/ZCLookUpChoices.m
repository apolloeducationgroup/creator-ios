//
//  ZCLookUpChoices.m
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 31/10/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import "ZCLookUpChoices.h"

@implementation ZCLookUpChoices
@synthesize lookUPKeysInOrder;
@synthesize lookUPChoicesInOrder;
@synthesize lookUpField;
@synthesize LookupChoices;
-(ZCLookUpChoices *)initLookUpChoicesParm
{
    self=[super init];
    if (self) {
        
        LookupChoices=[[NSMutableDictionary alloc]init];
        lookUPKeysInOrder=[[NSMutableArray alloc]init];
        lookUPChoicesInOrder=[[NSMutableArray alloc]init];

        
    }return self;
}

-(void)addLookupChoice:(NSString *)choice key:(NSString *)key
{
    [lookUPKeysInOrder addObject:key];
    [lookUPChoicesInOrder addObject:choice];
    [LookupChoices setObject:choice forKey:key];
    
}

@end
