//
//  RACTextFieldTextViewController.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2018/12/28.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "RACTextFieldTextViewController.h"

@interface RACTextFieldTextViewController ()

@end

@implementation RACTextFieldTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
  UITextField *nameTextField = ({
    UITextField *textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    textField.placeholder = @"请填写您的账号";
    textField.textColor = QMHexColor(@"999999");
    textField.font = kQmFont(16);
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(11);
      make.right.mas_equalTo(-11);
      make.height.mas_equalTo(44);
      make.top.mas_equalTo(100);
    }];
    textField;
  });
  
  UITextField *passwordTextField = ({
    UITextField *textField = [[UITextField alloc] init];
    [self.view addSubview:textField];
    textField.placeholder = @"请填写您的密码";
    textField.textColor = QMHexColor(@"999999");
    textField.font = kQmFont(16);
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(11);
      make.right.mas_equalTo(-11);
      make.height.mas_equalTo(44);
      make.top.mas_equalTo(160);
    }];
    textField;
  });
  
  UIButton *loginButton = ({
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero buttonTitle:@"登入" normalBGColor:UIColor.blueColor selectBGColor:UIColor.blueColor normalColor:UIColor.whiteColor selectColor:UIColor.blueColor buttonFont:kQmFont(16) cornerRadius:4 doneBlock:^(UIButton *sender) {
      NSLog(@"登入");
    }];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.mas_equalTo(self.view.mas_centerX);
      make.size.mas_equalTo(CGSizeMake(100, 50));
      make.top.mas_equalTo(passwordTextField.mas_bottom).offset(10);
    }];
    button;
  });
  
  
  
  
  RACSignal *enableSignal = [[RACSignal combineLatest:@[nameTextField.rac_textSignal,passwordTextField.rac_textSignal]] map:^id _Nullable(id  _Nullable value) {
    NSLog(@"合并的元组：%@",value);
    return @([value[0] length] >= 1 && [value[1] length] >= 6);
  }];
  
  //要有触发用到enableSignal上面的map才会触发 因为racsignal是拉驱动
  loginButton.rac_command = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    return [RACSignal empty];
  }];
  
  
  
}

@end
