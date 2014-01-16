//
//  ExecuteFormula.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 20/08/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ExecuteFormula.h"

@implementation ExecuteFormula

- (ExecuteFormula*) initExecuteFormula : (NSString*) _appLocal : (NSString*) _formLocal : (NSString*) _fieldLocal : (NSString*) paramString : (id) delegate{
    self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor fieldOnUserFormaula:_appLocal :_formLocal:_fieldLocal:paramString]];
        //// ////NSLog@"On User URL %@",[super delugeURL]);
        //// ////NSLog@"deluge initiated...with app : %@, form : %@, field : %@, param : %@ delegate class : %@",_appLocal,_formLocal,_fieldLocal,paramString,[delegate class]);
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}

@end
