//
//  CYXPhotoCell.m
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/8.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import "CYXPhotoCell.h"

@interface CYXPhotoCell ()

@property (nonatomic, weak) UIImageView *imageView; /**< <#注释#> */

@end

@implementation CYXPhotoCell



- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15.0;
        
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName{
    
    _imageName = [imageName copy];
    
    self.imageView.image = [UIImage imageNamed:imageName];
    
}

@end
