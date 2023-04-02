//
//  SPDeviceInfo.m
//  StatisticSdk
//
//  Created by 郭鹏 on 2019/4/15.
//  Copyright © 2019 郭鹏. All rights reserved.
//

#import "GADeviceInfoTool.h"
#import <AdSupport/AdSupport.h>
#import "SAMKeychain.h"
#import <UIKit/UIKit.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

static NSString * const uuidKey = @"uuidKey";

static NSString * const kUniqueIdentifier = @"kUniqueIdentifier";
static NSString * const kUniqueIdentifierValue = @"kUniqueIdentifierValue";

@implementation GADeviceInfoTool

+ (NSString *)ga_UUIDStr {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:uuidKey]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:uuidKey];
    }
    
    NSString *uKeyItem = [SAMKeychain passwordForService:kUniqueIdentifier account:kUniqueIdentifierValue];
    if (uKeyItem == nil || uKeyItem.length == 0) {
        CFUUIDRef puuid = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, puuid);
        NSString *uuidStr = CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        uKeyItem = uuidStr;
        
        [SAMKeychain setPassword:uuidStr forService:kUniqueIdentifier account:kUniqueIdentifierValue];
        [[NSUserDefaults standardUserDefaults] setObject:uuidStr forKey:uuidKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return uKeyItem;
}

+ (NSString *)ga_IDFAStr {
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return nil;
}

+ (NSString *)ga_systemVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] localizedInfoDictionary];
    if (infoDict == nil) {
        infoDict = [[NSBundle mainBundle] infoDictionary];
    }
    
    return [infoDict objectForKey:@"DTSDKName"];
}

+ (NSString *)ga_romInfo {
    return @"1";
}

+ (NSString *)ga_countryCode {
    //优先取sim卡里的国家代码
    CTTelephonyNetworkInfo *phoneInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [phoneInfo subscriberCellularProvider];
    NSString *countryCode = carrier.isoCountryCode;
    if (countryCode) {
        return countryCode;
    }
    //如果没有，则取语言里的代码
    NSString *language = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];
    return [[language componentsSeparatedByString:@"-"] lastObject];
}

+ (NSString *)ga_language {
    NSString *language = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];
    return [[language componentsSeparatedByString:@"-"] firstObject];
}

+ (NSString *)ga_versionCode {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleVersion"];
}

+ (NSString *)ga_versionName {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}

+ (int)ga_phoneType {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 1;
    } else {
        return 2;
    }
}

+ (NSString *)ga_deviceTypeStr {
    int mib[2];
    size_t len;
    char *machine;

    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);

    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"] ||
        [platform isEqualToString:@"iPhone9,4"]) return @"iPhone7Plus";
    if ([platform isEqualToString:@"iPhone10,1"] ||
        [platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"] ||
        [platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"] ||
        [platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"] ||
        [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad pro
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPadPro";
    if ([platform isEqualToString:@"iPad6,4"])   return @"iPadPro";
    if ([platform isEqualToString:@"iPad6,7"])   return @"iPadPro";
    if ([platform isEqualToString:@"iPad6,8"])   return @"iPadPro";
    if ([platform isEqualToString:@"iPad6,11"] ||
        [platform isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([platform isEqualToString:@"iPad7,1"] ||
        [platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if ([platform isEqualToString:@"iPad7,3"] ||
        [platform isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}

@end
