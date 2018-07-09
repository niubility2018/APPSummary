//
//  ONECatalogueItem.m
//  CWOne
//
//  Created by Coulson_Wang on 2017/8/3.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "ONECatalogueItem.h"
#import "NSString+CWTranslate.h"

@implementation ONECatalogueItem

+ (instancetype)catalogueItemWithDict:(NSDictionary *)dict {
    ONECatalogueItem *item = [[ONECatalogueItem alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    
    if(item.tag) {
        item.categoryString = item.tag[@"title"];
    } else {
        item.categoryString = [NSString getCategoryStringWithCategoryInteger:item.content_type.integerValue];
    }
    
    
    return item;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // do nothing
}

@end
