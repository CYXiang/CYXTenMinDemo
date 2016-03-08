//
//  CYXWaterFlowLayout.m
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/7.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import "CYXWaterFlowLayout.h"

/** 默认的列数 */
static const NSInteger XMGDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat XMGDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat XMGDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets XMGDefaultEdgeInsets = {10, 10, 10, 10};

@interface CYXWaterFlowLayout()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
@end

@implementation CYXWaterFlowLayout

- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < XMGDefaultColumnCount; i++) {
        [self.columnHeights addObject:@(XMGDefaultEdgeInsets.top)];
    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    // 设置布局属性的frame
    CGFloat w = (collectionViewW - XMGDefaultEdgeInsets.left - XMGDefaultEdgeInsets.right - (XMGDefaultColumnCount - 1) * XMGDefaultColumnMargin) / XMGDefaultColumnCount;
    CGFloat h = 50 + arc4random_uniform(100);
    
    // 找出高度最短的那一列
    //    __block NSInteger destColumn = 0;
    //    __block CGFloat minColumnHeight = MAXFLOAT;
    //    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber *columnHeightNumber, NSUInteger idx, BOOL *stop) {
    //        CGFloat columnHeight = columnHeightNumber.doubleValue;
    //        if (minColumnHeight > columnHeight) {
    //            minColumnHeight = columnHeight;
    //            destColumn = idx;
    //        }
    //    }];
    
    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < XMGDefaultColumnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = XMGDefaultEdgeInsets.left + destColumn * (w + XMGDefaultColumnMargin);
    CGFloat y = minColumnHeight;
    if (y != XMGDefaultEdgeInsets.top) {
        y += XMGDefaultRowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < XMGDefaultColumnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + XMGDefaultEdgeInsets.bottom);
}



@end
