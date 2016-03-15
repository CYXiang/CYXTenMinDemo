//
//  CYXWaterFlowLayout.h
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/7.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CYXWaterFlowLayout;

@protocol CYXWaterFlowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(CYXWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(CYXWaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(CYXWaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(CYXWaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(CYXWaterFlowLayout *)waterflowLayout;
@end

@interface CYXWaterFlowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<CYXWaterFlowLayoutDelegate> delegate;
@end
