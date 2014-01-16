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
    
    if ([rawString isKindOfClass:[NSString class]]) {
    //NSLog@"raw string urlstring: %@",rawString);
    NSMutableDictionary *returnList = [[NSMutableDictionary alloc] init];
    if(rawString != nil && ![rawString isEqualToString:@"(null)"]) {
        
        NSRange href_range = [rawString rangeOfString:@"href= \""];
        NSRange target_range = [rawString rangeOfString:@" target = \""];
        NSRange title_range = [rawString rangeOfString:@" title = \""];
        
        //NSLog@"href range : %@",NSStringFromRange(href_range));
        //NSLog@"target range : %@",NSStringFromRange(target_range));
        //NSLog@"title range : %@",NSStringFromRange(title_range));
        // <a href= "http://zoho.com" target = "_blank">zoho.com</a>
        
        if(href_range.length == 0) {
            return nil;
            //            [NSException raise:@"URL" format:@"Invalid String"];
        }
        
        NSRange range;
        range.location =href_range.location + href_range.length;
        
        NSRange titleRange1 = [rawString rangeOfString:@">" ];
        NSRange titleRange2 = [rawString rangeOfString:@"</a>"];
        
        
        if(title_range.length != 0) {
            range.length = title_range.location - (href_range.location + href_range.length + 1);
        }
        else if(target_range.length != 0) {
            range.length = target_range.location - (href_range.location + href_range.length + 1);
        }
        else {
            range.length = titleRange1.location - (href_range.location + href_range.length +1);
        }
        
        [returnList setObject:[rawString substringWithRange:range] forKey:@"url"];
        
        //NSLog@"Url subString range : %@",NSStringFromRange(range));
        //NSLog@"Url subString %@",[rawString substringWithRange:range]);
        
        
        NSRange target;
        
        target.location = target_range.location+1;
        
        
        if (!target_range.length == 0)
            
        {
            
            target.length = titleRange1.location - (target_range.location+target_range.length+1);
            
            //////NSLog@"target length value is : %d",target.length);
            
        }
        
        else
            
        {
            
            target.length = 0 ;
            
        }
        
        if (title_range.location!=NSNotFound) {
            
            NSRange titleRange;
            
            titleRange.location = title_range.location+title_range.length;
            
            
            titleRange.length = titleRange1.location - (title_range.location+title_range.length+target_range.length+target.length+2);
            
            
            //NSLog@"title length value is :%d",titleRange.length);
            
            [returnList setObject:[rawString substringWithRange:titleRange] forKey:@"title"];
            
            //NSLog@"title gee %@",[rawString substringWithRange:titleRange]);

        }
        
        NSRange linkRange;
        
        linkRange.location = titleRange1.location + 1;
        
        linkRange.length = titleRange2.location - (titleRange1.location + titleRange1.length);
        
        [returnList setObject:[rawString substringWithRange:linkRange] forKey:@"urllinkname"];
        
        ////NSLog@"link %@",[rawString substringWithRange:linkRange]);
        
        
        
        return returnList;
        
    }
    else {
        return nil;
    }
    }
    else if([rawString isKindOfClass:[NSDictionary class]])
    {
       return (NSMutableDictionary*)rawString;
}
    return Nil;
    
}

+ (NSString*) getURL : (NSString*) rawString {
    
    ////// ////NSLog@"Raw String %@",rawString);
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

+ (NSString*) getImageLocationURLString : (NSString*) rawString {
    
    //NSLog@" Raw String %@",rawString);
    
    if(rawString != nil && ![rawString isEqualToString:@"(null)"]) {
        
//        NSRange srange = [rawString rangeOfString:@"src = "];
//        NSRange erange = [rawString rangeOfString:@" border ="];
//        
//        if(srange.length == 0) {
//            return nil;
//            //            [NSException raise:@"Image Error" format:@"Invalid String"];
//        }
//        NSRange range;
//        range.location =srange.location + srange.length + 1;
//        range.length = erange.location - (srange.location + srange.length + 2);
//        
//        
//        NSString * stringtoPArse=[rawString substringWithRange:range];
        
        NSURL *validURL = [NSURL URLWithString:rawString];
        if (validURL && validURL.scheme && validURL.host) {
            
            return rawString;//It means that image field has been updated using link option & file upload
        }
        
        NSArray * stringarray = [rawString componentsSeparatedByString:@"/"];
        //NSLog@"url array : %@",stringarray);
        
//        NSString* finalURL = [URLConstructor downloadFile:[NSString stringWithFormat:@"/%@",[stringarray lastObject]] viewLinkName:[stringarray objectAtIndex:3] :[stringarray objectAtIndex:2] :[stringarray objectAtIndex:1]];
        
        return [NSString stringWithFormat:@"/%@",[stringarray lastObject]];
        
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

+ (NSString*) extactSringFormSubformData : (NSString*) rawString {
    
    
//    NSRegularExpression *regexp_Form = [NSRegularExpression regularExpressionWithPattern: @"<div elName='zc-component' formLinkName='(.*)\\' params='(.*)\\</div>"options:NSRegularExpressionCaseInsensitive error:NULL];
    //NSLog@"QWFKLBKLXBKLSBFGKLSDBGKLSBDGKABSKBGASKGLA\n\n\n\n\n\n\n\n\n\n\n%@",rawString);
    rawString= [ParserUtil stringByStrippingHTML:rawString];
    //NSLog@"\n\n\n\n\n\n\n\n\n\n\n QWFKLBKLXBKLSBFGKLSDBGKLSBDGKABSKBGASKGLA%@\n\n\n\n\n\n\n\n\n\n\n",rawString);

    @try {

        rawString=[ParserUtil extact_URL_FormSubformData:rawString];
    }
    @catch (NSException *exception) {
        //NSLog@"exceptop in subform1 %@",exception);
    }
    @finally {
        
    }
    @try {
        
        rawString=[ParserUtil extact_Image_FormSubformData:rawString];
    }
    @catch (NSException *exception) {
        //NSLog@"exceptop in subform2%@",exception);
    }
    @finally {
        
    }


    
    return rawString;
}
+(NSString *) stringByStrippingHTML:(NSString *)string
{
    if (string ==NULL || [string isEqualToString:@""] || [string isEqualToString:@"(null)"]) {
        return @"";
    }
    NSRange r;
    while ((r = [string rangeOfString:@"<br>" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@"\n"];
    while ((r = [string rangeOfString:@"(null)" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@""];
    //    while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    //        string = [string stringByReplacingCharactersInRange:r withString:@""];
    
    while ((r = [string rangeOfString:@"&nbsp;" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@" "];
    while ((r = [string rangeOfString:@"&nbsp" options:NSRegularExpressionSearch]).location != NSNotFound)
        string = [string stringByReplacingCharactersInRange:r withString:@" "];

    return string;
}



+(NSString *) extact_URL_FormSubformData:(NSString *)rawString
{
    
//    return rawString;
    NSRegularExpression *regexpURL = [NSRegularExpression regularExpressionWithPattern: @"(.*)<a href=(.*)\\</a>(.*)"options:NSRegularExpressionCaseInsensitive error:NULL];
    
    NSTextCheckingResult *matchURL = [regexpURL firstMatchInString:rawString options:0 range:NSMakeRange(0, rawString.length)];
    
    NSString * linkSource;
    NSString * linkTag;
    if (matchURL) {
        for (int i=0;i<[matchURL numberOfRanges];i++ ) {
            
            
            NSRange  hashRange = [matchURL rangeAtIndex:i];
            NSString *hashCode = [rawString  substringWithRange:hashRange];
            if (i==2) {
                
                linkTag=[NSString stringWithFormat:@"<a href=%@</a>",hashCode];
            }
            
            NSArray * array=[hashCode componentsSeparatedByString:@"\""];
            
            //NSLog@"arrar %@",array);
            if (array.count>1) {
                
                linkSource=[array objectAtIndex:1];
                
            }

            //NSLog@" FormHash Code is %@", hashCode);
            //NSLog@"range at index %i  %i",[matchURL rangeAtIndex:i].location,[matchURL rangeAtIndex:i].length);
        }
    }
    
    if (linkSource) {
        rawString=    [rawString stringByReplacingOccurrencesOfString:linkTag withString:[NSString stringWithFormat:@"<br>%@",[[ParserUtil getURLString:linkTag]objectForKey:@"url"]]];
    }
    //NSLog@"rawstirng view %@",rawString);


    return rawString;
}
+(NSString *) extact_Image_FormSubformData:(NSString *)rawString
{
    
    NSRegularExpression *regexpImage = [NSRegularExpression regularExpressionWithPattern: @"(.*)<img src =(.*)\\</img>(.*)"options:NSRegularExpressionCaseInsensitive error:NULL];
    
    NSTextCheckingResult *matchImage = [regexpImage firstMatchInString:rawString options:0 range:NSMakeRange(0, rawString.length)];
    
    NSString * imageTag;
    NSString * imageSource;
    
    if (matchImage) {
        for (int i=0;i<[matchImage numberOfRanges];i++ ) {
            
            
            NSRange  hashRange = [matchImage rangeAtIndex:i];
            NSString *hashCode = [rawString  substringWithRange:hashRange];
            if (i==2) {
                
                imageTag=[NSString stringWithFormat:@"<img src =%@</img>",hashCode];
                
                NSArray * array=[hashCode componentsSeparatedByString:@"\""];
                
                //NSLog@"arrar %@",array);
                if (array.count>1) {
                    
                    imageSource=[array objectAtIndex:1];
                    
                }
                
            }
            
//            //NSLog@" FormHash Code is %@", hashCode);
//            //NSLog@"range at index %i  %i",[matchImage rangeAtIndex:i].location,[matchImage rangeAtIndex:i].length);
        }
    }
    
//    rawString=    [rawString stringByReplacingOccurrencesOfString:imageSource withString:@"<br><  image  >"];
    if (imageTag) {
    rawString=    [rawString stringByReplacingOccurrencesOfString:imageTag withString:[NSString stringWithFormat:@"<br>%@",[ParserUtil getImageLocationURLString:imageSource]]];
    }
    return rawString;
}

@end
