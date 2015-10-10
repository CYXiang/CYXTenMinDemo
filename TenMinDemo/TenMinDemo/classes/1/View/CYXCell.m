//
//  CYXCell.m
//  TenMinDemo
//
//  Created by Macx on 15/10/10.
//  Copyright © 2015年 CYX. All rights reserved.
//

#import "CYXCell.h"
#import "CYXMenu.h"
#import <UIImageView+WebCache.h>

@interface CYXCell ()

@property (weak, nonatomic) IBOutlet UIImageView *albumsImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *ingredientsLabel;

@end

@implementation CYXCell

- (void)setMenu:(CYXMenu *)menu{
    
    _menu = menu;
    
    // 利用SDWebImage框架加载图片资源
    [self.albumsImageView sd_setImageWithURL:[NSURL URLWithString:menu.albums]];
    
    // 设置标题
    self.titleLable.text = menu.title;
    
    // 设置材料数据
    self.ingredientsLabel.text = menu.ingredients;
    
}

@end
