//
//  MusicListCell.m
//  APPSummary
//
//  Created by xubojoy on 2018/2/27.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import "MusicListCell.h"
#import "UIView+ZJExtension.h"
@implementation MusicListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setUp];
}

- (void)setUp{
    self.logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 30, 30)];
    self.logoImgView.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.logoImgView];
//    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.contentView.mas_centerX);
//        make.left.mas_equalTo(15);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
    
    self.songNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.logoImgView.x+10, 7, 200, 15)];
    self.songNameLabel.textAlignment = NSTextAlignmentLeft;
    self.songNameLabel.font = [UIFont systemFontOfSize:font_15_size];
    self.songNameLabel.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.songNameLabel];
//    [self.songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.logoImgView.mas_right).mas_offset(10);
//        make.top.mas_equalTo(7);
//        make.size.mas_equalTo(CGSizeMake(screen_width-55-32, 15));
//    }];
    
    self.singerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.logoImgView.y+10, self.songNameLabel.y+15, 200, 15)];
    self.singerLabel.textAlignment = NSTextAlignmentLeft;
    self.singerLabel.font = [UIFont systemFontOfSize:font_15_size];
    self.singerLabel.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.singerLabel];
//    [self.songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.logoImgView.mas_right).mas_offset(10);
//        make.top.mas_equalTo(self.songNameLabel.mas_bottom).mas_offset(0);
//        make.size.mas_equalTo(CGSizeMake(screen_width-55-32, 15));
//    }];
}

- (void)renderMusicListCell:(QQMusicModel *)qqMusicModel{
    NSLog(@"------------%@---%@----%@",qqMusicModel.icon,qqMusicModel.name,qqMusicModel.singer);
    self.logoImgView.image = [UIImage imageNamed:qqMusicModel.icon];
    self.songNameLabel.text = qqMusicModel.name;
    self.singerLabel.text = qqMusicModel.singer;
}


//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
