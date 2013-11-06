//
//  ZCLookUpChoices.h
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 31/10/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCLookUpChoices : NSObject
@property (nonatomic,retain) NSMutableArray * lookUPChoicesInOrder;
@property (nonatomic,retain) NSMutableArray * lookUPKeysInOrder;

@property (nonatomic,retain) NSMutableDictionary * LookupChoices;
@property (nonatomic,retain) NSString * lookUpField;
-(ZCLookUpChoices *)initLookUpChoicesParm;
-(void)addLookupChoice:(NSString *)choice key:(NSString *)key;
@end
