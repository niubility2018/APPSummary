//
//  MusicListCell.h
//  APPSummary
//
//  Created by xubojoy on 2018/2/27.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQMusicModel.h"
@interface MusicListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UILabel *songNameLabel;
@property (nonatomic, strong) UILabel *singerLabel;

- (void)renderMusicListCell:(QQMusicModel *)qqMusicModel;
@end
