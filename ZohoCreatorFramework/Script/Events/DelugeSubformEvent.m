//
//  DelugeSubformEvent.m
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 04/11/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import "DelugeSubformEvent.h"
#import "URLConstructor.h"
@implementation DelugeSubformEvent
-(DelugeSubformEvent *)initDelugeSubFormAddRowWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName numberofsubformEntries:(int)numberofsubformEntries appOwner:(NSString *)appOwner recordParm:(NSString *)params callerDelegate:(id)delegate
{
    
        self = [super init];
        if(self) {
            [super setCallerDelegate:delegate];
            [super setDelugeParams:[URLConstructor subFormAddRowWithAppLinkname:appLinkName formLinkName:formLinkName fieldLinkName:fieldLinkName numberofsubformEntries:numberofsubformEntries appOwner:appOwner recordParm:params ]];
            [super setDelugeURL:[URLConstructor delugeURL]];
            
        }
        return self;
    }
-(DelugeSubformEvent *)initDelugeSubFormONDELETEROWWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName deleteRowNumber:(int)deleteRowNumber appOwner:(NSString *)appOwner recordParm:(NSString *)params callerDelegate:(id)delegate
{
    
    self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];
        [super setDelugeParams:[URLConstructor subFormONDELETERowWithAppLinkname:appLinkName formLinkName:formLinkName fieldLinkName:fieldLinkName deleteRowNumber:deleteRowNumber appOwner:appOwner recordParm:params  ]];
        [super setDelugeURL:[URLConstructor delugeURL]];
        
    }
    return self;
}

- (DelugeTasks*) execute {
        return [super execute];
    }
@end
