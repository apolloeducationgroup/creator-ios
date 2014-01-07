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
        NSLog(@"Coming to post");
        zohoFormAPIURL = ZohoFormAPIURL;
        NSLog(@"url riyaz \n\n %@\n\n",ZohoFormAPIURL);
        NSLog(@"PARMS STRING RIYAZ:: %@",paramString);
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
        NSLog(@"Image Vieww Size %@",imageView);
        [self prepareConnection];
//        [self proceedConnection];
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
    NSLog(@"Coming to prepare connection %d",requestMethod);
    isRequestCompleted = NO;
    receivedData = [[NSMutableData alloc] init];
    apiURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:zohoFormAPIURL]];
    if(requestMethod == 1)
    {
        [apiURLRequest setHTTPMethod:@"GET"];
    }
    else if(requestMethod == 2)
    {
        NSLog(@"post method has applied");
        [apiURLRequest setHTTPMethod:@"POST"];
        [apiURLRequest setTimeoutInterval:75.0];
        NSLog(@"POST PARAMETER CHECK NOW... %@",_paramString);
        
        if(_paramString != nil)
        {
            NSMutableString *postString = [NSMutableString string];
            [postString setString:_paramString];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postString length]];
            [apiURLRequest setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
            
            [apiURLRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [apiURLRequest addValue:@"application/xml" forHTTPHeaderField:@"Accept"];
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
        
/*         NSString *kStringBoundary=@"1i2thiS8is9ZOhO4Docs23UpLoAD321i";
         [apiURLRequest setHTTPMethod:@"POST"];
         [apiURLRequest addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",kStringBoundary] forHTTPHeaderField:@"Content-Type"];
         NSMutableData *body = [NSMutableData data];
         
         [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", kStringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
         
         NSData *imageData = UIImageJPEGRepresentation(imageView.image, 90);
         [body appendData:[[NSString stringWithFormat:@"Content-Disposition: multipart/form-data; name=\"%@\"; filename=\"%@\"\r\n", @"iphoneimage",@"photo"]dataUsingEncoding:NSUTF8StringEncoding]];
         
         [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
         
         [body appendData:[NSData dataWithData:imageData]];
         
        
         [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", kStringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
         
            [apiURLRequest setHTTPBody:body];
            [apiURLRequest addValue:@"image/jpeg" forHTTPHeaderField:@"Accept"];
            NSInteger postLenght = body.length + 1;
            NSString *inStr = [NSString stringWithFormat:@"%d", postLenght];
            NSLog(@"Image Size %d",imageData.length);
            NSLog(@"Body Size %@",inStr);
            [apiURLRequest addValue:inStr forHTTPHeaderField:@"Content-Length"];
            [apiURLRequest addValue:@"application/xml" forHTTPHeaderField:@"Accept"];
            [apiURLRequest addValue:@"ZFormBuilder" forHTTPHeaderField:@"User-Agent"];  */
        
        
        
        NSString *filename = @"iphone";
        [apiURLRequest setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [apiURLRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
        NSMutableData *postbody = [NSMutableData data];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [postbody appendData:[[NSString stringWithFormat:@"name=\"userfile\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postbody appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *imageData = UIImageJPEGRepresentation(imageView.image, 90);
        [postbody appendData:[NSData dataWithData:imageData]];
        [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [apiURLRequest setHTTPBody:postbody];
        
        NSString *postLength = [NSString stringWithFormat:@"%d",postbody.length];
        [apiURLRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [apiURLRequest addValue:@"application/xml" forHTTPHeaderField:@"Accept"];
//        [apiURLRequest addValue:@"ZFormBuilder" forHTTPHeaderField:@"User-Agent"];
        
        NSHTTPURLResponse *authenticationResponse= nil;
        NSError *error=nil;
        receivedData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:apiURLRequest  returningResponse:&authenticationResponse  error:&error];
        _apiRawData=receivedData;
        apiResponse = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
         }
    
    
    /*
        
        NSLog(@"Coming 1111");
        [apiURLRequest setHTTPMethod:@"POST"];
        NSMutableData *body = [NSMutableData data];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSLog(@"Coming 22222");
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [apiURLRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSData *imageData = UIImageJPEGRepresentation(imageView.image, 90);
        NSLog(@"Coming 3333");
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"Content-Disposition: attachment; name=\"iphoneimage\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        

        [body appendData:[@"Content-Disposition: attachment; name=\"iphoneimage\"; filename=\"111.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

//        [[body appendData: [NSString stringWithString:@""]];
        
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        
        NSLog(@"Image Data in FileUpload %@",imageData);
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"Body Data %@",body);
        [apiURLRequest setHTTPBody:body];  */
    }

- (void) proceedConnection
{
    NSData *data1 = [apiURLRequest HTTPBody];

    NSLog(@"vishnu length \n\n\n\n %d \n\n\n\n",     data1.length);
    NSHTTPURLResponse *authenticationResponse= nil;
    NSError *error=nil;
    receivedData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:apiURLRequest  returningResponse:&authenticationResponse  error:&error];
    _apiRawData=receivedData;
    apiResponse = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"request url riyaz \n\n\n %@\n\n\n",apiURLRequest.URL.absoluteString);

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
    apiResponse = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
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
