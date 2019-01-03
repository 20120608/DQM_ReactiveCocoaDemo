//
//  RACColorChangeViewController.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2018/12/29.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "RACColorChangeViewController.h"

@interface RACColorChangeViewController ()

@end

@implementation RACColorChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


  [self initUI];
  

}


- (void)initUI {
  
  
  
  UISlider *redSlider = ({
    UISlider *view = [[UISlider alloc] init];
    [self.view addSubview: view];
    view.tintColor = UIColor.redColor;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.view.mas_left).offset(50);
      make.top.mas_equalTo(self.view.mas_top).offset(100);
      make.right.mas_equalTo(self.view.mas_right).offset(-110);
      make.height.mas_equalTo(40);
    }];
    view;
  });
  UITextField *redTextField = ({
    UITextField *label = [[UITextField alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(redSlider.mas_right).offset(11);
      make.top.mas_equalTo(redSlider.mas_top);
      make.right.mas_equalTo(self.view.mas_right);
    }];
    label;
  });
  
  
  UISlider *greenSlider = ({
    UISlider *view = [[UISlider alloc] init];
    [self.view addSubview: view];
    view.tintColor = UIColor.greenColor;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.view.mas_left).offset(50);
      make.top.mas_equalTo(self.view.mas_top).offset(140);
      make.right.mas_equalTo(self.view.mas_right).offset(-110);
      make.height.mas_equalTo(40);
    }];
    view;
  });
  UITextField *greenTextField = ({
    UITextField *label = [[UITextField alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(greenSlider.mas_right).offset(11);
      make.top.mas_equalTo(greenSlider.mas_top);
      make.right.mas_equalTo(self.view.mas_right);
    }];
    label;
  });
  
  UISlider *blueSlider = ({
    UISlider *view = [[UISlider alloc] init];
    [self.view addSubview: view];
    view.tintColor = UIColor.blueColor;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.view.mas_left).offset(50);
      make.top.mas_equalTo(self.view.mas_top).offset(180);
      make.right.mas_equalTo(self.view.mas_right).offset(-110);
      make.height.mas_equalTo(40);
    }];
    view;
  });
  UITextField *blueTextField = ({
    UITextField *label = [[UITextField alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(blueSlider.mas_right).offset(11);
      make.top.mas_equalTo(blueSlider.mas_top);
      make.right.mas_equalTo(self.view.mas_right);
    }];
    label;
  });
  
  
  redTextField.text = greenTextField.text = blueTextField.text = @"0.0";
  
  UIView *colorView = ({
    UIView *view = [[UIView alloc] init];
    [self.view addSubview: view];
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.view.mas_left).offset(40);
      make.right.mas_equalTo(self.view.mas_right).offset(-40);
      make.top.mas_equalTo(blueSlider.mas_bottom).offset(60);
      make.height.mas_equalTo(150);
    }];
    view;
  });
  
  RACSignal *r = [self blindSlider:redSlider textField:redTextField];
  RACSignal *g = [self blindSlider:greenSlider textField:greenTextField];
  RACSignal *b = [self blindSlider:blueSlider textField:blueTextField];
  
  RACSignal *changeColorSignal = [[RACSignal combineLatest:@[r,g,b]] map:^id _Nullable(RACTuple *value) {
   return [UIColor colorWithRed:[value[0] floatValue] green:[value[1] floatValue] blue:[value[2] floatValue] alpha:1];
  }];
  //用宏定义也可以实现订阅的功能
  RAC(colorView,backgroundColor) = changeColorSignal;
  
}


//双向绑定写法
- (RACSignal *)blindSlider:(UISlider *)slider textField:(UITextField *)textField {
  
  //默认触发一次不然没初始值
  RACSignal *textSignal = [[textField rac_textSignal] take:1];;
  
  RACChannelTerminal *sliderTerminal = [slider rac_newValueChannelWithNilValue:nil];
  RACChannelTerminal *textFieldTerminal = [textField rac_newTextChannel];
  
  //用映射 进度条取小数2位
  [[sliderTerminal map:^id _Nullable(id  _Nullable value) {
    return [NSString stringWithFormat:@"%.02f",[value floatValue]];
  }] subscribe:textFieldTerminal];
  [textFieldTerminal subscribe:sliderTerminal];

  return [[sliderTerminal merge:textFieldTerminal] merge:textSignal];
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
