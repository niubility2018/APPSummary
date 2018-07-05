//
//  WordAnimationController.h
//  APPSummary
//
//  Created by xubojoy on 2018/7/5.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCAnimatedLabel;
@interface WordAnimationController : UIViewController

@property (atomic) IBOutlet UISlider *durationSlider;
@property (atomic) IBOutlet UISlider *diffSlider;
@property (atomic) IBOutlet UITextField *titleTextField;
@property (atomic) IBOutlet UILabel *durationLabel;
@property (atomic) IBOutlet UILabel *diffLabel;

@property (atomic) IBOutlet UISegmentedControl *labelSegment;
@property (atomic) IBOutlet UISegmentedControl *breakSegment;
@property (nonatomic, strong) ZCAnimatedLabel *label;

@property (atomic) IBOutlet UIButton *effectButton;

@property (atomic) IBOutlet UIButton *animateAppearButton;
@property (atomic) IBOutlet UIButton *animateDisappearButton;
@property (atomic) IBOutlet UISwitch *debugRedraw;
@property (atomic) IBOutlet UISwitch *debugFrames;


@end
