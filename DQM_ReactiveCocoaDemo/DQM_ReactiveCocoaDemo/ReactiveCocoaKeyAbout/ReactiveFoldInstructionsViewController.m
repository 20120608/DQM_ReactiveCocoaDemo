//
//  ReactiveFoldInstructionsViewController.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2019/1/2.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "ReactiveFoldInstructionsViewController.h"
#import "DQMLabelSizeToFitTableViewCell.h"                //自适应行高的cell

@interface ReactiveFoldInstructionsViewController ()


@end

@implementation ReactiveFoldInstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.defaultOpen = false;//设置开始时候是折叠的
  
  self.addItem([DQMTeam initTeamWithName:@"假设想监听文本框的内容，并且在每次输出结果的时候，都在文本框的内容拼接一段文字“输出：%@" sortNumber:@"0" destVc:nil extensionDictionary:nil], @"bind", 0)
  .addItem([DQMTeam initTeamWithName:@"flattenMap，Map用于把源信号内容映射成新的内容。监听文本框的内容改变，把结构重新映射成一个新值.\n\nflattenMap作用:把源信号的内容映射成一个新的信号，信号可以是任意类型。\n\nMap作用:把源信号的值映射成一个新的值" sortNumber:@"0" destVc:nil extensionDictionary:nil], @"flattenMap，Map", 1);
  
  
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  DQMLabelSizeToFitTableViewCell *cell = [DQMLabelSizeToFitTableViewCell cellWithTableView:tableView];
  
  NSString *contnetText = ((DQMTeam *)self.groups[indexPath.section].teams[indexPath.row]).name;
  cell.contentText = [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:contnetText font:AdaptedFontSize(14) rangeOfFont:NSMakeRange(0, [contnetText length]) color:QMTextColor rangeOfColor:NSMakeRange(0, [contnetText length])];
  return cell;
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

- (NSMutableAttributedString *)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
  NSString *titleString = @"字段说明";
  return [QMSGeneralHelpers changeStringToMutableAttributedStringTitle:titleString font:KQMFont(16) rangeOfFont:NSMakeRange(0, [titleString length]) color:QMHexColor(@"ff4499") rangeOfColor:NSMakeRange(0, [titleString length])];
}



@end
