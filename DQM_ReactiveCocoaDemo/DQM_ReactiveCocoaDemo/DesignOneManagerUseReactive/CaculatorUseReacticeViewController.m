//
//  CaculatorUseReacticeViewController.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2018/12/29.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "CaculatorUseReacticeViewController.h"
#import "Caculator.h"

@interface CaculatorUseReacticeViewController ()

@end

@implementation CaculatorUseReacticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self initUI];
  
  
  
  
  
}

- (void)initUI {
  
  //例1:
  UILabel *resultLabel = ({
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, 300, 100, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label;
  });
  UILabel *equalLabel = ({
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, 340, 100, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label;
  });
  
  UITextField *firstTextField = ({
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, 180, 200, 40)];
    [self.view addSubview:textField];
    textField.placeholder = @"请填写第一个数值";
    textField.textColor = QMHexColor(@"999999");
    textField;
  });
  
  UITextField *secondTextField = ({
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, 240, 200, 40)];
    [self.view addSubview:textField];
    textField.placeholder = @"请填写第一个数值";
    textField.textColor = QMHexColor(@"999999");
    textField;
  });
  
  
  [[[RACSignal combineLatest:@[[firstTextField rac_newTextChannel], [secondTextField rac_newTextChannel]]] map:^id _Nullable(RACTuple *value) {

    double result = [value[0] doubleValue] + [value[1] doubleValue];
    resultLabel.text = [NSString stringWithFormat:@"%f",result];
    return @(result);

  }] subscribeNext:^(NSNumber *x) {

    equalLabel.text = [x doubleValue] == 12  ? @"等于12" : @"不等于12";

  }];
  
  
  
  
  //例2:
  UILabel *caculatorLabel = ({
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, 460, 100, 40)];
    label.text = @"0.00";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label;
  });
  UILabel *caculatorEqualLabel = ({
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth-60)/2, 500, 100, 40)];
    label.text = @"不等于";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label;
  });
  
  
  //+10 按钮
  UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-100)/2, 400, 100, 40) buttonTitle:@"加10" normalColor:[UIColor blueColor] cornerRadius:4 doneBlock:^(UIButton *sender) {
    
    Caculator *caculator = [Caculator sharedInstance];
    [[caculator add:^double(double result) {
      
      result += 10;
      
      return result;
    }] equal:^BOOL(double result) {
      
      BOOL isEqual = result == 30;
      return isEqual;
    }];
    
    //显示结果
    caculatorLabel.text = [NSString stringWithFormat:@"%.2f",caculator.result];
    caculatorEqualLabel.text = [NSString stringWithFormat:@"%@",caculator.isEqual ? @"等于" : @"不等于"];
  }];
  [self.view addSubview:addButton];
  
  
  
  
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
