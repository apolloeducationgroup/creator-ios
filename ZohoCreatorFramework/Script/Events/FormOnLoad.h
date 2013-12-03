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

- (FormOnLoad*) initFormOnLoad: (ZCApplication*) _appLocal fieldForm: (ZCForm*) _formLocal zcRecors:(ZCRecord*) zcrecord delegate:(id)delegate recordIDIncaseOFEDITFORM:(NSString *)recID viewLinkname:(NSString *)viewLinkname childAppsIncaseOFAddTOPickListForm:(NSArray *)apps childforms:(NSArray *)forms basefields:(NSArray *)fields appOwner:(NSString *)appowner;


@end
