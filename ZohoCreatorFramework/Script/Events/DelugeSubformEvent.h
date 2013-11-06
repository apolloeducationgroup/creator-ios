//
//  DelugeSubformEvent.h
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 04/11/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//
#import "DelugeEvent.h"
#import <Foundation/Foundation.h>

@interface DelugeSubformEvent : DelugeEvent
-(DelugeSubformEvent *)initDelugeSubFormAddRowWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName numberofsubformEntries:(int)numberofsubformEntries appOwner:(NSString *)appOwner recordParm:(NSString *)params callerDelegate:(id)delegate;
-(DelugeSubformEvent *)initDelugeSubFormONDELETEROWWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName deleteRowNumber:(int)deleteRowNumber appOwner:(NSString *)appOwner recordParm:(NSString *)params callerDelegate:(id)delegate;
- (DelugeTasks*) execute;
@end
