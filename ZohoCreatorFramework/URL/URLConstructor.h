//
//  URLConstructor.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 15/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZOHOUser.h"
#import "ZCViewParam.h"
#import "ZCCriteria.h"
#import "ZCApplication.h"
#import "ZCRecord.h"

@interface URLConstructor : NSObject

+ (NSString*) formURL : (NSString*) appLinkName formName : (NSString*) formLinkName withApplicationOwner: (NSString *) appOwner;
+ (NSString*) formURL : (NSString*) appLinkName formName : (NSString*) formLinkName viewName:(NSString*) viewLinkName withApplicationOwner: (NSString *) appOwner;
+ (NSString*) appListURL;
+ (NSString*) sharedAppListURL;
+ (NSString*) sharedAppListURL : (NSString *) groupid;
+ (NSString*) allAppsCategoryListURL;
+ (NSString*) workSpaceAppListURL : (NSString *) workspaceowner;
+ (NSString*) sectionMetaURL : (NSString*) appLinkName appOwner: (NSString *) appOwner;
+ (NSString*) sectionMetaURL : (NSString*) appLinkName : (NSString*) section appOwner: (NSString *) appOwner;
+ (NSString*) viewURL : (NSString*) appLinkName : (NSString*) viewLinkName appOwner: (NSString *) appOwner;
+ (NSString*) viewURL : (NSString*) appLinkName : (NSString*) viewLinkName withParam : (ZCViewParam*) viewParam appOwner: (NSString *) appOwner;
+ (NSString*) recordCountURL : (NSString*) appLinkName : (NSString*) viewLinkName withParam : (ZCViewParam*) viewParam appOwner: (NSString *) appOwner;
+ (NSString*) formMetaURL : (NSString*) appLinkName : (NSString*) formLinkName appOwner: (NSString *) appOwner;

+(NSString *) subformMetaURL:(NSString *)appLinkName formLinkname:(NSString *)formLinkName mainAppLinkname:(NSString *)mainAppLinkname  mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname appOwner:(NSString *)appOwner;

+ (NSString*) uploadURL : (NSString*) applicationName : (NSString*) formName : (NSString*) fieldName : (NSString*) recordID : (NSString*) fileName : (NSString*) appOwner;
+ (NSString*) formOnLoad:(NSString*) appLinkName : (NSString*) formLinkName : (NSString*) paramString : (NSString*) appOwner;
+ (NSString*) formEditOnLoad:(NSString*) appLinkName : (NSString*) formLinkName  : (NSString*) paramString : (NSString*) appOwner;
+ (NSString*) sunFormOnUser:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) subFormName : (NSString*) fieldLinkName;
+ (NSString*) fieldOnUser:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldLinkName : (NSString*) paramString;
+ (NSString*) buttonOnClick:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) buttonName : (NSString*) paramString;
+ (NSString*) subFormAddRow:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldNamee : (NSString*) paramString;
+ (NSString*) subFormDeleteRow:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldName : (NSString*) paramString;
+ (NSString*) customActionURL : (NSString*) appLinkName : (NSString*) viewLinkName : (NSString*) functionId : (NSString*) sharedBy : (NSMutableArray*) recordIds;
+ (NSString*) newRecordURL : (NSString*) appLinkName : (NSString*) formLinkName;
+ (NSString*) editRecordURL : (NSString*) appLinkName : (NSString*) formLinkName;
+ (NSString*) deleteRecordURL : (NSString*) appLinkName : (NSString*) formLinkName;
+ (NSString*) postAuthToken;
+ (NSString*) postAuthTokenWithAppOwner;
+ (NSString*) accountsURL : (NSString*) userName : (NSString*) password;
+ (NSString*) deleteAuthToken : (NSString*) authToken;
+ (NSString*) submitRecordURL;
+ (NSString*) newsubmitRecordURL;
+ (NSString*) writeURL;
+ (NSString*) postAuthTokenWithApplication : (ZCApplication*) _application;
+ (NSString*) postAuthTokenWithAppOwner : (NSString*) appOwner;
+ (NSString*)  serverURL : (BOOL) secureConnection;
+ (NSString*) userDetailsURL;
+ (NSString*) paymentDetails : (NSString*) ownerName;
+ (NSString*) downloadFile : (NSString*) filePath viewLinkName : (NSString*) viewLinkName  : (NSString*) appLinkName : (NSString*) appOwner;
+ (NSString*) htmlView : (NSString*) appLinkName htmlViewLinkName : (NSString*) htmlViewLinkName applicationOwner : (NSString*) appOwner;
+ (NSString*) editFormMetaJSON : (NSString*) _appLinkName : (NSString*) _viewLinkName : (NSString*) _recordLinkID : (NSString*) appOwner;
+ (NSString*) editFormMetaURL : (NSString*) appLinkName : (NSString*) formLinkName recordLinkID : (NSString*) _recordLinkID appOwner: (NSString *) appOwner;
+ (NSString*) editFormMetaURL1 : (NSString*) appLinkName : (NSString*) formLinkName viewLinkName : (NSString*) viewLinkName recordLinkID : (NSString*) _recordLinkID appOwner: (NSString *) appOwner;
+(NSString *)authenticationUrl;
+ (NSString*) subFormOnuser : (NSString*) appLinkName : (NSString*) formLinkName : (NSString*) fieldName : (NSString*) refAppName : (NSString*) refFormName : (NSString*) refFieldName : (NSString*) paramString : (NSString*) appOwner;
+ (NSString*) fieldOnUserFormaula:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldLinkName : (NSString*) paramString;
+ (NSString*) delugeURL;
+ (NSString*) formOnLoadWithJSON :(NSString*) appLinkName : (NSString*) formLinkName : (ZCRecord*) _zcRecord : (NSString*) appOwner;
+ (NSString*) fieldOnUserWithJSON:(NSString *)appLinkName :(NSString *)formLinkName : (NSString*) fieldLinkName : (NSString*) paramString : (NSString*) appOwner;
+ (NSString*) subFormOnuserWithJSON : (NSString*) appLinkName formLinkname: (NSString*) formLinkName fieldlinkname: (NSString*) fieldName subformFieldName:(NSString *)subformFieldname rowNumberincaseOFsubofrmField:(int)rownum param: (NSString*) paramString appowner: (NSString*) appOwner;
+(NSString *)construckLookupChoicesURLWithAppLinkname:(NSString *)appLinkName formLinkname:(NSString *)formLinkName lookUpFieldLinkName:(NSString *)lookupFieldName appOwner:(NSString *)appOwner subformComponent:(NSString *)subformComponent searchString: (NSString *)searchString startindex:(int)startIndex limit:(int)limit;
+(NSString *)subFormAddRowWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName numberofsubformEntries:(int)numberofsubformEntries appOwner:(NSString *)appOwner recordParm:(NSString *)params;
+(NSString *)subFormONDELETERowWithAppLinkname:(NSString *)appLinkName formLinkName:(NSString *)formLinkName fieldLinkName:(NSString *)fieldLinkName deleteRowNumber:(int)deleteRowNumber appOwner:(NSString *)appOwner recordParm:(NSString *)params;
@end
