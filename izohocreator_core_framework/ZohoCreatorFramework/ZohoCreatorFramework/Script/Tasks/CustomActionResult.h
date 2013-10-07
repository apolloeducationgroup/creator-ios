//
//  CustomActionResult.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 23/04/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomActionResult : NSObject

@property BOOL isSuccess;
@property (nonatomic,retain) NSString *message;
@property (nonatomic,retain) NSString *recordId;

@end
