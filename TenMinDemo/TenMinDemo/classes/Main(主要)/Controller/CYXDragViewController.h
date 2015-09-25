//
//  CYXDragViewController.h
//  抽屉效果
//
//  Created by Macx on 14/8/18.
//  Copyright (c) 2014年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  抽屉效果实现框架
 */
@interface CYXDragViewController : UIViewController

/** 左边View */
@property (nonatomic,weak) UIView * leftView;
/** 右边View */
@property (nonatomic,weak) UIView * rightView;
/** 主显示View */
@property (nonatomic,weak) UIView * mainView;

@end
