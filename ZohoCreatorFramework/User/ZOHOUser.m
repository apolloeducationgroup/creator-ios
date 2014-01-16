
//
//  ZOHOUser.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZOHOUser.h"
#import "URLConnector.h"


@interface ZOHOUser(hidden)

- (BOOL) deleteAuthToekn;

@end

@implementation ZOHOUser

static ZOHOUser *userCredential = nil;

@synthesize userName=_userName,authToken=_authToken,userDisplayName=_userDisplayName,userLocale=_userLocale,emailIds=_emailIds,zuid=_zuid,gender=_gender;

+ (ZOHOUser*) userObject
{
    if(userCredential == nil)
    {
        //        ZOHOUser *user = [[ZOHOUser alloc] init];
        //        return user;
        
        NSString *filePath = [ArchiveUtil archiveFilePath:@"Login"];
        ZOHOUser *user = [DecodeObject decode:filePath :@"Login"];
        //////// ////NSLog@"ZOHO User %@",user);
        if(user != nil) {
            userCredential = user;
            return userCredential;
        }
        else {
            return nil;
        }
    }
    else
    {
        return userCredential;
    }
}

- (ZOHOUser*) initZOHOUser : (NSString*) userName : (NSString*) password {
    
    self = [super init];
    if(self) {
        
        if([ConnectionChecker isServerActive])
        {
            NSString *accountURL = [URLConstructor accountsURL:userName:password];
            //// ////NSLog@"Accounts URL %@",accountURL);
            URLConnector *connection = [[URLConnector alloc] initFetcherPost:accountURL :[URLConnector POSTMETHOD] ];
            NSString *accountResponse = [connection apiResponse];
            //// ////NSLog@"%@",accountResponse);
            NSRange srange = [accountResponse rangeOfString:@"AUTHTOKEN="];
            NSRange erange = [accountResponse rangeOfString:@"RESULT="];
            NSRange causeRange=[accountResponse rangeOfString:@"CAUSE="];
            
            if(srange.length == 0) {
                
                if (causeRange.length>2) {
                    NSRange range;
                    range.location =causeRange.location + causeRange.length;
                    range.length = erange.location - (causeRange.location + causeRange.length + 1);
                    NSString * weblog = [accountResponse substringWithRange:range];
                    
                    
                    [NSException raise:weblog format:@"AuthTOKEN not returned"];
                    
                }
                else
                {
                    [NSException raise:@"ZOHO Authentication" format:@"Invalid Username/password"];
                }
            }
            NSRange range;
            range.location =srange.location + srange.length;
            range.length = erange.location - (srange.location + srange.length + 1);
            
            self->_authToken = [accountResponse substringWithRange:range];
            self->_userName = userName;
        }
        else
        {
            [NSException raise:@"Network Unavailable" format:@"No network available to connnect to setver"];
        }
    }
    userCredential = self;
    NSString *filePath = [ArchiveUtil archiveFilePath:@"Login"];
    [EncodeObject encode:filePath :@"Login" :self];
    return self;
}


- (id)init
{
    self = [super init];
    if (self) {
        userCredential = self;
    }
    return self;
}


- (id) initZOHOUserObject {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self->_userName=[aDecoder decodeObjectForKey:@"userName"];
    self->_authToken=[aDecoder decodeObjectForKey:@"authToken"];
    self->_emailIds=[aDecoder decodeObjectForKey:@"emailIds"];
    self->_zuid=[aDecoder decodeObjectForKey:@"zuid"];
    self->_userDisplayName=[aDecoder decodeObjectForKey:@"userDisplayName"];
    self->_userLocale=[aDecoder decodeObjectForKey:@"userLocale"];
    self->_gender=[aDecoder decodeObjectForKey:@"gender"];

        return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_authToken forKey:@"authToken"];
    [aCoder encodeObject:_emailIds forKey:@"emailIds"];
    [aCoder encodeObject:_zuid forKey:@"zuid"];
    [aCoder encodeObject:_userDisplayName forKey:@"userDisplayName"];
    [aCoder encodeObject:_userLocale forKey:@"userLocale"];
    [aCoder encodeObject:_gender forKey:@"gender"];
    
}



- (void) removeZCuser {
    [self deleteAuthToekn];
    userCredential = nil;
}

@end

@implementation ZOHOUser(hidden)

- (BOOL) deleteAuthToekn {
    
    NSString *accountURL = [URLConstructor deleteAuthToken:self->_authToken];
    URLConnector *connection = [[URLConnector alloc] initFetcherPost:accountURL :[URLConnector POSTMETHOD] ];
    [connection apiResponse];
    return YES;
}

@end
