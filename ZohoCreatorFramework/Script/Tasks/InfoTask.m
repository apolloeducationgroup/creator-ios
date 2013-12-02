//
//  InfoTask.m
//  ZohoCreatorFramework
//
//  Created by Riyaz Mohammed on 02/12/13.
//  Copyright (c) 2013 mathankumar vv. All rights reserved.
//

#import "InfoTask.h"

@implementation InfoTask
-(void)setMessage:(NSArray *)message
{

    super.message=[[message valueForKey:@"description"] componentsJoinedByString:@"\n"];

}
@end
