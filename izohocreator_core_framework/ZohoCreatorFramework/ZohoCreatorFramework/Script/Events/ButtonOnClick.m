//
//  ButtonOnClick.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 01/03/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ButtonOnClick.h"


@implementation ButtonOnClick

- (ButtonOnClick*) initButtonOnClick:(NSString *) applicationName :(NSString *) formName : (NSString*) buttonName : (NSString*) paramString : (id) delegate {
    
    self = [super init];
    if(self) {
        [super setDelugeURL:[URLConstructor buttonOnClick:applicationName:formName:buttonName:paramString]];
        NSLog(@"Deluge URL  %@", [super delugeURL]);
        [super setCallerDelegate:delegate];
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}

@end