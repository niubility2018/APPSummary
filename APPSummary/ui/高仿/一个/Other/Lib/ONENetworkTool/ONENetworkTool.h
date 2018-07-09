//
//  ONENetworkTool.h
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/1.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONENetworkTool : NSObject

+ (instancetype)sharedInstance;

/* ********************************************* 主页请求 ********************************************* */
/// 请求主页数据
- (void)requestHomeDataWithDate:(NSString *)date cityName:(NSString *)cityName success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 获取当前电台状态数据
- (void)requestRadioStatusDataSuccess:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求标题点击后展开的feeds列表数据
- (void)requestFeedsDataWithDateString:(NSString *)dateString success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求日记页的天气信息
- (void)requestDiaryWeatherDataSuccess:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/* ********************************************* 详情页请求 ********************************************* */
/// 请求详情页数据
- (void)requestDetailDataOfType:(NSString *)typeName withItemId:(NSString *)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求某篇文章的关联列表
- (void)requestRelatedListDataOfType:(NSString *)typeName withItemId:(NSString *)item_id success:(void (^)(NSArray<NSDictionary *> *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求某篇文章的评论列表
- (void)requestCommentListOfType:(NSString *)typeName WithItemID:(NSString *)item_id lastID:(NSString *)lastID success:(void (^)(NSArray<NSDictionary *> *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求音乐的详情页数据
- (void)requestMusicDetailDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求电影的详细信息
- (void)requestMovieDetailDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求电影的故事数据
- (void)requestMovieStoryDataWithItemId:(NSString *)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;
/* ********************************************* 作者页和用户页请求 ********************************************* */
/// 请求作者信息数据
- (void)requestAuthorInfoDataWithAuthorId:(NSString *)authorId success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求作者作品列表数据
- (void)requestAuthorWorksListDataWithAuthorId:(NSString *)authorId pageNumber:(NSString *)pageNumber success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求用户信息数据
- (void)requestUserInfoDataWithUserId:(NSString *)userId success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/// 请求用户关注列表数据
- (void)requestUserFollowListCountWithUserId:(NSString *)userId success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;

/* ********************************************* 搜索界面请求 ********************************************* */
/// 请求搜索结果页数据
- (NSURLSessionDataTask *)requestSearchResultDataWithTypeName:(NSString *)typeName searchText:(NSString *)searchText page:(NSInteger)pageNum success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求快捷搜索页列表
- (void)requestSearchListDataWithCategoryIndex:(NSInteger)categoryIndex success:(void (^)(NSString *html_content))success failure:(void (^)(NSError *error))failure;

/// 请求图文详情页数据
- (void)requestFeedsDetailDataWithItemId:(NSInteger)item_id success:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;
/* ********************************************* 设置界面请求 ********************************************* */

/// 请求推荐应用
- (void)requestRecAppListSuccess:(void (^)(NSDictionary *dataDict))success failure:(void (^)(NSError *error))failure;

/* ********************************************* All专题界面请求 ********************************************* */

/// 请求轮播器数据
- (void)requestAllHeaderBannerDataWithLastId:(NSString *)last_id success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求所有人问所有人模块数据
- (void)requestAllEveryOneAskEveryOneDataWithLastId:(NSString *)last_id success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求近期热门作者列表数据
- (void)requestAllHotAuthorListDataSuccess:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;

/// 请求专题列表数据
- (void)requestAllSpecilaListDataWithLastId:(NSString *)last_id success:(void (^)(NSArray *dataArray))success failure:(void (^)(NSError *error))failure;
/* ********************************************* post请求 ********************************************* */
/// 发送POST请求通知服务器某一条已点赞
- (void)postPraisedWithItemId:(NSString *)item_id typeName:(NSString *)typeName success:(void (^)())success failure:(void (^)(NSError *error))failure;

/// 发送POST请求通知服务器已给某一条评论点赞
- (void)postPraisedCommentWithType:(NSString *)typeName itemId:(NSString *)item_id commentId:(NSString *)commentId success:(void (^)())success failure:(void (^)(NSError *error))failure;

/// 发送POST请求通知服务器已取消某一条评论的赞
- (void)postUnpraisedCommentWithType:(NSString *)typeName item_id:(NSString *)item_id commentId:(NSString *)commentId success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
