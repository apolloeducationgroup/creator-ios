//
//  ParserUtil.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 12/10/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ParserUtil.h"

@implementation ParserUtil

+ (ZCForm*) convertToZCForm : (ZCComponent*) component {
    
    ZCForm *zcForm = [[ZCForm alloc] initZCForm];
    [zcForm setDisplayName:[component displayName]];
    [zcForm setLinkName:[component linkName]];
    [zcForm setApplication:[component zcApplication]];
    return zcForm;
}

+ (ZCView*) convertToZCView : (ZCComponent*) component {
    
    ZCView *view = [[ZCView alloc] initZCView];
    [view setViewLinkName:[component linkName]];
    [view setViewDisplayName : [component displayName]];
    return view;
}

+ (NSMutableDictionary*) getURLString : (NSString*) rawString {
    
    NSMutableDictionary *returnList = [[NSMutableDictionary alloc] init];
    if(rawString != nil && ![rawString isEqualToString:@"(null)"]) {
        
        NSRange srange = [rawString rangeOfString:@"href= \""];
        NSRange erange = [rawString rangeOfString:@" target = \""];
        NSRange erange1 = [rawString rangeOfString:@" title = \""];
        
        
        // <a href= "http://zoho.com" target = "_blank">zoho.com</a>
        
        if(srange.length == 0) {
            return nil;
            //            [NSException raise:@"URL" format:@"Invalid String"];
        }
        NSRange range;
        range.location =srange.location + srange.length;
        
        NSRange titleRange1 = [rawString rangeOfString:@">" ];
        NSRange titleRange2 = [rawString rangeOfString:@"</a>"];
        
        
        if(erange1.length != 0) {
            range.length = erange1.location - (srange.location + srange.length + 1);
            
            
        }
        else if(erange.length != 0) {
            range.length = erange.location - (srange.location + srange.length + 1);
        }
        else {
            range.length = 0;
        }
        
        [returnList setObject:[rawString substringWithRange:range] forKey:@"url"];
        
        ////// //NSLog(@"Url String %@",[rawString substringWithRange:range]);
        
        
        NSRange target;
        
        target.location = erange.location+1;
        
        
        if (!erange.length == 0)
            
        {
            
            target.length = titleRange1.location - (erange.location+erange.length+1);
            
            ////NSLog(@"target length value is : %d",target.length);
            
        }
        
        else
            
        {
            
            target.length = 0 ;
            
        }
        
        NSRange titleRange;
        
        
        titleRange.location = erange1.location+erange1.length;
        
        
        titleRange.length = titleRange1.location - (erange1.location+erange1.length+erange.length+target.length+2);
        
        
        ////NSLog(@"title length value is :%d",titleRange.length);
        
        [returnList setObject:[rawString substringWithRange:titleRange] forKey:@"title"];
        
        //NSLog(@"title %@",[rawString substringWithRange:titleRange]);
        
        NSRange linkRange;
        
        linkRange.location = titleRange1.location + 1;
        
        linkRange.length = titleRange2.location - (titleRange1.location + titleRange1.length);
        
        [returnList setObject:[rawString substringWithRange:linkRange] forKey:@"linkname"];
        
        //NSLog(@"link %@",[rawString substringWithRange:linkRange]);
        
        
        
        return returnList;
    }
    else {
        return nil;
    }
}

+ (NSString*) getURL : (NSString*) rawString {
    
    ////// //NSLog(@"Raw String %@",rawString);
    if(rawString != nil && ![rawString isEqualToString:@"(null)"]) {
        
        NSRange srange = [rawString rangeOfString:@"href= \""];
        NSRange erange = [rawString rangeOfString:@" target = \""];
        
        // <a href= "http://zoho.com" target = "_blank">zoho.com</a>
        
        if(srange.length == 0) {
            return nil;
            //            [NSException raise:@"URL" format:@"Invalid String"];
        }
        NSRange range;
        range.location =srange.location + srange.length;
        
        
        if(erange.length != 0) {
            range.length = erange.location - (srange.location + srange.length + 1);
        }
        else {
            range.length = 0;
        }
        return [rawString substringWithRange:range];
    }
    else {
        return @"";
    }
}

+ (NSString*) getImageLocation : (NSString*) rawString {
    
    //////// //NSLog(@" Raw String %@",rawString);
    if(rawString != nil && ![rawString isEqualToString:@"(null)"]) {
        
        NSRange srange = [rawString rangeOfString:@"src = "];
        NSRange erange = [rawString rangeOfString:@" border ="];
        
        if(srange.length == 0) {
            return nil;
            //            [NSException raise:@"Image Error" format:@"Invalid String"];
        }
        NSRange range;
        range.location =srange.location + srange.length + 1;
        range.length = erange.location - (srange.location + srange.length + 2);
        
        
        NSString * stringtoPArse=[rawString substringWithRange:range];
        
        
        
        NSArray * stringarray=[stringtoPArse componentsSeparatedByString:@"/"];
        
        
        //        //NSLog(@"stigs %@",stringarray);
        return [NSString stringWithFormat:@"/%@",[stringarray objectAtIndex:[stringarray count]-1]];
        //        return [rawString substringWithRange:range];
        
    }
    else {
        return @"";
    }
}

+ (NSString*) extractEmailFromLink : (NSString*) rawString {
    
    if(rawString != nil && ![rawString isEqualToString:@"(null)"]) {
        
        NSRange srange = [rawString rangeOfString:@"<a href=mailto:"];
        NSRange erange = [rawString rangeOfString:@">"];
        if(srange.length > 0) {
            
            NSRange range;
            range.location =srange.location + srange.length;
            range.length = erange.location - range.location;
            return [rawString substringWithRange:range];
            
        }
        else {
            return rawString;
        }
    }
    else
    {
        return @"";
    }
    
}


@end
