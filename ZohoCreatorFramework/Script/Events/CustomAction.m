//
//  CustomAction.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 22/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "CustomAction.h"

@implementation CustomAction


- (CustomAction*) initCustomAction:(NSString *) applicationName :(NSString *) viewLinkName : (NSString*) functionId : (NSString*) sharedBy : (NSMutableArray*) recordIds : (id) delegate {
    
    self = [super init];
    if(self) {
        [super setCallerDelegate:delegate];
        [super setDelugeURL:[URLConstructor customActionURL : applicationName : viewLinkName : functionId :  sharedBy :  recordIds]];
        //// ////NSLog@"Custom Action URL %@",[super delugeURL]);
    }
    return self;
}

- (DelugeTasks*) execute {
    
    return [super execute];
}

@end
