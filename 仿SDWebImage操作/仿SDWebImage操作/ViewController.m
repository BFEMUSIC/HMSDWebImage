//
//  ViewController.m
//  仿SDWebImage操作
//
//  Created by 代辉 on 2017/5/6.
//  Copyright © 2017年 代辉. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadOperation.h"
#import "AFNetworking.h"
#import "APPModel.h"
#import "YYModel.h"
#import "DownLoadManger.h"
#import "UIImageView+loadImage.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray *appList;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic,copy) NSString *lastURL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if(!self.appList)return;
    
    int random = arc4random_uniform((uint32_t)self.appList.count);
    
    APPModel *model = self.appList[random];
    
    [self.imageView loadImageWithURLStr:model.icon];
    
   
}

/// 获取数据的主方法 : 用于测试的数据,需要提前获取到
- (void)loadData {
    
    NSString *urlStr = @"https://raw.githubusercontent.com/zhangxiaochuZXC/SHHM05/master/apps.json";
    
    // AFN默认在子线程发送网络请求,默认在主线程回调代码块
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 把字典数组转模型数组
        self.appList =  [NSArray yy_modelArrayWithClass:[APPModel class] json:responseObject];
        NSLog(@"appList %@",self.appList);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误信息 = %@",error);
    }];
}

@end
