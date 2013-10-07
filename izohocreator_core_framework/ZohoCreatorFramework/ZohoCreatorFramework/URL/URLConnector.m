//
//  URLConnector.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "URLConnector.h"

@implementation URLConnector

@synthesize IsError,apiResponse,isRequestCompleted,apiRawData=_apiRawData;
- (id) initFetcherPost:(NSString *)ZohoFormAPIURL : (NSInteger) method
{
    self = [super init];
    if (self) {
        
        zohoFormAPIURL = ZohoFormAPIURL;
        requestMethod = method;
        [self prepareConnection];
        [self proceedConnection];
        self->_paramString = nil;
    }
    return self;
}

- (id) initFetcherPostParam:(NSString *)ZohoFormAPIURL : (NSString*) paramString : (NSInteger) method
{
    self = [super init];
    if (self) {
        zohoFormAPIURL = ZohoFormAPIURL;
        //// //NSLog(@"url riyaz \n\n %@\n\n",ZohoFormAPIURL);
        //NSLog(@"PARMS STRING RIYAZ:: %@",paramString);
        requestMethod = method;
        self->_paramString = paramString;
        [self prepareConnection];
        [self proceedConnection];
    }
    return self;
}

- (id) initFetcherPostImage:(NSString *)ZohoFormAPIURL : (UIImageView*) paramImage : (NSInteger) method
{
    self = [super init];
    if (self) {
        zohoFormAPIURL = ZohoFormAPIURL;
        requestMethod = method;
        imageView = paramImage;
        [self prepareConnection];
        [self proceedConnection];
    }
    return self;
}

- (id) initFetcher:(NSString *)ZohoFormAPIURL
{
    self = [super init];
    if (self) {
        zohoFormAPIURL = [[NSString alloc]initWithString:ZohoFormAPIURL];
        [self prepareConnection];
        [self proceedConnection];
    }
    return self;
}


-(void) prepareConnection
{
    isRequestCompleted = NO;
    receivedData = [[NSMutableData alloc] init];
    apiURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:zohoFormAPIURL]];
    if(requestMethod == 1)
    {
        [apiURLRequest setHTTPMethod:@"GET"];
    }
    else if(requestMethod == 2)
    {
        [apiURLRequest setHTTPMethod:@"POST"];
        [apiURLRequest setTimeoutInterval:75.0];
        if(_paramString != nil)
        {
            NSMutableString *postString = [NSMutableString string];
            [postString setString:_paramString];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postString length]];
            [apiURLRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
            
            [apiURLRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [apiURLRequest addValue:@"application/xml" forHTTPHeaderField:@"Accept"];
            NSLog(@"appi url req  riyaz1 %@",postString);
            
        }
    }
    else if(requestMethod == 3)
    {
        [apiURLRequest setHTTPMethod:@"PUT"];
    }
    else if(requestMethod == 4)
    {
        [apiURLRequest setHTTPMethod:@"DELETE"];
    }
    else if(requestMethod == 5)
    {
        [apiURLRequest setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [apiURLRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSData *imageData = UIImageJPEGRepresentation(imageView.image, 90);
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: attachment; name=\"iphoneimage\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [apiURLRequest setHTTPBody:body];
    }
}

- (void) proceedConnection
{
    NSHTTPURLResponse *authenticationResponse= nil;
    NSError *error=nil;
    receivedData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:apiURLRequest  returningResponse:&authenticationResponse  error:&error];
    _apiRawData=receivedData;
    apiResponse = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    NSLog(@"request riyaz \n\n\n %@\n\n\n",apiURLRequest);
    NSString *bodystring=[[NSString alloc]initWithData:[apiURLRequest HTTPBody] encoding:NSUTF8StringEncoding];
    NSLog(@"request-body riyaz \n\n\n\n %@ \n\n\n\n", bodystring);
    
    NSLog(@"response riyaz \n\n\n %@\n\n\n",apiResponse);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    apiResponse = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    
    isRequestCompleted = YES;
}

+ (NSInteger) GETMETHOD
{
    return 1;
}

+ (NSInteger) POSTMETHOD
{
    return 2;
}

+ (NSInteger) PUTMETHOD
{
    return 3;
}

+ (NSInteger) DELETEMETHOD
{
    return 4;
}

+ (NSInteger) MULTIPARTPOST
{
    return 5;
}

@end
