//
//  ONEDetailCommentCell.h
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ONECommentItem;
@class ONEUserItem;

@interface ONEDetailCommentCell : UITableViewCell

@property (strong, nonatomic) NSString *typeName;

@property (strong, nonatomic) ONECommentItem *commentItem;

@property (strong, nonatomic) UIColor *fontColor;

@property (copy, nonatomic) void(^userButtonClickOperation)(ONEUserItem *);

@end
