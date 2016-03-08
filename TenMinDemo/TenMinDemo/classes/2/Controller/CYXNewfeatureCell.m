//
//  CYXNewfeatureCell.m
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/4.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import "CYXNewfeatureCell.h"
#import "CYXTabBarController.h"

@interface CYXNewfeatureCell ()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation CYXNewfeatureCell

- (IBAction)start {
        
    // 跳转到主框架界面
    // 跳转方式:push,modal
    
    // 创建UINavigationController
    UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:[[CYXTabBarController alloc]init]];
    
    // 切换窗口的根控制器进行跳转
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    
    CATransition *anim = [CATransition animation];
    anim.type = @"pageCurl";
    anim.duration = 1;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];

    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    //为imageView赋值
    self.imageView.image = image;
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count{

    if (indexPath.row == count - 1) { // 判断下是否是最后一个cell
        // 显示体验按钮
        self.startButton.hidden = NO;
        
    }else{
        // 隐藏体验按钮
        self.startButton.hidden = YES;
    }
    
}

@end
