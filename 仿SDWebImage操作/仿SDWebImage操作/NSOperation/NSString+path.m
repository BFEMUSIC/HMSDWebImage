//
//  NSString+path.m
//  仿SDWebImage操作
//
//  Created by 代辉 on 2017/5/6.
//  Copyright © 2017年 代辉. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

- (NSString *)appendPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *name = [self lastPathComponent];
    
    NSString *filePath = [path stringByAppendingPathComponent:name];
    
    return filePath;
}

@end
