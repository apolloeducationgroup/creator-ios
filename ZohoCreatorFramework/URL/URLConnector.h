//
//  URLConnector.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZOHOUser.h"
#import <UIKit/UIKit.h>
@interface URLConnector : NSObject {
    
    NSString* apiResponse;
    BOOL IsError;
    BOOL isRequestCompleted;
@private
    NSMutableURLRequest* apiURLRequest;
    NSString* zohoFormAPIURL;
    NSMutableData* receivedData;
    NSInteger requestMethod;
    NSString *_paramString;
    UIImageView *imageView;
}

@property (nonatomic,retain) NSString* apiResponse;
@property (nonatomic,retain) NSData * apiRawData;
@property BOOL IsError;
@property BOOL isRequestCompleted;

+ (NSInteger) GETMETHOD;
+ (NSInteger) POSTMETHOD;
+ (NSInteger) PUTMETHOD;
+ (NSInteger) DELETEMETHOD;
+ (NSInteger) MULTIPARTPOST;
- (id) initFetcher:(NSString*) ZohoFormAPIURL;
- (id) initFetcherPost:(NSString *)ZohoFormAPIURL : (NSInteger) method;
- (id) initFetcherPostParam:(NSString *)ZohoFormAPIURL : (NSString*) paramString : (NSInteger) method;
- (id) initFetcherPostImage:(NSString *)ZohoFormAPIURL : (UIImageView*) paramImage : (NSInteger) method;

- (void) prepareConnection;
- (void) proceedConnection;

@end
