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

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//
//    [self setUp];
//}

static NSString *musicListCellIndetifier = @"MusicListCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style
{
    MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:musicListCellIndetifier];
    if(cell == nil)
    {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:musicListCellIndetifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.logoImgView = [[UIImageView alloc] init];
//    self.logoImgView.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.logoImgView];
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    self.songNameLabel = [[UILabel alloc] init];
    self.songNameLabel.textAlignment = NSTextAlignmentLeft;
    self.songNameLabel.font = [UIFont systemFontOfSize:font_15_size];
//    self.songNameLabel.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.songNameLabel];
    [self.songNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImgView.mas_right).mas_offset(10);
        make.top.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(screen_width-65-32, 20));
    }];
    
    self.singerLabel = [[UILabel alloc] init];
    self.singerLabel.textAlignment = NSTextAlignmentLeft;
    self.singerLabel.font = [UIFont systemFontOfSize:font_15_size];
//    self.singerLabel.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.singerLabel];
    [self.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImgView.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.songNameLabel.mas_bottom).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(screen_width-65-32, 20));
    }];
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
