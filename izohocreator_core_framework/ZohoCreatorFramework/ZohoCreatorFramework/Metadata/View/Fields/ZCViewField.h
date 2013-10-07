//
//  ZCViewField.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/11/12.
//  Copyright (c) 2012 ZOHOCorp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCViewField : NSObject

@property (nonatomic,retain) NSString *fieldLinkName;
@property (nonatomic,retain) NSString *fieldDisplayName;
@property (nonatomic) NSInteger fieldType;
@property (nonatomic) NSInteger viewOrder;
@property (nonatomic) NSInteger sequenceNumber;

@end
