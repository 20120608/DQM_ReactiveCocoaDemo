//
//  ReactiveCocoaListViewController.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2018/12/28.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "ReactiveCocoaListViewController.h"
#import "RACTextFieldTextViewController.h"
#import "RACColorChangeViewController.h"
#import "RACNetWorkViewController.h"
#import "CaculatorUseReacticeViewController.h"
#import "RACGetUserLocationViewController.h"
#import "ReactiveFoldInstructionsViewController.h"

@interface ReactiveCocoaListViewController ()

@end

@implementation ReactiveCocoaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  
  QMWeak(self);
  self.addItem([StaticListItem itemWithTitle:@"监听键盘输入" subTitle:@"简单" itemOperation:^(NSIndexPath *indexPath) {
    
    RACTextFieldTextViewController *vc = [[RACTextFieldTextViewController alloc] initWithTitle:@"键盘输入判断"];
    [weakself.navigationController pushViewController:vc animated:true];
    
  }]).addItem([StaticListItem itemWithTitle:@"监控输入框和滚动条的色值" subTitle:@"中等" itemOperation:^(NSIndexPath *indexPath) {
    
    RACColorChangeViewController *vc = [[RACColorChangeViewController alloc] initWithTitle:@"颜色变化实时变化"];
    [weakself.navigationController pushViewController:vc animated:true];
    
  }]).addItem([StaticListItem itemWithTitle:@"构造一个网络请求信号量" subTitle:@"中等" itemOperation:^(NSIndexPath *indexPath) {
    
    RACNetWorkViewController *vc = [[RACNetWorkViewController alloc] initWithTitle:@"网络请求后触发返回"];
    [weakself.navigationController pushViewController:vc animated:true];
    
  }]).addItem([StaticListItem itemWithTitle:@"仿照reactiveCocoa的写法解释它" subTitle:@"中等" itemOperation:^(NSIndexPath *indexPath) {
    
    CaculatorUseReacticeViewController *vc = [[CaculatorUseReacticeViewController alloc] initWithTitle:@"仿rac写法"];
    [weakself.navigationController pushViewController:vc animated:true];
    
  }]).addItem([StaticListItem itemWithTitle:@"逆地理定位" subTitle:@"难" itemOperation:^(NSIndexPath *indexPath) {
    
    RACGetUserLocationViewController *vc = [[RACGetUserLocationViewController alloc] initWithTitle:@"获取定位信息"];
    [weakself.navigationController pushViewController:vc animated:true];
    
  }]).addItem([StaticListItem itemWithTitle:@"reactiveCocoa的字段说明" subTitle:@"基础" itemOperation:^(NSIndexPath *indexPath) {
    
    ReactiveFoldInstructionsViewController *vc = [[ReactiveFoldInstructionsViewController alloc] initWithTitle:@"字段说明"];
    [weakself.navigationController pushViewController:vc animated:true];
    
  }]);
  
  
}





@end
