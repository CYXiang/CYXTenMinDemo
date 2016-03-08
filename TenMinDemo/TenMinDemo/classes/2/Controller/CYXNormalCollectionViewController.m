//
//  CYXNormalCollectionViewController.m
//  CYCollectionViewTest
//
//  Created by apple开发 on 16/3/4.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import "CYXNormalCollectionViewController.h"
#import "CYXNormalCell.h"

@interface CYXNormalCollectionViewController ()

@end

@implementation CYXNormalCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // UICollectionViewFlowLayout流水布局的内部成员属性有以下：
    /**
     @property (nonatomic) CGFloat minimumLineSpacing;
     @property (nonatomic) CGFloat minimumInteritemSpacing;
     @property (nonatomic) CGSize itemSize;
     @property (nonatomic) CGSize estimatedItemSize NS_AVAILABLE_IOS(8_0); // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
     @property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
     @property (nonatomic) CGSize headerReferenceSize;
     @property (nonatomic) CGSize footerReferenceSize;
     @property (nonatomic) UIEdgeInsets sectionInset;
     */
    // 定义大小
    layout.itemSize = CGSizeMake(100, 100);
    // 设置最小行间距
    layout.minimumLineSpacing = 20;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 0;
    // 设置滚动方向（默认垂直滚动）
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置边缘的间距，默认是{0，0，0，0}
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"普通用法";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.frame = self.view.bounds;
    // Register cell classes
//    [self.collectionView registerClass:[CYXNormalCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // 通过xib注册
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CYXNormalCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYXNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
}



@end
