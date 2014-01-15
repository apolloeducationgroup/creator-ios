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
    NSString*_jsonString;

}
@property (nonatomic,retain)ZCLookUpChoices *lookUpChoicesParm;
- (LookUPChoiceParser *) initLookUPChoiceParser:(NSString *) jsonString;
@end
