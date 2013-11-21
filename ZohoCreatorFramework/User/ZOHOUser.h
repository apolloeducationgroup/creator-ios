//
//  ZOHOUser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConstructor.h"
#import "URLConnector.h"
#import "EncodeObject.h"
#import "DecodeObject.h"

@interface ZOHOUser : NSObject <NSCoding> {
    
    NSString *ZohoUserName;
    NSString *UserTicket;
@private
    NSString* ticketCookieName;
}

@property (nonatomic,retain) NSString *authToken;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *userDisplayName;
@property (nonatomic,retain) NSString *zuid;
@property (nonatomic,retain) NSArray *emailIds;
@property (nonatomic,retain) NSString *userLocale;
@property (nonatomic,retain) NSString *gender;

+ (ZOHOUser*) userObject;
- (id) init;
- (ZOHOUser*) initZOHOUser : (NSString*) userName : (NSString*) password;
- (void) removeZCuser;
- (id) initZOHOUserObject;

@end
