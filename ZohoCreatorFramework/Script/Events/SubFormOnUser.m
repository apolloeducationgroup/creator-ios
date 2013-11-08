//
//  SubFormOnUser.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 07/03/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "SubFormOnUser.h"

@implementation SubFormOnUser

- (SubFormOnUser*) initSubFormOnUser:(NSString *)_appLocal :(NSString *)_formLocal :(NSString *)_fieldLocal :(NSString *)refAppName :(NSString *)refFormName :(NSString *)refFieldName :(NSString *)paramString :(NSString *)appOwner :(id)delegate
{
    
self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];
//        [super setDelugeURL:[URLConstructor subFormOnuser:_appLocal :_formLocal :_fieldLocal :refAppName :refFormName :refFieldName :paramString :appOwner]];
        
//        [super setCallerDelegate:delegate];
//        [super setDelugeParams:[URLConstructor subFormOnuserWithJSON:_appLocal :_formLocal :_fieldLocal :refAppName :refFormName :refFieldName :paramString :appOwner]];
//        [super setDelugeURL:[URLConstructor delugeURL]];

        
        
    }
    return self;
}
- (SubFormOnUser*) initSubFormOnUser:(NSString *)_appLocal formname:(NSString *)_formLocal fieldname:(NSString *)_fieldLocal param:(NSString *)paramString appowner:(NSString *)appOwner :(id)delegate subformFieldName:(NSString *)subformFieldname rowNumberincaseOFsubofrmField:(int)rownum{
    
    self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];

    [super setDelugeParams:[URLConstructor subFormOnuserWithJSON:_appLocal formLinkname:_formLocal fieldlinkname:_fieldLocal subformFieldName:subformFieldname rowNumberincaseOFsubofrmField:rownum param:paramString appowner:appOwner]];
     [super setDelugeURL:[URLConstructor delugeURL]];

}
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}


@end
