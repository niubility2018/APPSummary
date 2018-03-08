//
//  GSKeyChainDataManager.m
//  keychaintest
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 张国森. All rights reserved.
//

#import "GSKeyChainDataManager.h"
#import "GSKeyChain.h"
@implementation GSKeyChainDataManager
//一般可设置为bundleID之类的
static NSString * const KEY_IN_KEYCHAIN_UUID = @"标识设备的udid";
static NSString * const KEY_UUID = @"标识设备的udid";

+(void)saveUUID:(NSString *)UUID{
    
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:UUID forKey:KEY_UUID];
    
    [GSKeyChain save:KEY_UUID data:usernamepasswordKVPairs];
}

+(NSString *)readUUID{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[GSKeyChain load:KEY_UUID];
    
    return [usernamepasswordKVPair objectForKey:KEY_UUID];
    
}

+(void)deleteUUID{
    
    [GSKeyChain delete:KEY_UUID];
    
}

@end
