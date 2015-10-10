//
//  CYXCell.h
//  TenMinDemo
//
//  Created by Macx on 15/10/10.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYXMenu;

@interface CYXCell : UITableViewCell

/** 菜单模型 */
@property (strong, nonatomic) CYXMenu * menu;

@end
