//
//  ZCIssueReporter.h
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 06/05/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOHOCreator.h"


@interface ZCIssueReporter : UIViewController {
    
@private
    id _callerDelegate;
}

- (ZCIssueReporter*) initZCIssueReporter : (id) callerDelegate exception:(NSException *)exception;
- (void) submitIssue;


@end
