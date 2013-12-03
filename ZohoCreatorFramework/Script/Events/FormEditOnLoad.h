//
//  FormEditOnLoad.h
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

@interface FormEditOnLoad : DelugeEvent  {
    
}

@property (nonatomic,retain) ZCApplication *application;
@property (nonatomic,retain) ZCForm *form;

//- (FormEditOnLoad*) initFormEditOnLoad:(ZCApplication *)applicationLocal :(ZCForm *)formLocal : (ZCRecord*) _record : (id) delegate;
- (FormEditOnLoad*) initFormEditOnLoad:(ZCApplication *)_appLocal fieldForm:(ZCForm *)_formLocal zcRecors:(ZCRecord *)zcrecord delegate:(id)delegate recordIDIncaseOFEDITFORM:(NSString *)recID viewLinkname:(NSString *)viewLinkname childAppsIncaseOFAddTOPickListForm:(NSArray *)apps childforms:(NSArray *)forms basefields:(NSArray *)fields appOwner:(NSString *)appowner;

- (DelugeTasks*) execute;

@end
