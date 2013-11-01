//
//  LookUPChoiceParser.h
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 31/10/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCLookUpChoices.h"
@interface LookUPChoiceParser : NSObject <NSXMLParserDelegate>
{@private
NSXMLParser *_xmlParser;
NSString *_xmlString;
NSString *_currentElementName;
    BOOL inchoices;
    
    NSString * key;


}
@property (nonatomic,retain)ZCLookUpChoices *lookUpChoicesParm;
@property (nonatomic,retain)NSMutableArray *choiceKeys;
@property (nonatomic,retain)NSMutableArray *choiceValues;
- (LookUPChoiceParser *) initLookUPChoiceParser:(NSString *) xmlString;
@end
