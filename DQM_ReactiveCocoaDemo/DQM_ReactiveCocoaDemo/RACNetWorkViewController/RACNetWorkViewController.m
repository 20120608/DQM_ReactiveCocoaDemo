//
//  RACNetWorkViewController.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2018/12/29.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "RACNetWorkViewController.h"
#import "AFNetworking.h"

@interface RACNetWorkViewController ()

/** 数据 */
@property(nonatomic,strong) NSDictionary          *dataDictionary;

@end

@implementation RACNetWorkViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
  UIImageView *imageView = ({
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview: imageView];
    imageView;
  });
  
  //方式1:   只要改变self.dictionary就会改变图片
  RACSignal *taobaoSignal = [self signalFromJson:@"https://mobile.piaoduwang.cn/book/info/search?name=1234567"];
  RAC(self,dataDictionary) = taobaoSignal;

  [RACObserve(self, self.dataDictionary) subscribeNext:^(NSDictionary *x) {
    NSArray *BookArray = x[@"list"];
    NSString *detailImgUrl = nil;
    if (BookArray.count > 0) {
      detailImgUrl = BookArray[0][@"taobaoImgUrl"];
      [imageView qm_setWithImageURL:[NSURL URLWithString:detailImgUrl] placeholderImage:[UIImage imageNamed:@"EmptyTableView_default"]];
    }
  }];
  
  
  //方式2:  不需要判空 代码预留的多
//  [[[self signalFromJson:@"https://mobile.piaoduwang.cn/book/info/search?name=1234567"] map:^id _Nullable(NSDictionary *value) {
//    self.dataDictionary = value;
//    //映射不处理直接返回
//    return value;
//  }] subscribeNext:^(NSDictionary *x) {
//    NSArray *BookArray = x[@"list"];
//    NSString *detailImgUrl = nil;
//    if (BookArray.count > 0) {
//      detailImgUrl = BookArray[0][@"taobaoImgUrl"];
//      [imageView qm_setWithImageURL:[NSURL URLWithString:detailImgUrl] placeholderImage:[UIImage imageNamed:@"EmptyTableView_default"]];
//    }
//  }];
  
  
  //方式3:  需要判空 利于封装出去
//  [[[self signalFromJson:@"https://mobile.piaoduwang.cn/book/info/search?name=1234567"] map:^id _Nullable(NSDictionary *value) {
//    self.dataDictionary = value;
//    //映射不处理直接返回
//    NSArray *BookArray = value[@"list"];
//    NSString *detailImgUrl = nil;
//    if (BookArray.count > 0) {
//      detailImgUrl = BookArray[0][@"taobaoImgUrl"];
//      return detailImgUrl;
//    }
//    return nil;
//  }] subscribeNext:^(NSString *x) {
//    if (x != nil) {
//       [imageView qm_setWithImageURL:[NSURL URLWithString:x] placeholderImage:[UIImage imageNamed:@"EmptyTableView_default"]];
//    }
//  }];
  
  
  
}

- (RACSignal *)signalFromJson:(NSString *)url {
  
  return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dict = @{};
    [manager GET:url parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//      NSLog(@"success--%@--%@",[responseObject class],responseObject);
      [subscriber sendNext:responseObject];
      [subscriber sendCompleted];
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      [subscriber sendError:error];
      NSLog(@"failure--%@",error);
    }];
    
    return [RACDisposable disposableWithBlock:^{
      
    }];
  }];
}


#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar {
  return true;
}

/** 导航条左边的按钮 */
- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar {
  [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
  return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
  [self.navigationController popViewControllerAnimated:true];
}
@end
