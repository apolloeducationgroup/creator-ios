//
//  ZCIssueReporter.m
//  ZohoCreator
//
//  Created by Vishnu Kumar V on 06/05/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "ZCIssueReporter.h"

@interface ZCIssueReporter ()

@end

@implementation ZCIssueReporter

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UILabel *label = [[UILabel alloc] init];
        [label setText:@"Hi"];
        [self.view addSubview:label];
    }
    return self;
}

- (ZCIssueReporter*) initZCIssueReporter : (id) callerDelegate exception:(NSException *)exception {
    NSLog(@"\n\n\n Exception Details \n\n\n %@ \n\n\n",exception);
    // //NSLog(@"%@",[NSThread callStackSymbols]);
    self = [super init];
    if(self) {
        
        _callerDelegate = callerDelegate;
        UIImage *image = [UIImage imageNamed:@"error.jpg"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGRect frame=[UIScreen mainScreen].bounds;
        frame.origin.y=frame.origin.y+44;
        [imageView setFrame:frame];
        UIImage * submitIMAGE=[UIImage imageNamed:@"submit.png"];
        UIButton * SubmitButton=[[UIButton alloc]initWithFrame:CGRectMake(10,270, 302,submitIMAGE.size.height )];
        [SubmitButton setTitle:[ZCInternationalization getLocaleStringForTitleString:@"ZC_ios_text_Report_Issue"] forState:UIControlStateNormal];
        [SubmitButton setBackgroundImage:submitIMAGE forState:UIControlStateNormal];
        [SubmitButton setBackgroundImage:submitIMAGE forState:UIControlStateHighlighted];
        
        [SubmitButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        SubmitButton.titleLabel.textColor=[UIColor whiteColor];
        [SubmitButton setTitleShadowColor:[UIColor colorWithRed:0.094f green:0.470f blue:0.243f alpha:1.0] forState:UIControlStateNormal];
        [SubmitButton setTitleShadowColor:[UIColor colorWithRed:0.094f green:0.470f blue:0.243f alpha:1.0] forState:UIControlStateHighlighted];
        SubmitButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        [SubmitButton addTarget:_callerDelegate action:@selector(submitIssue) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:imageView];
        [self.view addSubview:SubmitButton];
    }
    return self;
}

- (void) submitIssue {
    
    /*  ZCForm *issueForm = [ZOHOCreator getIssueReportForm];
     ZCStaticForm *staticForm = [[ZCStaticForm alloc] initZCStaticFormDirect:issueForm];
     [self.navigationController pushViewController:staticForm animated:YES]; */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
