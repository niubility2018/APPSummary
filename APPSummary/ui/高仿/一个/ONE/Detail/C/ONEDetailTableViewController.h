//
//  ONEDetailTableViewController.h
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEHomeItem.h"

@class ONEDetailTableViewController;
@class ONEEssayItem;

@protocol ONEDetailTableViewControllerDelegate <NSObject>

- (void)detailTableVC:(ONEDetailTableViewController *)detailTableVC updateToolViewPraiseAndCommentCountWithEssayItem:(ONEEssayItem *)essayItem;
- (void)detailTableVC:(ONEDetailTableViewController *)detailTableVC updateToolViewBackgroundColor:(UIColor *)backgroundColor fontColor:(UIColor *)fontColor;

- (void)detailTableVCDidFinishLoadData:(ONEDetailTableViewController *)detailTableVC;

- (void)detailTableVC:(ONEDetailTableViewController *)detailTableVC UpdateTitle:(NSString *)titleString;

@end

@interface ONEDetailTableViewController : UITableViewController

@property (weak, nonatomic) id<ONEDetailTableViewControllerDelegate> delegate;

@property (strong, nonatomic) NSString *itemId;

@property (assign, nonatomic) ONEHomeItemType type;

@end
