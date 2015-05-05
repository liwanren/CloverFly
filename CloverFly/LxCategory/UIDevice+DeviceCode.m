//
//  DeviceCode.m
/*
 //     ___ __   ____  _   _________
 //   / __// /  / __ \| | / / __/ _ \
 //  / /  / /_ / /_/ /| |/ / _// , _/
 // /___//____/\____/_\___/___/_/|_|
 // --------Created by clover--------
 */



#import "UIDevice+DeviceCode.h"

#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
//是否是ios7系统
#define ISIOS7              ([[[UIDevice currentDevice]systemVersion]floatValue] >=7.0)
@implementation UIDevice(DeviceCode)

- (NSString *)getDeviceCode
{
    NSString *code;
    if(ISIOS7)
    {
        NSUUID *uuid = [[UIDevice currentDevice] identifierForVendor];
        NSString *uuidStr = [uuid UUIDString];
        code = uuidStr;
    }
    else
    {
        code = [self getMacAddress];
    }
    
    if(!code)
    {
        code = @"UUID_ERROR";
    }
    return code;
}

- (NSString *) getMacAddress
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];

    
    free(buf);
    
    return [outstring uppercaseString];
}

@end
