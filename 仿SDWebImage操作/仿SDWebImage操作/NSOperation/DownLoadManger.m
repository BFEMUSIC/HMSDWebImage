//
//  DownLoadManger.m
//  仿SDWebImage操作
//
//  Created by 代辉 on 2017/5/6.
//  Copyright © 2017年 代辉. All rights reserved.
//

#import "DownLoadManger.h"

@interface DownLoadManger ()

@property (nonatomic,strong) NSOperationQueue *queue;

@property (nonatomic,strong) NSMutableDictionary *opCache;

@property (nonatomic,strong) NSMutableDictionary *imageCache;

@end

@implementation DownLoadManger

+ (instancetype)shardManger
{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        instance = [self new];
        
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.queue = [NSOperationQueue new];
        
        self.opCache = [NSMutableDictionary new];
        
        self.imageCache = [NSMutableDictionary new];
    }
    return self;
}

- (void)downLoadWithURLStr:(NSString *)urlStr andFinished:(void (^)(UIImage *))block
{
    
    if ([self isCacheWithURLStr:urlStr]) {
        
        if (block) {
            
            block([self.imageCache objectForKey:urlStr]);
        }
        
        return;
    }
    
    if ([self.opCache objectForKey:urlStr]) {
        
        return;
    }
    
    DownLoadOperation *op = [DownLoadOperation downLoadOperationWithURLStr:urlStr andFinishedBlock:^(UIImage *image) {
        
        if (block) {
            block(image);
        }
        if (image) {
            
            [self.imageCache setObject:image forKey:urlStr];
        }
        [self.opCache removeObjectForKey:urlStr];
    }];
    
    [self.opCache setObject:op forKey:urlStr];
    
    [self.queue addOperation:op];
}

- (void)canchWithLastURL:(NSString *)lastURL
{
    DownLoadOperation *op = [self.opCache valueForKey:lastURL];
    
    [op cancel];
    
    [self.opCache removeObjectForKey:lastURL];
}

- (BOOL)isCacheWithURLStr:(NSString *)urlStr
{
    if ([self.imageCache objectForKey:urlStr]) {
        
        NSLog(@"从内存中取出");
        return YES;
    }
    
    UIImage *cacheImage = [UIImage imageWithContentsOfFile:[urlStr appendPath]];
    
    if (cacheImage) {
        
        NSLog(@"从沙盒中取出");
        
        [self.imageCache setObject:cacheImage forKey:urlStr];
        
        return YES;
    }
    
    return NO;
}
@end
