//
//  ZCSharedAppsEventsParamsUtil.h
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 13/11/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCSharedAppsEventsParamsUtil : NSObject
+(NSString *)getAddtoPickListParamsWithAPPS:(NSArray *)apps Forms:(NSArray *)forms fields:(NSArray *)fields viewLinkname:(NSString *)viewLinkname recordID:(NSString *)recordID;
+(NSString *)getAddtoPickListParamsWithAPPS:(NSArray *)apps Forms:(NSArray *)forms fields:(NSArray *)fields viewLinkname:(NSString *)viewLinkname recordID:(NSString *)recordID deluge:(BOOL)deluge;
@end
