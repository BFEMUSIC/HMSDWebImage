//
//  DownLoadOperation.m
//  仿SDWebImage操作
//
//  Created by 代辉 on 2017/5/6.
//  Copyright © 2017年 代辉. All rights reserved.
//

#import "DownLoadOperation.h"

typedef void(^TempBlock)(UIImage *);

@interface DownLoadOperation ()

@property (nonatomic,copy) NSString *urlStr;

@property (nonatomic,copy) TempBlock block;

@end


@implementation DownLoadOperation

+ (instancetype)downLoadOperationWithURLStr:(NSString *)urlStr andFinishedBlock:(void (^)(UIImage *))finishedBlock
{
    DownLoadOperation *op = [DownLoadOperation new];
    
    op.urlStr = urlStr;
    
    op.block = finishedBlock;
    
    return op;
}

- (void)main
{
    
    NSLog(@"传入");
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (self.cancelled == YES) {
    NSLog(@"取消");
        return;
    }
    
    if (_block) {
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"完成");
            _block(image);
        }];
    }
}

@end
