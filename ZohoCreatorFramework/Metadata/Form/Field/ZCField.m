//
//  ZCField.m
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 21/08/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import "ZCField.h"

@implementation ZCField

@synthesize fieldName=_fieldName,fieldType=_fieldType,maxCharacter=_maxCharacter,fieldDisplayName=_fieldDisplayName,initialValues=_initialValues,isRequired=_isRequired,options=_options;
@synthesize relatedComponent=_relatedComponent,hasOnUserScript=_hasOnUserScript,addNewLinkText=_addNewLinkText,currencyType=_currencyType,subForm=_subForm,hasmaximumNumberOfRows=_hasmaximumNumberOfRows;
@synthesize hasSubFormOnUserScript=_hasSubFormOnUserScript,hasSubFormAddEvent=_hasSubFormAddEvent,hasSubFormDeleteEvent=_hasSubFormDeleteEvent,optionkeys=_optionkeys;
@synthesize hasInvolvedInFormula=_hasInvolvedInFormula,isHidden=_isHidden,isUnique=_isUnique,isAdminOnly=_isAdminOnly;
@synthesize subformRecords=_subformRecords,toolTip=_toolTip,isLookupField=_isLookupField,hasAllowNewEntries=_hasAllowNewEntries,decimalLength=_decimalLength;
@synthesize currencyDisplay=_currencyDisplay,currencyName=_currencyName,isUrlLinkName=_isUrlLinkName,isUrlTitle=_isUrlTitle,hasVisiblity=_hasVisiblity,defaultRows=_defaultRows;
- (ZCField*) initZCField {
    
    self = [super init];
    if(self) {
        
        self->_maxCharacter = -1;
        self->_defaultRows=0;
        self->_isRequired = YES;
        self->_initialValues = nil;
        self->_options = [[NSMutableArray alloc] init];
        self->_optionkeys = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addOptions : (NSString*) option {
    [_options addObject:option];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self->_fieldName=[aDecoder decodeObjectForKey:@"fieldName"];
    self->_fieldDisplayName=[aDecoder decodeObjectForKey:@"fieldDisplayName"];
    self->_fieldType= [aDecoder decodeIntForKey:@"fieldType"];
    self->_initialValues= [aDecoder decodeObjectForKey:@"initialValue"];
    self->_isRequired= [aDecoder decodeBoolForKey:@"isRequired"];
    self->_maxCharacter= [aDecoder decodeIntForKey:@"maxChar"];
    self->_relatedComponent = [aDecoder decodeObjectForKey:@"relatedComponent"];
    self->_addNewLinkText = [aDecoder decodeObjectForKey:@"addNewLinkText"];
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_fieldDisplayName forKey:@"fieldDisplayName"];
    [aCoder encodeObject:_fieldName forKey:@"fieldName"];
    [aCoder encodeInt:_fieldType forKey:@"fieldType"];
    [aCoder encodeInteger:_maxCharacter forKey:@"maxChar"];
    [aCoder encodeInteger:_isRequired forKey:@"isRequired"];
    [aCoder encodeObject:_initialValues forKey:@"initialValue"];
    [aCoder encodeObject:_relatedComponent forKey:@"relatedCompomnent"];
    [aCoder encodeObject:_addNewLinkText forKey:@"addNewLinkText"];
}


@end
