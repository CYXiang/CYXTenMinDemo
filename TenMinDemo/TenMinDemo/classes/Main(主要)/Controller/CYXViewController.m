//
//  CYXViewController.m
//   
//
//  Created by Macx on 15/9/24.
//  Copyright (c) 2015年 CYX. All rights reserved.
//

#import "CYXViewController.h"
#import "CYXTabBarController.h"

@interface CYXViewController ()

@end

@implementation CYXViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //    // 如果A控制器的view成为B控制器的view的子控件,那么A控制器成为B控制器的子控制器
    //
    CYXTabBarController *tabBarVc = [[CYXTabBarController alloc] init];
    

    
    // 添加子控制器
    [self addChildViewController:tabBarVc];


}


@end
