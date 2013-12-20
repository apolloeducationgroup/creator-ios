//
//  ZCHTMLViewFetcher.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 01/07/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionChecker.h"
#import "URLConstructor.h"
#import "URLConnector.h"
#import "ZCComponent.h"
#import "ArchiveUtil.h"
#import "EncodeObject.h"
#import "DecodeObject.h"
#import "ZCHTMLView.h"
#import "ZOHOCreator.h"

@interface ZCHTMLViewFetcher : NSObject {
    
@private
    NSString *_appLinkName;
    NSString *_componentName;
    NSString *_appOwner;
    NSString *_searchString;
}

@property (nonatomic,retain) ZCHTMLView *zcHtmlView;

- (ZCHTMLViewFetcher*) initHTMLViewFetcher : (NSString*) appLinkName htmlViewLinkName : (NSString*) viewLinkName appOwner:(NSString *) appOwner searchString:(NSString *)searchString;
@end
