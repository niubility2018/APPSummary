//
//  Constant.h
//  CustomAlertViewDemo
//
//  Created by xubojoy on 2018/2/7.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define navigation_height     64
#define status_bar_height     20
#define tabbar_height         51
#define general_margin        15
#define general_cell_height   44
#define reward_activity_banner_height   50
#define general_padding       10
#define general_space         20
#define general_space2         30
#define general_height        40
#define general_height_2      30
#define splite_line_height    0.5
#define main_vc_right_space     83
#define common_height        screen_width*1/2

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define screen_width          [UIScreen mainScreen].bounds.size.width
#define screen_height          [UIScreen mainScreen].bounds.size.height
#define general_screen_width_320  320
#define main_content_height   [UIScreen mainScreen].bounds.size.height - self.header.frame.size.height
#define bottomY(view)         view.frame.size.height + view.frame.origin.y
#define leftX(view)           view.frame.size.width + view.frame.origin.x
#define IOS6                  ([[[UIDevice currentDevice] systemVersion] floatValue] < 7)?YES:NO
#define IOS7                  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)?YES:NO
#define IOS8                  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)?YES:NO
#define loading_frame         CGRectMake(0, 100, screen_width, 40)
#define red_dot_width          7

#define debug 1

//字体大小
#define font_10_size  10
#define font_11_size   11
#define font_12_size     12
#define font_13_size 13
#define font_14_size   14
#define font_15_size 15
#define font_16_size       16
#define font_17_size  17
#define font_18_size    18
#define font_24_size   24
//色值
#define black_text_color          @"#222222"
#define gray_text_color           @"#666666"
#define gray_place_holder_color   @"#dcdcdc"
#define orange_text_color         @"#ff532b"
#define white_text_color          @"#ffffff"
#define light_gray_text_color     @"#999999"
#define lighter_gray_text_color   @"#cccccc"
#define lighter_2_gray_color      @"#f0f0f0"
#define backgroud_color           @"#f6f6f6"
#define common_bg_color           @"#f4f4f4"
#define head_backgroud_color      @"#e7523e"
#define searchBar_textField_background_color    @"#F67365"
#define splite_line_color         @"#cccccc"
#define red_color                 @"#cc0000"
#define blue_color                @"#3399ff"
#define red_default_color         @"#ea0000"
#define red_select_color          @"#cc3300"
#define green_background_color    @"#7cc576"
#define light_gray_color          @"#f2f2f2"
#define light_gray_2_color        @"#e5e5e5"
#define green_order_status_backgroud_color  @"#7cc576"
#define gray_order_status_backgroud_color   @"#cccccc"
#define blue_order_status_backgroud_color   @"#90c4f5"
#define orange_order_status_backgroud_color @"#ff9933"
#define common_btn_bg_color       @"#fc9a35"
#define splite_vertical_line_color  @"#6c6c6c"
#define color_c6c6c6   @"#c6c6c6"
//#7cbb73
#define common_splite_line_color  @"#eeeeee"
#define green_common_color        @"#49c28d"
#define black_common_color        @"#000000"
#define orange_common_color       @"#ff9900"
#define gray_common_color         @"#f2f2f2"
#define gray_line_color           @"#434343"
#define orange_notifi_color       @"#eb6100"
#define gray_placeholder_color    @"#f5f5f5"
#define common_content_color      @"#333333"
#define gray_color                @"#888888"
#define green_light_color         @"#49c28d"
#define green_dark_color          @"#32946b"
#define service_green_color       @"#7CCC2B"
#define service_blue_color        @"#2B96FA"
#define light_blue_color          @"#cae9dd"

#define deep_green_color          @"#00736d" //墨绿色
#define coffee_color              @"#ac6a00" //咖啡出色
#define header_color              @"#55000000"

#define game_type_green_color     @"#107271"
#define game_type_coffee_color    @"#ab6a1a"
#define game_type_purple_color    @"#666699"
#define unselect_title_color  @"#818181"

#define common_purple_color   @"#5E5C93"
@interface Constant : NSObject

@end
