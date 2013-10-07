//
//  CustomAction.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 22/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DelugeEvent.h"

@interface CustomAction : DelugeEvent

- (CustomAction*) initCustomAction:(NSString *) applicationName :(NSString *) viewLinkName : (NSString*) functionId : (NSString*) sharedBy : (NSMutableArray*) paramString : (id) delegate;
- (DelugeTasks*) execute;

@end
