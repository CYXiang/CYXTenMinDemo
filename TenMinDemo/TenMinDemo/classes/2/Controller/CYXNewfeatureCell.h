//
//  CYXNewfeatureCell.h
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/4.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYXNewfeatureCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *image;

- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

@end
