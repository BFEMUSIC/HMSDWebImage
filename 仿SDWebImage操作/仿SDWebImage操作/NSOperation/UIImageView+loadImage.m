//
//  UIImageView+loadImage.m
//  仿SDWebImage操作
//
//  Created by 代辉 on 2017/5/6.
//  Copyright © 2017年 代辉. All rights reserved.
//

#import "UIImageView+loadImage.h"
#import <objc/runtime.h>

@implementation UIImageView (loadImage)

- (void)setLastURLStr:(NSString *)lastURLStr
{
    objc_setAssociatedObject(self, "key", lastURLStr, 3);
}

- (NSString *)lastURLStr
{
    return objc_getAssociatedObject(self, "key");
}
- (void)loadImageWithURLStr:(NSString *)URLStr
{
    if (![URLStr isEqualToString:self.lastURLStr] && self.lastURLStr != nil) {
        
        [[DownLoadManger shardManger] canchWithLastURL:self.lastURLStr];
    }
    
    self.lastURLStr = URLStr;
    
    [[DownLoadManger shardManger] downLoadWithURLStr:URLStr andFinished:^(UIImage *image) {
        
        self.image = image;
    }];
}

@end
