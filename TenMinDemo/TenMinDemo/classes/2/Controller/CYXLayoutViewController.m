//
//  CYXLayoutViewController.m
//  CYCollectionViewTest
//
//  Created by Macx on 16/3/6.
//  Copyright © 2016年 cyx. All rights reserved.
//

#import "CYXLayoutViewController.h"
#import "CYXPhotoViewLayout.h"
#import "CYXPhotoCell.h"

@interface CYXLayoutViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation CYXLayoutViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CYXPhotoViewLayout *layout = [[CYXPhotoViewLayout alloc]init];
    
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    layout.itemSize = CGSizeMake(230, 350);
    
    // 创建collection 设置尺寸
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = self.view.frame.size.height;
    CGFloat collectionX = 0;
    CGFloat collectionY = 0;

    CGRect frame = CGRectMake(collectionX, collectionY, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor colorWithRed:68/255.0 green:83/255.0 blue:244/255.0 alpha:1.0]
;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];

    // 注册cell
    [collectionView registerClass:[CYXPhotoCell class] forCellWithReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CYXPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageName = [NSString stringWithFormat:@"%zd", indexPath.item + 1];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
