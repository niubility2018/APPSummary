//
//  APPUISummaryController.h
//  APPSummary
//
//  Created by xubojoy on 2018/2/24.
//  Copyright © 2018年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPUISummaryController : UIViewController<UITableViewDelegate, UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;

@end
