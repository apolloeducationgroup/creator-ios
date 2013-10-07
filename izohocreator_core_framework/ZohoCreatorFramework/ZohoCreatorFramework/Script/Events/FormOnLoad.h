//
//  FormOnLoad.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 08/11/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCApplication.h"
#import "DelugeTasks.h"
#import "DelugeEvent.h"
#import "URLConstructor.h"

@class ZCForm;

@interface FormOnLoad : DelugeEvent  {
    
}

@property (nonatomic,retain) ZCApplication *application;
@property (nonatomic,retain) ZCForm *form;

- (FormOnLoad*) initFormOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (id) delegate;
- (DelugeTasks*) execute;

@end
