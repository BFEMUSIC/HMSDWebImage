//
//  UIImageView+loadImage.h
//  仿SDWebImage操作
//
//  Created by 代辉 on 2017/5/6.
//  Copyright © 2017年 代辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadManger.h"

@interface UIImageView (loadImage)


@property (nonatomic,copy) NSString *lastURLStr;

- (void)loadImageWithURLStr:(NSString *)URLStr;

@end
