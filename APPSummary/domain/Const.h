//
//  Const.h
//  APPSummary
//
//  Created by xubojoy on 2018/2/26.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define request_url @"http://xubojoy.cn"


#define screen_width          [UIScreen mainScreen].bounds.size.width
#define screen_height          [UIScreen mainScreen].bounds.size.height
// 判断是否支持TouchID,只判断手机端，ipad端我们不支持
#define IS_Phone        (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone
#define IOS8_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

OBJC_EXTERN CFStringRef MGCopyAnswer(CFStringRef key) WEAK_IMPORT_ATTRIBUTE;

//是否是空对象
#define LMJIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
//防止循环引用
#define WeakObj(obj) __weak typeof(obj) obj##Weak = obj

//尺寸
#define BAScreenHeight [UIScreen mainScreen].bounds.size.height//屏幕高度
#define BAScreenWidth [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define BAPadding 10 //间隔
#define BARadius 6 //圆角

//判断是否为4inch
#define Screen40inch ([UIScreen mainScreen].bounds.size.height == 568)
//判断是否为4.7inch
#define Screen47inch ([UIScreen mainScreen].bounds.size.height == 667)
//判断是否为5.5inch
#define Screen55inch ([UIScreen mainScreen].bounds.size.height == 736)
//判断是否为5.8inch
#define Screen58inch ([UIScreen mainScreen].bounds.size.height == 812)

//字体
#define BAThinFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightUltraLight]
#define BACommonFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightThin]
#define BABlodFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightBold]
#define BAWhiteColor [UIColor whiteColor] //白色

//#to 适配X--------------------
#define IOS8  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)?YES:NO

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define Nav_Height (kDevice_Is_iPhoneX ? 88 : 64)
#define Status_Height (kDevice_Is_iPhoneX ? 44 : 20)
#define Tabbar_Height (kDevice_Is_iPhoneX ? 83 : 49)

#define splite_line_height 0.5

//字体大小
#define font_10_size  10
#define font_11_size  11
#define font_12_size  12
#define font_13_size  13
#define font_14_size  14
#define font_15_size  15
#define font_16_size  16
#define font_17_size  17
#define font_18_size  18
#define font_24_size  24

//颜色
#define splite_line_color @"#cccccc"

#define gray_light_color  @"#8C8481"
#define dark_light_color  @"#515151"


#define CWScreenW [UIScreen mainScreen].bounds.size.width
#define CWScreenH [UIScreen mainScreen].bounds.size.height
#define radian(angle) M_PI * angle / 180.0
#define ONEBackgroundColor [UIColor colorWithWhite:238/255.0 alpha:1.0]
#define kNavigationBarHeight 64.0
#define kTabBarHeight 49.0
#define kCatalogueAnimationDuration 0.3
#define kCurrentDateString @"Today"

#define ONECommentIdKey @"commentId"
#define ONEEssayItemKey @"essayItem"
#define ONEPhotoArrayKey @"photoArray"
#define ONEMenuItemKey @"menuItem"
#define ONEIndexKey @"index"
#define ONEDateStringKey @"dataString"
#define ONECityNameKey @"cityName"

#define ONECoverPresentationImageKey @"ONECoverPresentationImage"
#define ONECoverPresentationImageOrientationKey @"ONECoverPresentationImageOrientation"
#define ONECoverPresentationSubTitleKey @"ONECoverPresentationSubTitle"
#define ONECoverPresentationSerialStringKey @"ONECoverPresentationSerialString"
#define ONECoverPresentationOriginFrameKey @"ONECoverPresentationOriginFrame"
#define ONEDiaryPresentationContentKey @"ONEDiaryPresentationContent"
#define ONEDiaryPresentationAuthorInfoKey @"ONEDiaryPresentationAuthorInfo"
#define ONEDiartPresentationShareUrlKey @"ONEDiartPresentationShareUrl"

#import "UIColor+CWQuickCreate.h"
#import "UIView+CWFrame.h"
#import "ONEConst.h"

@interface Const : NSObject

@end
