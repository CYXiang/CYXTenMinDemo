//
//  CYXPhotoViewLayout.m
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/8.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import "CYXPhotoViewLayout.h"

@implementation CYXPhotoViewLayout

- (instancetype)init{

    if (self = [super init]) {
        
    }
    return self;
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout{
    
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置内边距
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获得super已经计算好的布局属性
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    // 计算collectionView最中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    

    // 在原有布局属性的基础上，进行微调
    for (UICollectionViewLayoutAttributes *attrs in attributes) {
        // cell的中心点x 和 collectionView最中心点的x值 的间距
        CGFloat delta = ABS(attrs.center.x - centerX);
        // 根据间距值 计算 cell的缩放比例
        CGFloat scale = 1.2 - delta / self.collectionView.frame.size.width;
    
        NSLog(@"%f,%f",delta,scale);
        // 设置缩放比例
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return  attributes;
    
}


/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 */
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    // 计算出最终显示的矩形框
//    CGRect rect;
//    rect.origin.y = 0;
//    rect.origin.x = proposedContentOffset.x;
//    rect.size = self.collectionView.frame.size;
//    
//    // 获得super已经计算好的布局属性
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    
//    // 计算collectionView最中心点的x值
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
//    
//    // 存放最小的间距值
//    CGFloat minDelta = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attrs in array) {
//        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
//            minDelta = attrs.center.x - centerX;
//        }
//    }
//    
//    // 修改原有的偏移量
//    proposedContentOffset.x += minDelta;
//    return proposedContentOffset;
//}


@end
