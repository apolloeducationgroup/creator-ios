//
//  FieldOnuserEvent.m
//  ZohoCreator
//
//  Created by Riyaz Mohammed on 12/09/13.
//  Copyright (c) 2013 ZOHOCorp. All rights reserved.
//

#import "FieldOnuserEvent.h"
#import "ZCSharedAppsEventsParamsUtil.h"
@implementation FieldOnuserEvent
- (FieldOnuserEvent*) initFieldOnUserEventWithFieldAppname: (NSString*) _appLocal fieldFormName: (NSString*) _formLocal fieldName:(NSString*) _fieldLocal parmString:(NSString*) paramString delegate:(id) delegate  fieldBElongToSubForm:(BOOL)subform mainAppLinkname:(NSString *)mainAppLinkname mainFormLinkname:(NSString *)mainFormLinkname subformFieldLinkname:(NSString *)subformFieldLinkname appOwner:(NSString *)appowner  {
    
    self = [super init];
    
    if(self) {
        if (subform) {
            //            [super setDelugeURL:[URLConstructor fieldOnUser:_appLocal :_formLocal:_fieldLocal:paramString]];
            _subform=YES;
      subformOnuser=[[SubFormOnUser alloc]initSubFormOnUser:_appLocal :_formLocal :_fieldLocal :mainAppLinkname :mainFormLinkname :subformFieldLinkname :paramString :appowner :delegate  ];
            
        }
        else
        {
            fieldonuser=[[FieldOnUser alloc]initFieldOnUser:_appLocal formname:_formLocal fieldname:_fieldLocal paramstring:paramString delegate:delegate appowner:appowner ];
//            fieldonuser=[[FieldOnUser alloc]initFieldOnUser:_appLocal :_formLocal :_fieldLocal :paramString :delegate:appowner ];
        }
    }
    return self;
}

- (FieldOnuserEvent*) initFieldOnUserEventWithFieldAppname: (NSString*) _appLocal fieldFormName: (NSString*) _formLocal fieldName:(NSString*) _fieldLocal parmString:(NSString*) paramString delegate:(id) delegate rowNumberincaseOFsubofrmField:(int)rownum subformFieldName:(NSString *)subformFieldname appOwner:(NSString *)appowner 


{

    
    self = [super init];

    if(self) {
        

        if (rownum) {
            //            [super setDelugeURL:[URLConstructor fieldOnUser:_appLocal :_formLocal:_fieldLocal:paramString]];
            _subform=YES;
//                subformOnuser=[[SubFormOnUser alloc]initSubFormOnUser:_appLocal :_formLocal :_fieldLocal :paramString :appowner :delegate subformFieldName:subformFieldname rowNumberincaseOFsubofrmField:rownum];
        subformOnuser=[[SubFormOnUser alloc]initSubFormOnUser:_appLocal formname:_formLocal fieldname:_fieldLocal param:paramString appowner:appowner :delegate subformFieldName:subformFieldname rowNumberincaseOFsubofrmField:rownum isformula:Nil];
//            fieldonuser=[[FieldOnUser alloc]initFieldOnUser:_appLocal :_formLocal :_fieldLocal :paramString :delegate:appowner ];
            
        }
        else
            
            
        {
            fieldonuser=[[FieldOnUser alloc]initFieldOnUser:_appLocal formname:_formLocal fieldname:_fieldLocal paramstring:paramString delegate:delegate appowner:appowner ];
        }
    }
    return self;
    



}

//- (FieldOnuserEvent*) initFieldOnUser : (NSString*) _appLocal : (NSString*) _formLocal : (NSString*) _fieldLocal : (NSString*) paramString : (id) delegate {
//    self = [super init];
//    if(self) {
//        [super setCallerDelegate:delegate];
//        [super setDelugeURL:[URLConstructor fieldOnUser:_appLocal :_formLocal:_fieldLocal:paramString]];
//        //// ////NSLog@"On User URL %@",[super delugeURL]);
//        //// ////NSLog@"deluge initiated...with app : %@, form : %@, field : %@, param : %@ delegate class : %@",_appLocal,_formLocal,_fieldLocal,paramString,[delegate class]);
//    }
//    return self;
//}
- (FieldOnuserEvent*) initFieldOnUserEventWithFieldAppname: (NSString*) _appLocal fieldFormName: (NSString*) _formLocal fieldName:(NSString*) _fieldLocal parmString:(NSString*) paramString delegate:(id)delegate rowNumberincaseOFsubofrmField:(int)rownum subformFieldName:(NSString *)subformFieldname recordIDIncaseOFEDITFORM:(NSString *)recID viewLinkname:(NSString *)viewLinkname childAppsIncaseOFAddTOPickListForm:(NSArray *)apps childforms:(NSArray *)forms basefields:(NSArray *)fields appOwner:(NSString *)appowner isformula:(BOOL)isFormula

{
    
    
    
    
self = [super init];
    
    if(self) {
        
          paramString=[paramString stringByAppendingString:[ZCSharedAppsEventsParamsUtil getAddtoPickListParamsWithAPPS:apps Forms:forms fields:fields viewLinkname:viewLinkname recordID:recID deluge:YES]];
        
        
        if (isFormula) {
            
            paramString=[paramString stringByAppendingString:@"&isFormula=true"];
        }
        

        if (rownum) {
            
                        //            [super setDelugeURL:[URLConstructor fieldOnUser:_appLocal :_formLocal:_fieldLocal:paramString]];
            _subform=YES;
            //                subformOnuser=[[SubFormOnUser alloc]initSubFormOnUser:_appLocal :_formLocal :_fieldLocal :paramString :appowner :delegate subformFieldName:subformFieldname rowNumberincaseOFsubofrmField:rownum];
            subformOnuser=[[SubFormOnUser alloc]initSubFormOnUser:_appLocal formname:_formLocal fieldname:_fieldLocal param:paramString appowner:appowner :delegate subformFieldName:subformFieldname rowNumberincaseOFsubofrmField:rownum isformula:isFormula];
            //            fieldonuser=[[FieldOnUser alloc]initFieldOnUser:_appLocal :_formLocal :_fieldLocal :paramString :delegate:appowner ];
            
        }
        else
            
            
        {
            fieldonuser=[[FieldOnUser alloc]initFieldOnUser:_appLocal formname:_formLocal fieldname:_fieldLocal paramstring:paramString delegate:delegate appowner:appowner ];
        }
    }
    return self;

    
    
    
}
- (DelugeTasks*) execute {
    if (_subform) {
        
        return [subformOnuser execute];

    }
    else
    {
        return [fieldonuser execute];
    }
    
    
}



@end