//
//  ZCSectionParser.h
//  ZohoCreator
//
//  Created by ZOHOCORP\vishnu-0895 on 14/09/12.
//  Copyright (c) 2012 ZOHOCORP\vishnu-0895. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCSections.h"
#import "ZCSection.h"
#import "ZCComponent.h"
#import "ZCApplication.h"
typedef enum
{
    ZCLayoutCreator = 1,
    ZCLayoutSliderMenu = 2,
    ZCLayoutTapBar = 3,
    ZCLayoutTapMenuBottom = 4,
    ZCLayoutTapMenuTop = 5,
    ZCLayoutPlainList = 6,
    ZCLayoutGroupedList = 7,
    ZCLayoutCoverFlow = 8,
    ZCLayoutLinear = 9,
    ZCLayoutInvertedRotary = 10,
    ZCLayoutCylinder = 11,
    ZCLayoutInvertedCylinder = 12,
    ZCLayoutWheel = 13,
    ZCLayoutInvertedWheel = 14,
    ZCLayoutTimeMachine = 15,
    ZCLayoutInvertedTimeMachine = 16,
    ZCLayoutCoverFlow2 = 17,
    ZCLayoutCustom = 18,
    MCDefaultLayout =101
}ZCLayoutType;
@class ZCApplication;

enum BASE {
    BASE_SECTIONS=1,
};

enum SECTIONS {

    SECTIONS_SECTION=1,
    SECTIONS_NONE=-1,
};

enum SECTION {
    
    SECTION_SECTION=1,
    SECTION_COMPONENT=2,
    SECTION_NONE=-1,
};

@interface ZCSectionParser : NSObject <NSXMLParserDelegate>  {
    
@private
    //Mathan added
    NSMutableArray *sectionsArray;
    NSMutableDictionary *columnDict;
    NSMutableDictionary *sectionsDict;
    NSMutableDictionary *rowsDict;
    NSMutableArray *columnsArray;
    int layoutType;
    //
    NSXMLParser *_xmlParser;
    NSString *_xmlString;
    NSString *_currentElementValue;
    NSString *_currentElementName;
    NSInteger _baseElement;
    NSInteger _sectionsElement;
    NSInteger _sectionElement;
    ZCSection *_zcSection;
    ZCComponent *_zcComponent;
@private ZCApplication *_application;
}

@property (nonatomic,retain) ZCSections* zcSections;

- (ZCSectionParser*) initZCSectionParser : (NSString*) xmlString : (ZCApplication*) _application;

@end
