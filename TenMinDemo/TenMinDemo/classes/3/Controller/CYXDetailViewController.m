//
//  CYXDetailViewController.m
//  TenMinDemo
//
//  Created by 陈燕翔 on 2017/7/11.
//  Copyright © 2017年 CYXiang. All rights reserved.
//

#import "CYXDetailViewController.h"

@interface CYXDetailViewController ()
@property (nonatomic, strong) UILabel *detailLab; ///< <#注释#>
@end

@implementation CYXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.detailLab = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.detailLab.backgroundColor = [UIColor yellowColor];
    self.detailLab.textColor = [UIColor grayColor];
    self.detailLab.text = [NSString stringWithFormat:@"%@的详细内容",self.detailStr];
    [self.view addSubview:self.detailLab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
