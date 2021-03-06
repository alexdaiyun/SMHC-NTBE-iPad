//
//  Constants.h
//  定义标识符、常量
//

#ifndef Constants_h
#define Constants_h

#pragma mark - App

#define AppDBName                           @"NTBELabsData.sqlite"

#define LabsOrgName                         @"NTBELabs"

#define AppHandleOpenURL                    @"NTBELabs"


#define AppDBFullPath                           [PATH_OF_DOCUMENT stringByAppendingPathComponent:AppDBName]



#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0

#define kTextFieldHeight		30.0

#define kMasterWidth            224.0f
#define kSplitWidth             1.0f

#define LOADVIEWBOXSIZE         100
#define LOADINGVIEWTAG          -11

#pragma mark - App Color

// R:0 G:166 B:92 #00a65c  绿
// R:73 G:182 B:122 #49b679 亮绿

// R:0 G:187 B:160 #00bba0  洋绿
// R:180 G:238 B:231 #b3eee7 浅洋绿
// R:217 G:247 B:242 #d9f7f2 更浅洋绿

// R:255 G:48 B:71 #ff3047  红色
// R:241 G:241 B:241 #f1f1f1 浅白
// R:219 G:219 B:219 #dbdbdb 更浅灰
// R:234 G:234 B:234 #eaeaea 浅灰
// R:157 G:157 B:157 #9d9d9d 灰


#define kAppPrimaryColor             UIColorFromRGB(0x00bba0)
#define kAppSecondaryColor           UIColorFromRGB(0x00a65c)

#define kNavigationTextColor         UIColorFromRGB(0xffffff)

#define kAppLinkColor                UIColorFromRGB(0x49b679)
#define kAppTextCellColor            UIColorFromRGB(0x333333) //RGB( 57.0f, 85.0f, 135.0f )
#define kGroupTableViewBackgroundColor UIColorFromRGB(0xf0f0f0)






//
//#define DAFileFolder     @"FileData"
//#define UploadFileFolder   @"UploadFile"
//#define WWWDocumentRoot  @"WiFiTransfer"
//
//
//#define DefaultDAFilePath   [PATH_OF_APP_RESOURCE stringByAppendingPathComponent:DAFileFolder]
//// <Application_Home>/Library/<Application Support>/FileData
//#define AppDAFilePath       [PATH_OF_APP_SUPPORT stringByAppendingPathComponent:DAFileFolder]
//// <Application_Home>/<App>/WiFiTransfer
//#define WWWDocumentRootPath [PATH_OF_APP_RESOURCE stringByAppendingPathComponent:WWWDocumentRoot]
//// <Application_Home>/tmp/UploadFile
//#define AppUploadFilePath   [PATH_OF_TEMP  stringByAppendingPathComponent:UploadFileFolder]
//// <Application_Home>/tmp/FileData
//#define AppDAFileTmpPath    [PATH_OF_TEMP  stringByAppendingPathComponent:DAFileFolder]


#pragma mark - custom constants

#define ScaleLevel_FilePath     @"ScaleLevel"
#define ScaleLevel_ConfigFile   @"Config_ScaleLevel.plist"


#endif

typedef enum {
    ScaleLevelMMSE, //简明精神状态检查
    ScaleLevelMOCA, //蒙特利尔认知评估
    ScaleLevelNTB,  //成套神经心理测验
    ScaleLevelSAS,  //焦虑自评量表
    ScaleLevelGDS,  //老年抑郁量表
    ScaleLevelLES,  //生活事件量表
    ScaleLevelSSRS  //社会支持评定量表
} ScaleLevelTag; //量表Tag

typedef enum {
    QTText
    
} QuestionType; //题目类型


 