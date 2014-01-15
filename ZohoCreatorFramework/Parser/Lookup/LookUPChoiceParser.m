//
//  LookUPChoiceParser.m
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 31/10/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import "LookUPChoiceParser.h"

@implementation LookUPChoiceParser
@synthesize lookUpChoicesParm=_lookUpChoicesParm;
- (LookUPChoiceParser *) initLookUPChoiceParser:(NSString *) jsonString
{
    self = [super init];
    if (self) {
        self->_jsonString=jsonString;
        _lookUpChoicesParm=[[ZCLookUpChoices alloc]initLookUpChoicesParm];
    
        [self parseJSon];
    }
    return self;
}
-(void)parseJSon
{

    
    NSData *jsonData = [_jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id _jsonDictionary= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    if (_jsonDictionary !=Nil) {
        
        NSDictionary * dict=[_jsonDictionary objectForKey:@"response"];
        NSArray  *allvalues=[dict allValues];
        NSArray  *allkeys=[dict allKeys];
        if (allvalues.count) {

        [_lookUpChoicesParm setLookUpField:[allkeys objectAtIndex:0]];
        NSArray * arrayofchoices=[allvalues objectAtIndex:0];

        for (NSDictionary *choiceDict in arrayofchoices) {

            [_lookUpChoicesParm  addLookupChoice:[choiceDict objectForKey:@"value"] key:[choiceDict objectForKey:@"key"] ];
            
        }
        
        }

}
}

@end
