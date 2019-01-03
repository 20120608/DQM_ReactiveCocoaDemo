//
//  RACGetUserLocationViewController.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2018/12/29.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "RACGetUserLocationViewController.h"

@interface RACGetUserLocationViewController () <CLLocationManagerDelegate>

/** 地址 */
@property(nonatomic,strong) UILabel          *addressLabel;

/** 定位管理类 */
@property(nonatomic,strong) CLLocationManager          *manager;

/** 逆地理 */
@property(nonatomic,strong) CLGeocoder          *geocoder;

@end

@implementation RACGetUserLocationViewController

#pragma mark - lazy load

- (CLLocationManager *)manager {
  if (!_manager) {
    _manager = [[CLLocationManager alloc] init];
    _manager.delegate = self;
  }
  return _manager;
}

- (CLGeocoder *)geocoder {
  if (!_geocoder) {
    _geocoder = [[CLGeocoder alloc] init];
  }
  return _geocoder;
}

#pragma mark - getLocationAuthorize
/** 权限信号量 */
-(RACSignal *)authorizedSignal {
  if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
    [self.manager requestAlwaysAuthorization];//需要提前配置plist定位信息
    
    //监视定位的代理会掉
    return [[self rac_signalForSelector:@selector(locationManager:didChangeAuthorizationStatus:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(id  _Nullable value) {
      return @([value[1] integerValue] == kCLAuthorizationStatusAuthorizedAlways);
    }];
  }
  return [RACSignal return:@([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)];
}


- (void)viewDidLoad {
  [super viewDidLoad];
 
  self.addressLabel = ({
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    QMLabelFontColorText(label, @"定位中", QMTextColor, 16);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.view.mas_left).offset(10);
      make.top.mas_equalTo(self.view.mas_top).offset(100);
      make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    label;
  });
  
  

  
  
  [[[[[self authorizedSignal] filter:^BOOL(id  _Nullable value) {
    NSLog(@"开始授权判断");
    return [value boolValue];  //YES有授权     NO没有授权
  }] then:^RACSignal * _Nonnull{
    NSLog(@"11111");
    //当上面的filter执行并返回YES才会继续执行then里面的
    return [[[[[[self rac_signalForSelector:@selector(locationManager:didUpdateLocations:)  fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(id  _Nullable value) {
      return value[1];
    }]//返回更新了数据的代理//并上了一个错误的返回  2者可以单独返回
     merge:[[self rac_signalForSelector:@selector(locationManager:didFailWithError:) fromProtocol:@protocol(CLLocationManagerDelegate)] map:^id _Nullable(id  _Nullable value) {
      //映射处理一下错误的信息;
      return [RACSignal error:value[1]];
    }]] take:1] //take只会返回一次定位或者报错
             initially:^{
               //初始化的时候开始地理位置更新
               NSLog(@"开始获取定位");
               [self.manager startUpdatingLocation];
             }] finally:^{
               //结束的时候暂停更新
               NSLog(@"结束地理定位");
               [self.manager stopUpdatingLocation];
             }];
    
  }] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
    //对最终数据整平
    CLLocation *location = [value firstObject];
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      
      //将得到的定位逆地理编码
      [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
          [subscriber sendError:error];
        } else {
          [subscriber sendNext:[placemarks firstObject]];//返回地标信息
          [subscriber sendCompleted];//结束
        }
      }];
      
      return [RACDisposable disposableWithBlock:^{
        
      }];
    }];
    
  }] subscribeNext:^(id x) {
    //最终订阅地理信息
    NSLog(@"地标哦信息 %@",x);
    self.addressLabel.text = [x addressDictionary][@"Name"];
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
