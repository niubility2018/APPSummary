//
//  NNDeviceInformation.m
//  NNDeviceInformation
//
//  Created by 刘朋坤 on 17/4/7.
//  Copyright © 2017年 刘朋坤. All rights reserved.
//

#import "NNDeviceInformation.h"
#import "sys/utsname.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <mach/mach.h>
#include <objc/runtime.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CoreTelephonyDefines.h>

//获取idfa
#import <AdSupport/ASIdentifierManager.h>
//获取mac
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"





#ifdef DEBUG
#define DYLog(...) NSLog(@"%s\n %@\n\n", __func__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DYLog(...)
#endif

struct CTResult
{
    int flag;
    int a;
};

//#if SUPPORTS_IOKIT_EXTENSIONS
#define kIODeviceTreePlane        "IODeviceTree"
enum {
    
    kIORegistryIterateRecursively    = 0x00000001,
    
    kIORegistryIterateParents        = 0x00000002
    
};



typedef mach_port_t    io_object_t;

typedef io_object_t    io_registry_entry_t;

typedef char        io_name_t[128];

typedef UInt32        IOOptionBits;



CFTypeRef

IORegistryEntrySearchCFProperty(
                                
                                io_registry_entry_t    entry,
                                
                                const io_name_t        plane,
                                
                                CFStringRef        key,
                                
                                CFAllocatorRef        allocator,
                                
                                IOOptionBits        options );



kern_return_t

IOMasterPort( mach_port_t    bootstrapPort,
             
             mach_port_t *    masterPort );



io_registry_entry_t

IORegistryGetRootEntry(
                       
                       mach_port_t    masterPort );



CFTypeRef

IORegistryEntrySearchCFProperty(
                                
                                io_registry_entry_t    entry,
                                
                                const io_name_t        plane,
                                
                                CFStringRef        key,
                                
                                CFAllocatorRef        allocator,
                                
                                IOOptionBits        options );



kern_return_t   mach_port_deallocate

(ipc_space_t                               task,
 
 mach_port_name_t                          name);

@implementation NNDeviceInformation

/// 屏幕宽度
+ (CGFloat)getDeviceScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

/// 屏幕高度
+ (CGFloat)getDeviceScreenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}
//分辨率
+ (NSString *)getDevice_Resolution{
    
    return [NSString stringWithFormat:@"%.0fx%.0f",([NNDeviceInformation getDeviceScreenWidth]*[UIScreen mainScreen].scale),([NNDeviceInformation getDeviceScreenHeight]*[UIScreen mainScreen].scale)];
}


/// 获取设备版本号
+ (NSString *)getDeviceName {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

/// 获取iPhone名称
+ (NSString *)getiPhoneName {
    return [UIDevice currentDevice].name;
}

/// 获取app版本号
+ (NSString *)getAPPVerion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/// 获取电池电量
+ (CGFloat)getBatteryLevel {
    return [UIDevice currentDevice].batteryLevel;
}
//+ (CGFloat)getBatteryLevel
//{
//
//    UIApplication *app = [UIApplication sharedApplication];
//    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
//        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
//        id status  = object_getIvar(app, ivar);
//        for (id aview in [status subviews]) {
//            int batteryLevel = 0;
//            for (id bview in [aview subviews]) {
//                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0)
//                {
//
//                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
//                    if(ivar)
//                    {
//                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
//                        //这种方式也可以
//                        /*ptrdiff_t offset = ivar_getOffset(ivar);
//                         unsigned char *stuffBytes = (unsigned char *)(__bridge void *)bview;
//                         batteryLevel = * ((int *)(stuffBytes + offset));*/
//                        NSLog(@"电池电量:%d",batteryLevel);
//                        if (batteryLevel > 0 && batteryLevel <= 100) {
//                            return batteryLevel;
//
//                        } else {
//                            return 0;
//                        }
//                    }
//
//                }
//
//            }
//        }
//    }
//
//    return 0;
//}

/// 当前系统名称
+ (NSString *)getSystemName {
    return [UIDevice currentDevice].systemName;
}

/// 当前系统版本号
+ (NSString *)getSystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

/// 通用唯一识别码UUID
//+ (NSString *)getUUID {
//    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
//}

//+ (NSString*)getDeviceUUID
//{
//    CFUUIDRef puuid = CFUUIDCreate( nil );
//    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
//    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
//    CFRelease(puuid);
//    CFRelease(uuidString);
//    //将字符串中"-" 全部替换成 ""
//    NSString *str = [result stringByReplacingOccurrencesOfString :@"-" withString:@""];
//    return str;
//}

// 获取当前设备IP
+ (NSString *)getDeviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}


+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        address = addresses[obj];
        //筛选出IP地址格式
        if([self isValidatIP:address]) *stop = YES;
    }];
    
    return address ? address : @"0.0.0.0";
}
+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}
+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}





/// 获取总内存大小
+ (long long)getTotalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory;
}

/// 获取当前可用内存
+ (long long)getAvailableMemorySize {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

/// 获取精准电池电量
+ (CGFloat)getCurrentBatteryLevel {
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        id status  = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
                    
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    if(ivar) {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                            
                        } else {
                            return 0;
                        }
                    }
                }
            }
        }
    }
    
    return 0;
}

/// 获取电池当前的状态，共有4种状态
+ (NSString *) getBatteryState {
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"UnKnow";
    } else if (device.batteryState == UIDeviceBatteryStateUnplugged){
        return @"Unplugged";
    } else if (device.batteryState == UIDeviceBatteryStateCharging){
        return @"Charging";
    } else if (device.batteryState == UIDeviceBatteryStateFull){
        return @"Full";
    }
    return nil;
}

/// 获取当前语言
+ (NSString *)getDeviceLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}

+(NSString *)dy_getDeviceIDFA{
    ASIdentifierManager *asIM = [[ASIdentifierManager alloc] init];
    NSString *idfaStr = [asIM.advertisingIdentifier UUIDString];
    
    DYLog(@"idfaStr------》%@",idfaStr);
    return idfaStr;
}

+(NSString *)dy_getDeviceIDFV{
    NSString* idfvStr      = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
    DYLog(@"idfvStr------》%@",idfvStr);
    return idfvStr;
}

+(NSString *)dy_getDeviceIMEI{
////    NSString* imeiStr = @"回头吧，翻遍国内外了，failed，快看代码注释";
    return @"iOS5以后不能获取手机IMEI";
//    extern CFStringRef kCTMobileEquipmentInfoIMEI;
////    void *connection = CTServerConnectionCreate(kCFAllocatorDefault, NULL, NULL);
//    void *connection = _CTServerConnectionCreate(0);
//    NSDictionary *info = nil;
//
//    struct CTResult result;
//
//    CTServerConnectionCopyMobileEquipmentInfo(&result, connection, &info);
//
////    [info autorelease];
//
//    CFRelease(connection);
//    NSString* IMEI = (NSString*)info[(__bridge NSString*)kCTMobileEquipmentInfoIMEI];
}


//NSArray *getValue(NSString *iosearch)
//
//{
//
//    mach_port_t          masterPort;
//
//    CFTypeID             propID = (CFTypeID) NULL;
//
//    unsigned int         bufSize;
//    kern_return_t kr = IOMasterPort(MACH_PORT_NULL, &masterPort);
//
//    if (kr != noErr) return nil;
//
//
//
//    io_registry_entry_t entry = IORegistryGetRootEntry(masterPort);
//
//    if (entry == MACH_PORT_NULL) return nil;
//
//
//
//    CFTypeRef prop = IORegistryEntrySearchCFProperty(entry, kIODeviceTreePlane, (__bridge CFStringRef) iosearch, nil, kIORegistryIterateRecursively);
//
//    if (!prop) return nil;
//
//
//
//    propID = CFGetTypeID(prop);
//
//    if (!(propID == CFDataGetTypeID()))
//
//    {
//
//        mach_port_deallocate(mach_task_self(), masterPort);
//
//        return nil;
//
//    }
//
//    CFDataRef propData = (CFDataRef) prop;
//    if (!propData) return nil;
//    bufSize = CFDataGetLength(propData);
//    if (!bufSize) return nil;
//    NSString *p1 = [[NSString alloc] initWithBytes:CFDataGetBytePtr(propData) length:bufSize encoding:1];
//
//    mach_port_deallocate(mach_task_self(), masterPort);
//
//    return [p1 componentsSeparatedByString:@"/0"];
//
//}

////imei
- (NSString *) imei

{
//    NSArray *results = getValue(@"device-imei");
//
//    if (results)
//
//    {
//        //return [results objectAtIndex:0];
//        NSString *string_content = [results objectAtIndex:0];
//
//        const char *char_content = [string_content UTF8String];
//
//        return  [[NSString alloc] initWithCString:(const char *)char_content  encoding:NSUTF8StringEncoding];
//    }
    return nil;
}

/**
 获得手机的mac地址，但是有个限制，是在iOS7以下才可以获得。iOS7以后苹果对于sysctl和ioctl进行了技术处理，MAC地址返回的都是02:00:00:00:00:00。官方文档上这样写的“Twolow-level networking APIs that used to return a MAC address now return thefixed value 02:00:00:00:00:00. The APIs in question are sysctl(NET_RT_IFLIST) and ioctl(SIOCGIFCONF). Developers using the value of the MAC address should migrate toidentifiers such as -[UIDevice identifierForVendor].This change affects all apps running on iOS 7”。
 所以在iOS7以后想要获取设备的唯一标示Mac地址已经不行了，只能用其他的代替。
 */

+(NSString*)dy_getDeviceMAC{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macStr = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",*ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    DYLog(@"macStr------》%@",macStr);
    return macStr;
}


+(NSString*)dy_getDeviceUUID{
    
//    CFUUIDRef uuid = CFUUIDCreate(NULL);
//    assert(uuid != NULL);
//    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
//
//    DYLog(@"uuidStr------》%@",uuidStr);
//    return (__bridge NSString *)(uuidStr);
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    //将字符串中"-" 全部替换成 ""
    NSString *str = [result stringByReplacingOccurrencesOfString :@"-" withString:@""];
    NSLog(@"-UUID----------%@",str);
    return str;
}
//no way，UDID是肯定要被苹果拒绝的，炸了！Stack Overflow提供了另外一种方法，越狱可尝试：http://stackoverflow.com/questions/27602368/how-to-get-serial-number-of-a-device-using-iokit-in-ios8-as-ioplatformserialnumb/27686125#27686125
+(NSString*)dy_getDeviceUDID{
//    NSString* udidStr = @"回头吧，翻遍国内外了，failed，快来看注释";
    
    return @"审核会被拒！！！！";
}


@end

