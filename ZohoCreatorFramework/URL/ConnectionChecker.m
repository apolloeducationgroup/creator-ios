//
//  ConnectionChecker.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ConnectionChecker.h"

@implementation ConnectionChecker

+ (BOOL)isServerActive
{

    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    BOOL isInternetConnectionAvailable=YES;
    
    if (!didRetrieveFlags) {
        isInternetConnectionAvailable = NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    if (isReachable) {
        // //////// ////NSLog@"isReachable YES");
    }
    else {
        // //////// ////NSLog@"isReachable NO");
    }
    //NSLog@"Rechablity %d",isReachable);
    return isReachable;
}

@end
