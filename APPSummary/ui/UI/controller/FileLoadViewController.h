//
//  FileLoadViewController.h
//  APPSummary
//
//  Created by xubojoy on 2018/3/1.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileLoadViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end
