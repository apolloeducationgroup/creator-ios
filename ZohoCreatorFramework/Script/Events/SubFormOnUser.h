//
//  SubFormOnUser.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 07/03/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "DelugeEvent.h"

@interface SubFormOnUser : DelugeEvent

- (SubFormOnUser*) initSubFormOnUser : (NSString*) _appLocal : (NSString*) _formLocal : (NSString*) _fieldLocal : (NSString*) refAppName : (NSString*) refFormName : (NSString*) refFieldName : (NSString*) paramString : (NSString*) appOwner : (id) delegate;



- (SubFormOnUser*) initSubFormOnUser : (NSString*) _appLocal formname: (NSString*) _formLocal fieldname: (NSString*) _fieldLocal param: (NSString*) paramString appowner: (NSString*) appOwner : (id) delegate subformFieldName:(NSString *)subformFieldname rowNumberincaseOFsubofrmField:(int)rownum isformula:(BOOL)isformula;

- (DelugeTasks*) execute;

@end
