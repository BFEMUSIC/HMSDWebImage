//
//  DownLoadManger.h
//  仿SDWebImage操作
//
//  Created by 代辉 on 2017/5/6.
//  Copyright © 2017年 代辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownLoadOperation.h"

@interface DownLoadManger : NSObject

+ (instancetype)shardManger;

- (void)downLoadWithURLStr:(NSString *)urlStr andFinished:(void(^)(UIImage *))block;

- (void)canchWithLastURL:(NSString *)lastURL;

@end
