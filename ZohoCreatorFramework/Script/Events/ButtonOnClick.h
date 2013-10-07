//
//  ButtonOnClick.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 01/03/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "DelugeEvent.h"
#import <Foundation/Foundation.h>
#import "ZCApplication.h"
#import "DelugeTasks.h"
#import "URLConstructor.h"

@class ZCForm;

@interface ButtonOnClick : DelugeEvent  {
    
}

- (ButtonOnClick*) initButtonOnClick:(NSString *) applicationName :(NSString *) formName : (NSString*) buttonName : (NSString*) paramString : (id) delegate;
- (DelugeTasks*) execute;

@end
