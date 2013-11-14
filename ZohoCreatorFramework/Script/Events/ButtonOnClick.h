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

- (ButtonOnClick*) initButtonOnClickApplinkName:(NSString *) applicationName formName:(NSString *) formName buttonName: (NSString*) buttonName paramString: (NSString*) paramString delegate: (id) delegate  appOwner:(NSString *)appowner;
- (DelugeTasks*) execute;

@end
