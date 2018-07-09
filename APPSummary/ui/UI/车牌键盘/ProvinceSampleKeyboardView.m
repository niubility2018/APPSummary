//
//  ProvinceSampleKeyboardView.m
//  DaBaiCai
//
//  Created by DBC on 2018/6/8.
//  Copyright © 2018年 大白菜. All rights reserved.
//

#import "ProvinceSampleKeyboardView.h"

@interface ProvinceSampleKeyboardView()
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation ProvinceSampleKeyboardView

+ (instancetype)fretchSelfXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
}

+(ProvinceSampleKeyboardView *)showWidthAnimation:(BOOL)animated{
    [ProvinceSampleKeyboardView hideWithAnimation:NO];
    ProvinceSampleKeyboardView *keyboard = [ProvinceSampleKeyboardView fretchSelfXib];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window == nil) {
        return nil;
    }
    [window addSubview:keyboard];
    
    if (animated) {
        keyboard.frame = CGRectMake(0, screenHeight, screenWidth, kProvinceSampleKeyboardViewHeight);
        [UIView animateWithDuration:0.35 animations:^{
            keyboard.frame = CGRectMake(0, screenHeight-kProvinceSampleKeyboardViewHeight, screenWidth, kProvinceSampleKeyboardViewHeight);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        keyboard.frame = CGRectMake(0, screenHeight-kProvinceSampleKeyboardViewHeight, screenWidth, kProvinceSampleKeyboardViewHeight);
    }
    keyboard.tag = 20180705;
    return keyboard;
}

+(void)hideWithAnimation:(BOOL)animated{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = [window viewWithTag:20180705];
    if (animated) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        [UIView animateWithDuration:0.35 animations:^{
            view.frame = CGRectMake(0, screenHeight, screenWidth, kProvinceSampleKeyboardViewHeight);
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    } else {
        [view removeFromSuperview];
    }
}

-(void)setHideDeleteButton:(BOOL)hideDeleteButton{
    _hideDeleteButton = hideDeleteButton;
    self.clearButton.hidden = hideDeleteButton;
}

- (IBAction)buttonAction:(UIButton *)button {
    NSInteger tag = button.tag;
    NSString *text = [self provinceSampleWithIndex:tag];
    NSLog(@"%@", text);
    if (self.block) {
        self.block(text);
    }
}


- (IBAction)clearButtonAction:(id)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}




-(NSString *)provinceSampleWithIndex:(NSInteger)index{
    switch (index) {
        case 0:return @"京";
        case 1:return @"沪";
        case 2:return @"粤";
        case 3:return @"津";
        case 4:return @"冀";
        case 5:return @"晋";
        case 6:return @"蒙";
        case 7:return @"辽";
        case 8:return @"吉";
        case 9:return @"黑";
            
        case 10:return @"苏";
        case 11:return @"浙";
        case 12:return @"皖";
        case 13:return @"闽";
        case 14:return @"赣";
        case 15:return @"鲁";
        case 16:return @"豫";
        case 17:return @"鄂";
        case 18:return @"湘";
            
        case 19:return @"桂";
        case 20:return @"琼";
        case 21:return @"渝";
        case 22:return @"川";
        case 23:return @"贵";
        case 24:return @"云";
        case 25:return @"藏";
            
        case 26:return @"陕";
        case 27:return @"甘";
        case 28:return @"青";
        case 29:return @"宁";
        case 30:return @"新";
            
        default:
            break;
    }
    return @"";
}

@end
